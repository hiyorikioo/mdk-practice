#!/bin/bash
# Дополнительное задание 2: 5 самых больших .log файлов
# find находит файлы, ls -S сортирует по размеру, head оставляет первые 5

search_dir=~/linux_practice
mkdir -p "$search_dir/logs"
cd "$search_dir" || exit 1

# Создаём тестовые логи разного размера, чтобы было что сортировать.
# head -c N /dev/zero даёт ровно N байт, tr заменяет нули на буквы
log_index=1
for log_size in 300 5000 1200 8000 50 2500 700; do
    head -c "$log_size" /dev/zero | tr '\0' 'a' > "logs/test_$log_index.log"
    log_index=$((log_index + 1))
done

echo "Все .log файлы:"
find . -name "*.log" -type f

echo
echo "5 самых больших (по убыванию размера):"
# -exec ... {} + передаёт ls сразу все найденные файлы,
# -l подробный вывод, -S сортировка по размеру, -h размер в КБ
find . -name "*.log" -type f -exec ls -lSh {} + | head -5
