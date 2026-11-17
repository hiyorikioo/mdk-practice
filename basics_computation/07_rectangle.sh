#!/bin/bash
# Задание 3: площадь и периметр прямоугольника

rect_width=8
rect_height=5

rect_area=$((rect_width * rect_height))
rect_perimeter=$((2 * (rect_width + rect_height)))

echo "======================================"
echo "  Прямоугольник ${rect_width} x ${rect_height}"
echo "======================================"
echo "  Площадь:   ${rect_area} кв. ед."
echo "  Периметр:  ${rect_perimeter} ед."
echo "======================================"
