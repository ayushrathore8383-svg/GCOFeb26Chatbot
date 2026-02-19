import sqlite3

conn = sqlite3.connect("inventory.db")
cur = conn.cursor()

tables = cur.execute("""
SELECT name
FROM sqlite_master
WHERE type='table' AND name NOT LIKE 'sqlite_%'
ORDER BY name;
""").fetchall()

print("Tables:", tables)

for (t,) in tables:
    cols = cur.execute(f"PRAGMA table_info({t});").fetchall()
    print(f"\nTable: {t}")
    print("Columns:", [c[1] for c in cols])

conn.close()