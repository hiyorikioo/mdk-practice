#!/bin/bash
# Дополнительное задание 3: информация о системе
# хост, ядро, свободная память, процессы, пользователь, время работы

echo "=== Информация о системе ==="

echo "Имя хоста: $(hostname)"
echo "Версия ядра: $(uname -r)"
echo "Текущий пользователь: $(whoami)"

# /proc/meminfo хранит память в килобайтах, переводим в мегабайты
mem_total_kb=$(grep MemTotal /proc/meminfo | awk '{print $2}')
mem_free_kb=$(grep MemFree /proc/meminfo | awk '{print $2}')
echo "Память: свободно $((mem_free_kb / 1024)) МБ из $((mem_total_kb / 1024)) МБ"

# первое число в /proc/uptime — секунды с момента включения
# (дробную часть отбрасываем через %.*)
uptime_raw=$(cut -d' ' -f1 /proc/uptime)
uptime_sec=${uptime_raw%.*}
up_hours=$((uptime_sec / 3600))
up_minutes=$((uptime_sec % 3600 / 60))
echo "Время работы системы: $up_hours ч $up_minutes мин"

echo
echo "=== Запущенные процессы (первые 15) ==="
# tasklist пишет в кодировке cp866, перекодируем для читаемости
tasklist | iconv -f cp866 -t utf-8 | head -18
