#!/bin/bash
# Часть 3: права доступа (задание 3.1)
# Права в ls -l: r — чтение, w — запись, x — выполнение,
# три тройки: владелец / группа / остальные

work_dir=~/linux_practice
mkdir -p "$work_dir"
cd "$work_dir" || exit 1

echo "=== 3.1 Изменение прав ==="
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
cat script.sh

# 644: владелец rw- (4+2), группа r-- (4), остальные r-- (4)
chmod 644 script.sh
echo "Права после chmod 644:"
ls -l script.sh
