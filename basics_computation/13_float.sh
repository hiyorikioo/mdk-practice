#!/bin/bash
# Скрипт 13: дробные вычисления через bc — площадь круга
# $(( )) умеет только целые числа, поэтому считаем в bc

read -p "Введите радиус: " circle_radius

# scale=2 действует на деление, поэтому делим на 1,
# чтобы оставить 2 знака после запятой
circle_area=$(echo "scale=2; (3.14159 * $circle_radius * $circle_radius) / 1" | bc)

echo "---"
echo "Радиус: $circle_radius"
echo "Площадь круга: $circle_area"
