#!/bin/bash
# Скрипт 12: сумма чисел от 1 до N в цикле while

read -p "Введите N: " upper_limit

range_sum=0
current_num=1

while [ "$current_num" -le "$upper_limit" ]; do
    range_sum=$((range_sum + current_num))
    current_num=$((current_num + 1))
done

echo "Сумма чисел от 1 до $upper_limit = $range_sum"
