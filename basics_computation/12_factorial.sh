#!/bin/bash
# Задание 7: факториал N (произведение чисел от 1 до N) в цикле while

read -p "Введите N: " fact_n

# Bash хранит целые числа в 64 битах: 21! уже не помещается
if [ "$fact_n" -gt 20 ]; then
    echo "Ошибка: N должно быть не больше 20 (иначе переполнение)."
    exit 1
fi

fact_result=1
loop_i=1

while [ "$loop_i" -le "$fact_n" ]; do
    fact_result=$((fact_result * loop_i))
    loop_i=$((loop_i + 1))
done

echo "Факториал $fact_n! = $fact_result"
