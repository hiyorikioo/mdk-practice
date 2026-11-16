#!/bin/bash
# Контрольная работа Bash, задание 4: список .txt-файлов в каталоге с размерами
# Использование: bash list_files.sh <каталог>

if [ $# -ne 1 ]; then
    echo "Использование: $0 <каталог>"
    exit 1
fi

target_dir="$1"

if [ ! -d "$target_dir" ]; then
    echo "Ошибка: каталог '$target_dir' не существует."
    exit 1
fi

echo "Текстовые файлы в каталоге '$target_dir':"

found_count=0
for txt_file in "$target_dir"/*.txt; do
    # Если файлов нет, шаблон *.txt остаётся как есть — пропускаем
    [ -f "$txt_file" ] || continue
    file_size=$(wc -c < "$txt_file")
    echo "  $(basename "$txt_file") — ${file_size} байт"
    found_count=$((found_count + 1))
done

if [ "$found_count" -eq 0 ]; then
    echo "  .txt-файлов не найдено."
else
    echo "Всего файлов: $found_count"
fi
