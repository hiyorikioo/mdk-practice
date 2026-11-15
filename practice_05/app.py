"""Практика 5. Добавление задач через HTML-форму (GET/POST)."""
import sqlite3
from pathlib import Path

from flask import Flask, redirect, render_template, request, url_for

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


def save_task(task_title):
    connection = sqlite3.connect(DB_FILE)
    try:
        connection.execute("INSERT INTO tasks (title) VALUES (?)", (task_title,))
        connection.commit()
    finally:
        connection.close()


@web_app.route("/", methods=["GET", "POST"])
def task_page():
    if request.method == "POST":
        entered_title = request.form.get("title", "").strip()
        if not entered_title:
            # Пустой ввод: ничего не сохраняем, показываем страницу с ошибкой
            return render_template(
                "index.html",
                task_list=load_tasks(),
                error_text="Название задачи не может быть пустым.",
            ), 400
        save_task(entered_title)
        # PRG: после POST перенаправляем на GET, чтобы F5 не добавлял задачу повторно
        return redirect(url_for("task_page"))

    task_list = load_tasks()
    return render_template("index.html", task_list=task_list, error_text=None)


prepare_database()

if __name__ == "__main__":
    web_app.run(debug=True, port=5000)
