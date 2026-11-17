#!/bin/bash
# Задание 2: свои вычисления для x=25 и y=4

val_x=25
val_y=4

echo "x = $val_x, y = $val_y"
echo "---"
echo "Сумма:        $((val_x + val_y))"
echo "Разность:     $((val_x - val_y))"
echo "Произведение: $((val_x * val_y))"
echo "Частное:      $((val_x / val_y))"
echo "Остаток:      $((val_x % val_y))"
echo "x в квадрате: $((val_x ** 2))"
echo "y в кубе:     $((val_y ** 3))"
