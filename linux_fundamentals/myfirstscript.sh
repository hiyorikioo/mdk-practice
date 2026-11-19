#!/bin/bash
# Часть 5: мой первый скрипт — дата, папка, лог, сеть, место на диске
# Работает в папке практики, чтобы logs/ не попадал в репозиторий

work_dir=~/linux_practice
mkdir -p "$work_dir"
cd "$work_dir" || exit 1

# 1. Текущая дата и время
echo "=== Текущая дата и время ==="
date

# 2. Текущая директория и её содержимое
echo "=== Текущая директория ==="
pwd
ls -la

# 3. Папка для логов (-p: без ошибки, если уже есть)
mkdir -p logs
log_file=logs/info.log

# 4. Запись информации в лог: > создаёт файл заново, >> дописывает
echo "Дата: $(date)" > "$log_file"
echo "Пользователь: $(whoami)" >> "$log_file"
echo "Система: $(uname -a)" >> "$log_file"

# 5. Содержимое лога
echo "=== Содержимое лога ==="
cat "$log_file"

# 6. Проверка сети: 2 пакета до DNS Google
# в Windows у ping ключ -n, в Linux -c
echo "=== Проверка сети ==="
if [ "$(uname -o)" = "Msys" ]; then
    ping -n 2 8.8.8.8 > /dev/null 2>&1
else
    ping -c 2 8.8.8.8 > /dev/null 2>&1
fi
# $? — код завершения последней команды: 0 значит успех
if [ $? -eq 0 ]; then
    echo "Сеть доступна"
else
    echo "Сеть недоступна"
fi

# 7. Свободное место на диске
# /home есть в Linux; в Git Bash смотрим диск домашней папки
echo "=== Свободное место ==="
if [ -d /home ] && [ "$(uname -o)" != "Msys" ]; then
    df -h /home
else
    df -h ~
fi

echo "=== Готово! ==="
