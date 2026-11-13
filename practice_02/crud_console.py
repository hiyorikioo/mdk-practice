"""Практика 2. Консольное CRUD-приложение для таблицы tasks."""
import sqlite3
from pathlib import Path

DB_FILE = Path(__file__).with_name("app.db")


def read_line(prompt_text):
    """input() без пробелов по краям и без BOM (бывает при вводе из PowerShell)."""
    return input(prompt_text).replace("﻿", "").strip()


def get_connection():
    connection = sqlite3.connect(DB_FILE)
    connection.execute(
        """CREATE TABLE IF NOT EXISTS tasks (
               id     INTEGER PRIMARY KEY,
               title  TEXT NOT NULL,
               status TEXT DEFAULT 'new'
           )"""
    )
    return connection


def print_tasks(connection):
    all_rows = connection.execute(
        "SELECT id, title, status FROM tasks ORDER BY id"
    ).fetchall()
    if not all_rows:
        print("Список задач пуст.")
        return
    for task_id, task_title, task_status in all_rows:
        mark = "[x]" if task_status == "done" else "[ ]"
        print(f"{task_id:>3}. {mark} {task_title}")


def add_task(connection):
    new_title = read_line("Название задачи: ")
    if not new_title:
        print("Название не может быть пустым.")
        return
    db_cursor = connection.execute(
        "INSERT INTO tasks (title) VALUES (?)", (new_title,)
    )
    connection.commit()
    print(f"Задача добавлена, id = {db_cursor.lastrowid}")


def ask_task_id():
    raw_value = read_line("Введите id задачи: ")
    if not raw_value.isdigit():
        print("id должен быть числом.")
        return None
    return int(raw_value)


def mark_done(connection):
    selected_id = ask_task_id()
    if selected_id is None:
        return
    db_cursor = connection.execute(
        "UPDATE tasks SET status = 'done' WHERE id = ?", (selected_id,)
    )
    connection.commit()
    if db_cursor.rowcount == 0:
        print("Задача с таким id не найдена.")
    else:
        print("Задача отмечена как выполненная.")


def remove_task(connection):
    selected_id = ask_task_id()
    if selected_id is None:
        return
    answer = read_line(f"Удалить задачу {selected_id}? (y/n): ").lower()
    if answer != "y":
        print("Удаление отменено.")
        return
    db_cursor = connection.execute(
        "DELETE FROM tasks WHERE id = ?", (selected_id,)
    )
    connection.commit()
    if db_cursor.rowcount == 0:
        print("Задача с таким id не найдена.")
    else:
        print("Задача удалена.")


MENU_TEXT = """
1 - показать задачи
2 - добавить задачу
3 - отметить выполненной
4 - удалить задачу
0 - выход"""


def main():
    connection = get_connection()
    actions = {
        "1": print_tasks,
        "2": add_task,
        "3": mark_done,
        "4": remove_task,
    }
    try:
        while True:
            print(MENU_TEXT)
            choice = read_line("Выберите пункт: ")
            if choice == "0":
                print("До свидания!")
                break
            handler = actions.get(choice)
            if handler is None:
                print("Нет такого пункта меню.")
            else:
                handler(connection)
    finally:
        connection.close()


if __name__ == "__main__":
    main()
