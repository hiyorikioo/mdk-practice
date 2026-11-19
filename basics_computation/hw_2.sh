#!/bin/bash
# Домашнее задание 2: доход по вкладу за год
# Ставка бывает дробной (например 7.5), поэтому считаем через bc

read -p "Сумма вклада (руб.): " deposit_amount
read -p "Годовая ставка (%): " yearly_rate

year_income=$(echo "scale=2; $deposit_amount * $yearly_rate / 100" | bc)
amount_after=$(echo "$deposit_amount + $year_income" | bc)

echo "---"
echo "Вклад: $deposit_amount руб. под $yearly_rate% годовых"
echo "Доход за год: $year_income руб."
echo "Сумма через год: $amount_after руб."
