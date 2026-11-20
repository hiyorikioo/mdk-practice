#!/bin/bash
# Копирование файла с резервной копией:
# если файл назначения уже есть, он сохраняется в .backup.ДАТА_ВРЕМЯ

read -p "Файл для копирования: " src_file
read -p "Куда копировать: " dst_file

if [ ! -f "$src_file" ]; then
    echo "Ошибка: Файл $src_file не найден!"
    exit 1
fi

if [ -f "$dst_file" ]; then
    # date +%Y%m%d_%H%M%S даёт метку вида 20261120_133000
    backup_name="${dst_file}.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$dst_file" "$backup_name"
    echo "Создан бэкап: $backup_name"
fi

cp "$src_file" "$dst_file"
echo "Файл скопирован в: $dst_file"
