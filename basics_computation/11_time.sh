#!/bin/bash
# Скрипт 11: перевод секунд в часы, минуты и секунды
# Задание 6: число можно передать аргументом (./11_time.sh 3661),
# а если аргумента нет — скрипт спросит его сам

if [ -z "$1" ]; then
    read -p "Введите количество секунд: " seconds_total
else
    seconds_total="$1"
fi

full_hours=$((seconds_total / 3600))
left_after_hours=$((seconds_total % 3600))
full_minutes=$((left_after_hours / 60))
left_seconds=$((left_after_hours % 60))

echo "---"
echo "$seconds_total секунд = $full_hours ч $full_minutes мин $left_seconds с"
