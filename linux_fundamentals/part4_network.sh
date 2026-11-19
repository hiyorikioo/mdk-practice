#!/bin/bash
# Часть 4: сеть (задания 4.1–4.2)
# Скрипт работает и в Linux, и в Git Bash на Windows:
# у Windows свои сетевые команды, поэтому для неё отдельные ветки.

work_dir=~/linux_practice
mkdir -p "$work_dir"
cd "$work_dir" || exit 1

if [ "$(uname -o)" = "Msys" ]; then
    on_windows=yes
else
    on_windows=no
fi

# Windows-команды пишут по-русски в кодировке cp866,
# перекодируем в UTF-8, иначе в Git Bash будут кракозябры
from_cp866() {
    iconv -f cp866 -t utf-8
}

echo "=== 4.1 Проверка соединения ==="
if [ "$on_windows" = yes ]; then
    # в Windows: -n вместо -c, а 0.0.0.0 не пингуется — берём 127.0.0.1
    echo "--- ping своего компьютера (127.0.0.1) ---"
    ping -n 4 127.0.0.1 | from_cp866
    echo "--- ping ya.ru ---"
    ping -n 4 ya.ru | from_cp866
    echo "--- IP-адреса компьютера (ipconfig вместо ip addr) ---"
    ipconfig | from_cp866 | grep -i "IPv4"
    echo "--- Слушающие порты (netstat вместо ss) ---"
    netstat -an | from_cp866 | grep -i "LISTENING" | head -10
else
    echo "--- ping 0.0.0.0 ---"
    ping -c 4 0.0.0.0
    echo "--- ping ya.ru ---"
    ping -c 4 ya.ru
    echo "--- IP-адреса компьютера ---"
    ip addr | grep inet | grep -v inet6
    echo "--- Активные соединения ---"
    ss -tuln | head -10
fi

echo "--- Внешний IP ---"
curl -s --max-time 10 ifconfig.me
echo

echo
echo "=== 4.2 DNS и загрузка ==="
echo "--- nslookup google.com ---"
if [ "$on_windows" = yes ]; then
    # nslookup, в отличие от ping и ipconfig, пишет в cp1251
    nslookup google.com 2>/dev/null | iconv -f cp1251 -t utf-8
else
    nslookup google.com
fi

echo "--- dig +short google.com ---"
if command -v dig > /dev/null; then
    dig +short google.com
else
    echo "(dig не установлен — в Windows его нет, адрес выше показал nslookup)"
fi

echo "--- Скачивание example.com ---"
curl -s --max-time 15 -o test.html https://example.com
echo "Первые 10 строк test.html:"
head -10 test.html

echo "--- Заголовки ответа (curl -I) ---"
curl -sI --max-time 15 https://example.com
