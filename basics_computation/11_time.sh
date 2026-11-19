#!/bin/bash
# Скрипт 11: перевод секунд в часы, минуты и секунды

read -p "Введите количество секунд: " seconds_total

full_hours=$((seconds_total / 3600))
left_after_hours=$((seconds_total % 3600))
full_minutes=$((left_after_hours / 60))
left_seconds=$((left_after_hours % 60))

echo "---"
echo "$seconds_total секунд = $full_hours ч $full_minutes мин $left_seconds с"
