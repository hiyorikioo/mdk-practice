#!/bin/bash
# Домашнее задание 1: расчёт комнаты по длине, ширине и высоте (в метрах)

read -p "Длина комнаты (м): " room_length
read -p "Ширина комнаты (м): " room_width
read -p "Высота потолка (м): " room_height

floor_area=$((room_length * room_width))
# стены: две пары противоположных стен = 2 * (длина + ширина) * высота
walls_area=$((2 * (room_length + room_width) * room_height))
room_volume=$((room_length * room_width * room_height))

echo "---"
echo "Площадь пола: $floor_area кв. м"
echo "Площадь стен: $walls_area кв. м"
echo "Объём комнаты: $room_volume куб. м"
