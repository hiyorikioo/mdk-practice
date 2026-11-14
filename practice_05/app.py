"""Практика 5. Добавление задач через HTML-форму (GET/POST)."""
import sqlite3
from pathlib import Path

from flask import Flask, render_template

DB_FILE = Path(__file__).with_name("app.db")

web_app = Flask(__name__)

DEMO_TASKS = [
    ("Повторить SQL-запросы", "done"),
    ("Сделать практику 5", "new"),
    ("Подготовиться к аттестации", "new"),
]


def prepare_database():
    """Создаёт таблицу и добавляет примеры, если задач ещё нет."""
    connection = sqlite3.connect(DB_FILE)
    try:
        connection.execute(
            """CREATE TABLE IF NOT EXISTS tasks (
                   id     INTEGER PRIMARY KEY,
                   title  TEXT NOT NULL,
                   status TEXT DEFAULT 'new'
               )"""
        )
        tasks_count = connection.execute("SELECT COUNT(*) FROM tasks").fetchone()[0]
        if tasks_count == 0:
            connection.executemany(
                "INSERT INTO tasks (title, status) VALUES (?, ?)", DEMO_TASKS
            )
        connection.commit()
    finally:
        connection.close()


def load_tasks():
    connection = sqlite3.connect(DB_FILE)
    connection.row_factory = sqlite3.Row
    try:
        return connection.execute(
            "SELECT id, title, status FROM tasks ORDER BY id"
        ).fetchall()
    finally:
        connection.close()


@web_app.route("/")
def task_page():
    task_list = load_tasks()
    return render_template("index.html", task_list=task_list)


prepare_database()

if __name__ == "__main__":
    web_app.run(debug=True, port=5000)
