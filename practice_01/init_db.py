"""Практика 1. Создание базы данных SQLite и таблицы задач."""
import sqlite3
from pathlib import Path

DB_FILE = Path(__file__).with_name("app.db")

CREATE_TASKS_SQL = """
CREATE TABLE IF NOT EXISTS tasks (
    id     INTEGER PRIMARY KEY,
    title  TEXT NOT NULL,
    status TEXT DEFAULT 'new'
)
"""


def create_database():
    connection = sqlite3.connect(DB_FILE)
    try:
        db_cursor = connection.cursor()
        db_cursor.execute(CREATE_TASKS_SQL)
        connection.commit()
        print(f"База данных готова: {DB_FILE}")
    finally:
        connection.close()


if __name__ == "__main__":
    create_database()
