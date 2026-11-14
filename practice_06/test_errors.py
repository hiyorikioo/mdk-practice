"""Практика 6. Проверка обработки ошибок: намеренная ошибка NOT NULL.

Запуск: python test_errors.py
"""
import sqlite3

from app import DB_FILE, load_tasks, save_task


def count_rows():
    connection = sqlite3.connect(DB_FILE)
    try:
        return connection.execute("SELECT COUNT(*) FROM tasks").fetchone()[0]
    finally:
        connection.close()


def main():
    rows_before = count_rows()
    print("Задач до проверки:", rows_before)

    # 1. Намеренная ошибка: title = None нарушает ограничение NOT NULL
    insert_result = save_task(None)
    print("save_task(None) вернула:", insert_result)

    # 2. Мусорная строка не должна попасть в базу
    rows_after_error = count_rows()
    print("Задач после ошибки:", rows_after_error)

    # 3. База не заблокирована: обычная запись проходит
    normal_result = save_task("Задача после ошибки")
    rows_after_normal = count_rows()
    print("Обычная запись после ошибки:", normal_result)

    checks = {
        "ошибка поймана (False)": insert_result is False,
        "мусорной строки нет": rows_after_error == rows_before,
        "база не заблокирована": normal_result is True
        and rows_after_normal == rows_before + 1,
        "чтение работает": len(load_tasks()) == rows_after_normal,
    }
    print()
    for check_name, passed in checks.items():
        print("OK  " if passed else "FAIL", check_name)

    if all(checks.values()):
        print("\nВсе проверки пройдены.")
    else:
        print("\nЕсть ошибки!")


if __name__ == "__main__":
    main()
