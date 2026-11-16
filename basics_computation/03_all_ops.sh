#!/bin/bash
# Скрипт 3: все арифметические операции bash (только целые числа)

num_left=17
num_right=5

echo "a = $num_left"
echo "b = $num_right"
echo "---"
echo "Сложение: $num_left + $num_right = $((num_left + num_right))"
echo "Вычитание: $num_left - $num_right = $((num_left - num_right))"
echo "Умножение: $num_left * $num_right = $((num_left * num_right))"
echo "Деление: $num_left / $num_right = $((num_left / num_right))"
echo "Остаток: $num_left % $num_right = $((num_left % num_right))"
echo "Степень: 2 ** 10 = $((2 ** 10))"
