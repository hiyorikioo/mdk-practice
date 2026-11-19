#!/bin/bash
# Скрипт 14 (Задание 8): среднее арифметическое трёх чисел
# Деление может дать дробь, поэтому считаем в bc с двумя знаками

read -p "Первое число: " value_one
read -p "Второе число: " value_two
read -p "Третье число: " value_three

values_sum=$(echo "$value_one + $value_two + $value_three" | bc)
values_avg=$(echo "scale=2; $values_sum / 3" | bc)

echo "---"
echo "Числа: $value_one, $value_two, $value_three"
echo "Сумма: $values_sum"
echo "Среднее: $values_avg"
