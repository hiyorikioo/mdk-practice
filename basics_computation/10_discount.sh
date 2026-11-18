#!/bin/bash
# Скрипт 10: расчёт цены со скидкой (целые рубли)

read -p "Введите цену (руб.): " base_price
read -p "Введите скидку (%): " discount_percent

discount_rub=$((base_price * discount_percent / 100))
price_to_pay=$((base_price - discount_rub))

echo "---"
echo "Исходная цена: $base_price руб."
echo "Скидка $discount_percent%: $discount_rub руб."
echo "Итого к оплате: $price_to_pay руб."
