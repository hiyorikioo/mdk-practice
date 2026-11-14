"""Практика 4. Вывод задач из SQLite через шаблон Jinja2."""
from flask import Flask, render_template

web_app = Flask(__name__)


@web_app.route("/")
def task_page():
    task_list = []
    return render_template("index.html", task_list=task_list)


if __name__ == "__main__":
    web_app.run(debug=True, port=5000)
