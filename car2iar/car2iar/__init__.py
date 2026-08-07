"""car2iar: offline splitter turning an OIC project archive (.car) into per-integration .iar files."""

from .core import CarError, Integration, convert, find_integrations, list_entries

__all__ = ["CarError", "Integration", "convert", "find_integrations", "list_entries"]
__version__ = "1.0.0"
