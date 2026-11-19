#!/bin/bash
# Часть 1: работа с файлами и директориями (задания 1.1–1.3)
# Всё создаётся в отдельной папке ~/linux_practice

work_dir=~/linux_practice

echo "=== 1.1 Навигация и создание структуры ==="
echo "Где я сейчас:"
pwd
echo "Содержимое домашней папки (первые 5):"
ls ~ | head -5

# -p: не ругаться, если папка уже есть (скрипт можно запускать повторно)
mkdir -p "$work_dir"
cd "$work_dir" || exit 1
echo "Перешла в рабочую папку:"
pwd

mkdir -p documents projects downloads
echo "Созданные папки:"
ls

echo
echo "=== 1.2 Создание и работа с файлами ==="
# > перезаписывает файл
echo "Моя первая практическая работа" > readme.txt
cat readme.txt
# >> дописывает в конец файла
echo "Дата выполнения: $(date)" >> readme.txt
echo "readme.txt после дописывания:"
cat readme.txt

# удаляем старый numbers.txt, иначе при повторном запуске числа задвоятся
rm -f numbers.txt
for line_no in {1..10}; do
    echo "Число $line_no" >> numbers.txt
done
echo "numbers.txt:"
cat numbers.txt

echo
echo "=== 1.3 Копирование и перемещение ==="
cp readme.txt documents/
echo "В documents:"
ls documents/

mv -f numbers.txt downloads/
echo "В downloads:"
ls downloads/
echo "В текущей папке (numbers.txt здесь уже нет):"
ls

# -r (рекурсивно) нужен, чтобы скопировать папку со всем содержимым
cp -r documents projects/
echo "В projects:"
ls projects/
