"""Практика 7. Итоговый мини-проект: список задач с добавлением, отметкой и удалением."""
import sqlite3
from pathlib import Path

from flask import Flask, redirect, render_template, request, url_for

DB_FILE = Path(__file__).with_name("app.db")

web_app = Flask(__name__)

DEMO_TASKS = [
    ("Повторить SQL-запросы", "done"),
    ("Сделать практику 7", "new"),
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
    except sqlite3.Error as db_error:
        connection.rollback()
        print("Ошибка при подготовке базы:", db_error)
    finally:
        connection.close()


def fetch_all_tasks():
    """Возвращает список задач или пустой список, если чтение не удалось."""
    connection = sqlite3.connect(DB_FILE)
    connection.row_factory = sqlite3.Row
    try:
        return connection.execute(
            "SELECT id, title, status FROM tasks ORDER BY id"
        ).fetchall()
    except sqlite3.Error as db_error:
        print("Ошибка чтения задач:", db_error)
        return []
    finally:
        connection.close()


def insert_task(task_title):
    """Добавляет задачу. Возвращает True при успехе, False при ошибке."""
    connection = sqlite3.connect(DB_FILE)
    try:
        connection.execute("INSERT INTO tasks (title) VALUES (?)", (task_title,))
        connection.commit()
        return True
    except sqlite3.Error as db_error:
        connection.rollback()
        print("Ошибка добавления задачи:", db_error)
        return False
    finally:
        connection.close()


def toggle_task_status(task_id):
    """Меняет статус new <-> done. Возвращает число изменённых строк (0 - не найдена)."""
    connection = sqlite3.connect(DB_FILE)
    try:
        db_cursor = connection.execute(
            """UPDATE tasks
               SET status = CASE WHEN status = 'done' THEN 'new' ELSE 'done' END
               WHERE id = ?""",
            (task_id,),
        )
        connection.commit()
        return db_cursor.rowcount
    except sqlite3.Error as db_error:
        connection.rollback()
        print("Ошибка изменения статуса:", db_error)
        return 0
    finally:
        connection.close()


def delete_task_by_id(task_id):
    """Удаляет задачу. Возвращает число удалённых строк (0 - не найдена)."""
    connection = sqlite3.connect(DB_FILE)
    try:
        db_cursor = connection.execute("DELETE FROM tasks WHERE id = ?", (task_id,))
        connection.commit()
        return db_cursor.rowcount
    except sqlite3.Error as db_error:
        connection.rollback()
        print("Ошибка удаления задачи:", db_error)
        return 0
    finally:
        connection.close()


@web_app.route("/delete/<int:task_id>", methods=["POST"])
def delete_route(task_id):
    delete_task_by_id(task_id)
    return redirect(url_for("task_page"))


@web_app.route("/toggle/<int:task_id>", methods=["POST"])
def toggle_route(task_id):
    toggle_task_status(task_id)
    return redirect(url_for("task_page"))


@web_app.route("/", methods=["GET", "POST"])
def task_page():
    if request.method == "POST":
        entered_title = request.form.get("title", "").strip()
        if not entered_title:
            # Пустой ввод: ничего не сохраняем, показываем страницу с ошибкой
            return render_template(
                "index.html",
                task_list=fetch_all_tasks(),
                error_text="Введите название задачи.",
            ), 400
        if not insert_task(entered_title):
            # Ошибка базы: изменения уже откатаны, сообщаем пользователю
            return render_template(
                "index.html",
                task_list=fetch_all_tasks(),
                error_text="Не удалось сохранить задачу. Попробуйте ещё раз.",
            ), 500
        # PRG: после POST перенаправляем на GET, чтобы F5 не добавлял задачу повторно
        return redirect(url_for("task_page"))

    task_list = fetch_all_tasks()
    return render_template("index.html", task_list=task_list, error_text=None)


prepare_database()

if __name__ == "__main__":
    web_app.run(debug=True, port=5000)
