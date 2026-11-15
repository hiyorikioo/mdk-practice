"""Практика 7. Проверка всего приложения.

Запуск: python test_app.py
Использует временную базу, рабочая app.db не меняется.
"""
import sqlite3
import tempfile
from pathlib import Path

import app as todo_app

results = []


def check(description, condition):
    results.append(condition)
    print("OK  " if condition else "FAIL", description)


def task_rows():
    connection = sqlite3.connect(todo_app.DB_FILE)
    try:
        return connection.execute("SELECT id, title, status FROM tasks ORDER BY id").fetchall()
    finally:
        connection.close()


def main():
    with tempfile.TemporaryDirectory() as temp_dir:
        todo_app.DB_FILE = Path(temp_dir) / "test.db"
        todo_app.prepare_database()
        client = todo_app.web_app.test_client()

        # Главная страница
        check("GET / открывается (200)", client.get("/").status_code == 200)
        check("в базе 3 демо-задачи", len(task_rows()) == 3)

        # Добавление
        response = client.post("/", data={"title": "  Тестовая задача  "})
        check("POST / добавляет задачу и делает redirect (302)", response.status_code == 302)
        check("название сохранено без пробелов", task_rows()[-1][1] == "Тестовая задача")
        check("пустое название отклонено (400)", client.post("/", data={"title": "  "}).status_code == 400)
        check("после пустого ввода задач по-прежнему 4", len(task_rows()) == 4)

        # Переключение статуса
        new_id = task_rows()[-1][0]
        client.post(f"/toggle/{new_id}")
        check("toggle: new -> done", task_rows()[-1][2] == "done")
        client.post(f"/toggle/{new_id}")
        check("toggle: done -> new", task_rows()[-1][2] == "new")

        # Удаление
        client.post(f"/delete/{new_id}")
        check("delete удаляет задачу", all(row[0] != new_id for row in task_rows()))
        response = client.post("/delete/9999")
        check("delete несуществующей -> 404 и сообщение",
              response.status_code == 404
              and "Задача #9999 не найдена." in response.get_data(as_text=True))
        response = client.post("/toggle/9999")
        check("toggle несуществующей -> 404 и сообщение",
              response.status_code == 404
              and "Задача #9999 не найдена." in response.get_data(as_text=True))
        check("GET /toggle/abc -> 404", client.get("/toggle/abc").status_code == 404)

        # Действия только через POST
        check("GET /toggle/1 -> 405", client.get("/toggle/1").status_code == 405)
        check("GET /delete/1 -> 405", client.get("/delete/1").status_code == 405)

        # Ошибка БД: NOT NULL
        rows_before = len(task_rows())
        check("insert_task(None) возвращает False", todo_app.insert_task(None) is False)
        check("после ошибки мусорной строки нет", len(task_rows()) == rows_before)

    print()
    print(f"Пройдено {sum(results)} из {len(results)}")


if __name__ == "__main__":
    main()
