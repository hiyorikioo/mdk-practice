#!/bin/bash
# Создание файлов: пустой, с текстом или с текущей датой

echo "Что создать?"
echo "1) Пустой файл"
echo "2) Файл с текстом"
echo "3) Файл с датой"
read -p "Выберите (1-3): " menu_item

case "$menu_item" in
    1)
        read -p "Имя файла: " new_file
        touch "$new_file"            # touch создаёт пустой файл
        echo "Создан пустой файл: $new_file"
        ;;
    2)
        read -p "Имя файла: " new_file
        read -p "Текст для записи: " file_text
        echo "$file_text" > "$new_file"   # > перезаписывает файл
        echo "Файл создан с текстом"
        ;;
    3)
        read -p "Имя файла: " new_file
        date > "$new_file"           # записываем текущую дату
        echo "Файл создан с текущей датой:"
        cat "$new_file"
        ;;
    *)
        echo "Неверный выбор"
        ;;
esac
