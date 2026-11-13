"""Практика 3. Первое веб-приложение на Flask: две страницы."""
from flask import Flask

web_app = Flask(__name__)

PAGE_STYLE = "font-family: sans-serif; max-width: 600px; margin: 40px auto;"


@web_app.route("/")
def home_page():
    return f"""
    <div style="{PAGE_STYLE}">
        <h1>Список задач</h1>
        <p>Главная страница учебного приложения на Flask.</p>
        <a href="/about">О проекте</a>
    </div>
    """


@web_app.route("/about")
def about_page():
    return f"""
    <div style="{PAGE_STYLE}">
        <h1>О проекте</h1>
        <p>Учебный проект по МДК: клиент-серверное приложение
           на Python, Flask и SQLite.</p>
        <p>Автор: Нехланова Алина Андреевна</p>
        <a href="/">На главную</a>
    </div>
    """


if __name__ == "__main__":
    web_app.run(debug=True, port=5000)
