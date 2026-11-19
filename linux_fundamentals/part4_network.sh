#!/bin/bash
# Часть 4: сеть (задания 4.1–4.2)

work_dir=~/linux_practice
mkdir -p "$work_dir"
cd "$work_dir" || exit 1

# ping, ipconfig и netstat выводят русский текст в кодировке cp866,
# перекодируем его в UTF-8, чтобы буквы читались
from_cp866() {
    iconv -f cp866 -t utf-8
}

echo "=== 4.1 Проверка соединения ==="
echo "--- ping своего компьютера (127.0.0.1) ---"
ping -n 4 127.0.0.1 | from_cp866

echo "--- ping ya.ru ---"
ping -n 4 ya.ru | from_cp866

echo "--- IP-адреса компьютера ---"
ipconfig | from_cp866 | grep -i "IPv4"

echo "--- Слушающие порты ---"
netstat -an | from_cp866 | grep -i "LISTENING" | head -10

echo "--- Внешний IP ---"
curl -s --max-time 10 ifconfig.me
echo

echo
echo "=== 4.2 DNS и загрузка ==="
echo "--- nslookup google.com ---"
# nslookup пишет в кодировке cp1251
nslookup google.com 2>/dev/null | iconv -f cp1251 -t utf-8

echo "--- Скачивание example.com ---"
curl -s --max-time 15 -o test.html https://example.com
echo "Первые 10 строк test.html:"
head -10 test.html

echo "--- Заголовки ответа (curl -I) ---"
curl -sI --max-time 15 https://example.com
