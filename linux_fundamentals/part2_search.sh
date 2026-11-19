#!/bin/bash
# Часть 2: поиск и фильтрация (задания 2.1–2.3)
# Работаем в той же папке, что и в части 1

work_dir=~/linux_practice
mkdir -p "$work_dir"
cd "$work_dir" || exit 1

echo "=== 2.1 Поиск файлов (find) ==="
touch file1.txt file2.log file3.txt document.pdf image.jpg

echo "Все .txt файлы:"
find . -name "*.txt"

echo "Файлы, начинающиеся на file:"
find . -name "file*"

echo "Файлы больше 1 КБ:"
# если find ничего не нашёл, grep . вернёт ошибку и сработает echo
find "$work_dir" -size +1k | grep . || echo "(таких нет — все файлы меньше 1 КБ)"

echo "Изменённые за последние 10 минут:"
find "$work_dir" -mmin -10

echo
echo "=== 2.2 Поиск текста (grep) ==="
# heredoc: всё между << EOF и EOF записывается в файл
cat > data.txt << EOF
Иванов Иван 25
Петров Петр 30
Сидоров Сидор 28
Иванова Мария 22
Петрова Анна 35
EOF

echo "Строки с фамилией Петров:"
grep "Петров" data.txt

# в задании шаблон [3-9][0-9] — это возраст от 30 и старше
echo "Возраст 30 и больше:"
grep -E "[3-9][0-9]" data.txt

echo "Строки БЕЗ слова Иван (-v):"
grep -v "Иван" data.txt

echo "Сколько строк с Иванов (-c):"
grep -c "Иванов" data.txt

echo
echo "=== 2.3 Конвейеры (|) ==="
echo "Первые 5 строк:"
head -5 data.txt

echo "Последние 3 строки:"
tail -3 data.txt

echo "Сортировка по фамилии:"
sort data.txt

echo "Только фамилии (первый столбец):"
awk '{print $1}' data.txt

echo "Уникальные фамилии:"
awk '{print $1}' data.txt | sort | uniq

echo "Сколько раз встречается каждая фамилия:"
awk '{print $1}' data.txt | sort | uniq -c
