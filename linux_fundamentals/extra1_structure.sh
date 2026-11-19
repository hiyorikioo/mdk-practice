#!/bin/bash
# Дополнительное задание 1: структура папок проекта
#
# myproject/
# ├── src/
# │   ├── main/
# │   └── test/
# ├── docs/
# ├── logs/
# └── backup/

base_dir=~/linux_practice
mkdir -p "$base_dir"
cd "$base_dir" || exit 1

# -p создаёт все промежуточные папки сразу,
# {a,b} — подстановка: mkdir получает каждое имя отдельно
mkdir -p myproject/{src/{main,test},docs,logs,backup}

echo "Создана структура:"
# tree в Git Bash нет, поэтому выводим через find
find myproject -type d | sort
