#!/bin/bash
# Скрипт 5: переменные и пересчёт значения после изменения

item_price=150
item_count=3
order_total=$((item_price * item_count))

echo "Цена: $item_price руб."
echo "Количество: $item_count шт."
echo "Итого: $order_total руб."
echo "---"

# Меняем количество — итог нужно пересчитать заново
item_count=5
order_total=$((item_price * item_count))

echo "После изменения количества:"
echo "Количество: $item_count шт."
echo "Итого: $order_total руб."
