#!/bin/bash
# Домашнее задание 3: свойства числа через остаток от деления %

read -p "Введите целое число: " checked_num

echo "---"

if (( checked_num % 2 == 0 )); then
    echo "$checked_num — чётное"
else
    echo "$checked_num — нечётное"
fi

if (( checked_num % 3 == 0 )); then
    echo "Делится на 3 без остатка"
else
    echo "На 3 не делится (остаток $((checked_num % 3)))"
fi

if (( checked_num % 5 == 0 )); then
    echo "Делится на 5 без остатка"
else
    echo "На 5 не делится (остаток $((checked_num % 5)))"
fi
