#!/bin/bash
# Часть 3: права доступа (задание 3.1)
# Права в ls -l: r — чтение, w — запись, x — выполнение,
# три тройки: владелец / группа / остальные

work_dir=~/linux_practice
mkdir -p "$work_dir"
cd "$work_dir" || exit 1

echo "=== 3.1 Изменение прав ==="
# В Windows (Git Bash) права файлов имитируются: файл с #! в начале
# сразу считается исполняемым, а chmod права не меняет.
if [ "$(uname -o)" = "Msys" ]; then
    echo "Внимание: запуск в Git Bash — chmod здесь не меняет права."
    echo "В Linux будет: после создания -rw-r--r--, после +x -rwxr-xr-x,"
    echo "после -r --wx--x--x (cat: Permission denied), после 644 -rw-r--r--"
    echo
fi
# кавычки вокруг 'EOF' — чтобы $(...) и $ внутри не подставлялись
cat > script.sh << 'EOF'
#!/bin/bash
echo "Hello, World!"
date
EOF

echo "Права после создания:"
ls -l script.sh

chmod +x script.sh
echo "Права после chmod +x:"
ls -l script.sh

echo "Запуск скрипта:"
./script.sh

chmod -r script.sh
echo "Права после chmod -r:"
ls -l script.sh
echo "Пробую прочитать файл:"
if cat script.sh; then
    echo "(файл прочитан — в Windows/Git Bash chmod -r не запрещает чтение,"
    echo " в Linux здесь будет ошибка Permission denied)"
fi

# 644: владелец rw- (4+2), группа r-- (4), остальные r-- (4)
chmod 644 script.sh
echo "Права после chmod 644:"
ls -l script.sh
