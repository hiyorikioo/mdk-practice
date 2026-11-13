"""Практика 1. Проверка: какие таблицы есть в базе."""
import sqlite3
from pathlib import Path

DB_FILE = Path(__file__).with_name("app.db")


def show_tables():
    if not DB_FILE.exists():
        print("Файл базы не найден. Сначала запустите init_db.py")
        return

    connection = sqlite3.connect(DB_FILE)
    try:
        rows = connection.execute(
            "SELECT name FROM sqlite_master WHERE type = 'table'"
        ).fetchall()
    finally:
        connection.close()

    print("Таблицы в базе:")
    for (table_name,) in rows:
        print(" -", table_name)


if __name__ == "__main__":
    show_tables()
