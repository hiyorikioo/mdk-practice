#!/bin/bash
# Скрипт 8: ввод чисел с клавиатуры и проверка деления на ноль

read -p "Введите первое число: " input_first
read -p "Введите второе число: " input_second

echo "---"
echo "Сумма: $((input_first + input_second))"
echo "Разность: $((input_first - input_second))"
echo "Произведение: $((input_first * input_second))"

# Делить можно, только если второе число не ноль
if [ "$input_second" -ne 0 ]; then
    echo "Деление: $((input_first / input_second))"
    echo "Остаток: $((input_first % input_second))"
else
    echo "Деление на ноль невозможно"
fi
