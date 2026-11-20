#!/bin/bash
# Информация о файле: имя, папка, тип, права, размер

read -p "Введите путь к файлу: " target_path

# -e: существует ли вообще (файл или папка)
if [ ! -e "$target_path" ]; then
    echo "Файл не найден!"
    exit 1
fi

echo "=== Информация о файле ==="
echo "Имя: $(basename "$target_path")"
echo "Путь: $(dirname "$target_path")"

if [ -d "$target_path" ]; then
    echo "Тип: Директория"
elif [ -f "$target_path" ]; then
    echo "Тип: Обычный файл"
else
    echo "Тип: Другой"
fi

# первое поле ls -l — строка прав, например -rw-r--r--
echo "Права: $(ls -ld "$target_path" | cut -d' ' -f1)"

# --apparent-size: настоящий размер, а не место, занятое на диске
echo "Размер: $(du -sh --apparent-size "$target_path" | cut -f1)"
