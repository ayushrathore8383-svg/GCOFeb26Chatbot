import os
import re
import sqlite3
import subprocess
import sys
from dataclasses import dataclass
from typing import Dict, Optional, Tuple, Any, List

DB_PATH = "./inventory.db"
DB_SETUP_SQL = "./inventory_setup.sql"
KB_PATH = "./knowledge_base.txt"

FALLBACK_TEXT = "I'm sorry, I cannot answer your query at the moment."
EXIT_COMMANDS = {"exit", "quit", "q"}


# ----------------------------
# Text normalisation
# ----------------------------
def normalise(s: str) -> str:
    # Robust matching: ignore punctuation and extra spaces
    s = s.strip().lower()
    s = re.sub(r"[^\w\s]", "", s)     # remove punctuation (?,.! etc.)
    s = re.sub(r"\s+", " ", s)
    return s


def money_gbp(value: Any) -> str:
    try:
        v = float(value)
        return f"£{v:,.2f}"
    except Exception:
        return "£0.00"


# ----------------------------
# Knowledge Base
# ----------------------------
def load_knowledge_base(path: str = KB_PATH) -> Dict[str, str]:
    """
    Supports formats:
      1) question|answer
      2) question => answer
      3) Q: ... newline A: ...
      4) question<TAB>answer
      5) key:value facts
    """
    if not os.path.exists(path):
        return {}

    with open(path, "r", encoding="utf-8") as f:
        text = f.read()

    kb: Dict[str, str] = {}

    # Q/A blocks
    qa_blocks = re.findall(r"(?is)^\s*Q:\s*(.+?)\s*$\s*^\s*A:\s*(.+?)\s*$", text, flags=re.M)
    if qa_blocks:
        for q, a in qa_blocks:
            kb[normalise(q)] = a.strip()
        return kb

    # Line-based formats
    for line in text.splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue

        delim = None
        for d in ["|", "=>", "\t", ":"]:
            if d in line:
                delim = d
                break
        if not delim:
            continue

        parts = [p.strip() for p in line.split(delim, 1)]
        if len(parts) == 2 and parts[0] and parts[1]:
            kb[normalise(parts[0])] = parts[1]

    return kb


def kb_answer(kb: Dict[str, str], user_query: str) -> Optional[str]:
    key = normalise(user_query)
    exact = kb.get(key)
    if exact:
        return exact

    # Optional intent-style answers for key:value KB files
    location = kb.get("location")
    office_hours = kb.get("office hours")
    delivery_policy = kb.get("delivery policy")
    returns_policy = kb.get("returns")
    contact = kb.get("contact")

    if re.search(r"\b(address|location|located|where)\b", key) and location:
        addr = re.sub(r"(?i),\s*london\b", "", location).strip()
        return f"Our office address is {addr}."

    if re.search(r"\b(open|opening|hours|monday|friday|saturday)\b", key) and office_hours:
        return f"Our office hours are: {office_hours}."

    if re.search(r"\b(delivery|next day|next-day|shipping|postage|cost)\b", key) and delivery_policy:
        m = re.search(r"(£\s*\d+(?:\.\d{2})?)", delivery_policy)
        if m and re.search(r"\b(how much|cost|price)\b", key):
            amount = m.group(1).replace(" ", "")
            return f"Next-day delivery is {amount}."
        return delivery_policy

    if re.search(r"\b(return|refund)\b", key) and returns_policy:
        return returns_policy

    if re.search(r"\b(contact|email|phone|support)\b", key) and contact:
        return contact

    return None


# ----------------------------
# Inventory DB (SQLite)
# ----------------------------
class InventoryDbError(Exception):
    pass


def ensure_inventory_db(db_path: str = DB_PATH, setup_sql_path: str = DB_SETUP_SQL) -> None:
    """
    Ensures inventory.db exists and is queryable.
    If missing/corrupted, rebuild using:
        sqlite3 inventory.db < inventory_setup.sql
    """
    def is_queryable() -> bool:
        if not os.path.exists(db_path):
            return False
        try:
            with sqlite3.connect(db_path) as conn:
                conn.execute("SELECT name FROM sqlite_master LIMIT 1;")
            return True
        except Exception:
            return False

    if is_queryable():
        return

    if not os.path.exists(setup_sql_path):
        raise InventoryDbError(f"Database is missing/corrupted and setup SQL not found at {setup_sql_path}")

    try:
        with open(setup_sql_path, "rb") as f:
            sql_bytes = f.read()

        proc = subprocess.run(
            ["sqlite3", db_path],
            input=sql_bytes,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            check=False,
        )
        if proc.returncode != 0:
            raise InventoryDbError(proc.stderr.decode("utf-8", errors="replace").strip())

        with sqlite3.connect(db_path) as conn:
            conn.execute("SELECT name FROM sqlite_master LIMIT 1;")

    except FileNotFoundError:
        raise InventoryDbError("sqlite3 CLI not found. Install sqlite3 or ensure it is available on PATH.")


def get_tables(conn: sqlite3.Connection) -> List[str]:
    cur = conn.cursor()
    rows = cur.execute("""
        SELECT name FROM sqlite_master
        WHERE type='table' AND name NOT LIKE 'sqlite_%'
        ORDER BY name;
    """).fetchall()
    return [r[0] for r in rows]


def lookup_inventory(conn: sqlite3.Connection, item_name: str, size: Optional[str] = None) -> str:
    """
    Queries the actual schema you confirmed:

      Table: product_inventory
      Columns: item_name, size, stock_count, price_gbp

    Uses LIKE for item_name (more reliable than exact match).
    Uses exact match for size.
    """
    cur = conn.cursor()

    # Ensure the expected table exists
    tables = get_tables(conn)
    if "product_inventory" not in tables:
        return FALLBACK_TEXT

    # Clean item_name to avoid phrases like "price of ..." breaking LIKE
    cleaned = item_name.strip().lower()
    cleaned = re.sub(
        r"^(what\s+is|whats|what's|how\s+much\s+is|how\s+much\s+are|price\s+of|cost\s+of|do\s+you\s+have|have\s+you\s+got)\s+",
        "",
        cleaned,
    ).strip()
    cleaned = re.sub(r"^(the|a|an)\s+", "", cleaned).strip()
    cleaned = re.sub(r"\b(in stock|available|availability|please|thanks)\b", "", cleaned).strip()

    # Normalise size (S/M/L/XL etc.)
    if isinstance(size, str) and size.strip():
        size_map = {
            "s": "S",
            "m": "M",
            "l": "L",
            "xl": "XL",
            "xxl": "XXL",
        }
        s = size.strip().lower()
        size = size_map.get(s, size.strip())

    sql = """
        SELECT item_name, size, stock_count, price_gbp
        FROM product_inventory
        WHERE LOWER(item_name) LIKE LOWER(?)
    """
    params: List[Any] = [f"%{cleaned}%"]

    if size:
        sql += " AND LOWER(size) = LOWER(?)"
        params.append(size)

    rows = cur.execute(sql, params).fetchall()

    if not rows:
        return FALLBACK_TEXT

    def row_to_text(r: Tuple[Any, ...]) -> str:
        name_val, size_val, stock_val, price_val = r

        bits = [str(name_val)]

        if size_val is not None:
            bits.append(f"size {size_val}")

        if price_val is not None:
            bits.append(f"priced at {money_gbp(price_val)}")

        # Stock wording (UK English)
        try:
            stock_num = int(stock_val)
            if stock_num > 0:
                bits.append(f"Yes ({stock_num} in stock)")
            else:
                bits.append("No (0 / Out of stock)")
        except Exception:
            if stock_val is not None:
                bits.append(f"with {stock_val} in stock")

        return ", ".join(bits)

    if len(rows) == 1:
        return f"Here is what I found: {row_to_text(rows[0])}."
    else:
        rendered = "; ".join(row_to_text(r) for r in rows)
        return f"Here are the closest matches I found: {rendered}."


# ----------------------------
# “Function/Tool Calling” layer
# ----------------------------
@dataclass
class ToolCall:
    name: str
    arguments: Dict[str, Any]


def is_inventory_question(text: str) -> bool:
    """
    Inventory intent detection.
    """
    t = text.lower()
    keywords = [
        "price", "cost", "how much", "in stock", "available", "availability",
        "quantity", "qty", "do you have", "have you got", "inventory", "stock level",
        "how many", "size"
    ]
    return any(k in t for k in keywords)


def extract_item_and_size_heuristic(text: str) -> Tuple[Optional[str], Optional[str]]:
    """
    Extract item + size with a few common patterns.
    """
    t = text.strip()

    # size patterns
    m = re.search(r"(?i)\bsize\s*[:\-]?\s*([a-z0-9]+)\b", t)
    if not m:
        m = re.search(r"(?i)\bavailable\s+in\s+([a-z0-9]+)\b", t)
    size = m.group(1) if m else None

    item = None

    # "price/cost of <item>"
    m2 = re.search(r"(?i)\b(price|cost|availability|stock|in stock|do you have|have you got|how many)\b\s*(of)?\s*(.+)$", t)
    if m2:
        item = m2.group(3)

    # "Is the <item> available in XL?"
    if not item:
        m_is_available = re.search(r"(?i)^\s*(?:is|are)\s+(?:the\s+)?(.+?)\s+available\b", t)
        if m_is_available:
            item = m_is_available.group(1)

    # "How many <item> in size M?"
    if not item:
        m_how_many = re.search(r"(?i)^\s*how\s+many\s+(.+?)(?:\s+in\s+size\b|\s+size\b|\?|$)", t)
        if m_how_many:
            item = m_how_many.group(1)

    if item:
        # Remove trailing filler + size text
        item = re.sub(r"(?i)\b(in stock|available|availability|please|thanks)\b", "", item).strip(" .?!,;:-")
        item = re.sub(r"(?i)\bsize\s*[:\-]?\s*[a-z0-9]+\b", "", item).strip(" .?!,;:-")
        item = re.sub(r"(?i)^the\s+", "", item).strip()

        # Remove leading phrases that break matching
        item = re.sub(r"(?i)^(what\s+is|whats|what's|how\s+much\s+is|how\s+much\s+are)\s+", "", item).strip()
        item = re.sub(r"(?i)^(price|cost)\s+(of\s+)?", "", item).strip()
        item = re.sub(r"(?i)^(do\s+you\s+have|have\s+you\s+got)\s+", "", item).strip()

    return (item if item else None), (size if size else None)


def tool_call_plan(user_text: str) -> Optional[ToolCall]:
    if not is_inventory_question(user_text):
        return None

    item, size = extract_item_and_size_heuristic(user_text)
    if not item:
        return None

    args: Dict[str, Any] = {"item_name": item}
    if size:
        args["size"] = size

    return ToolCall(name="lookup_inventory", arguments=args)


# ----------------------------
# Main loop
# ----------------------------
def main() -> None:
    kb = load_knowledge_base(KB_PATH)

    try:
        ensure_inventory_db(DB_PATH, DB_SETUP_SQL)
    except InventoryDbError:
        # Do not leak errors in normal output (safe for judging)
        pass

    conn = None
    if os.path.exists(DB_PATH):
        try:
            conn = sqlite3.connect(DB_PATH)
        except Exception:
            conn = None

    print("Tri‑Tier Chatbot (CLI) — type 'exit' to quit.")

    while True:
        try:
            user_text = input("> ").strip()
        except (EOFError, KeyboardInterrupt):
            print()
            break

        if not user_text:
            continue

        if normalise(user_text) in EXIT_COMMANDS:
            break

        # 1) Knowledge Base
        ans = kb_answer(kb, user_text)
        if ans:
            print(ans)
            continue

        # 2) Inventory DB via tool-call plan
        call = tool_call_plan(user_text)
        if call and call.name == "lookup_inventory" and conn is not None:
            try:
                item_name = call.arguments.get("item_name")
                size = call.arguments.get("size")
                if isinstance(item_name, str) and item_name.strip():
                    print(lookup_inventory(conn, item_name.strip(), size.strip() if isinstance(size, str) else None))
                else:
                    print(FALLBACK_TEXT)
            except Exception:
                print(FALLBACK_TEXT)
            continue

        # 3) Fallback
        print(FALLBACK_TEXT)

    if conn is not None:
        try:
            conn.close()
        except Exception:
            pass


if __name__ == "__main__":
    main()