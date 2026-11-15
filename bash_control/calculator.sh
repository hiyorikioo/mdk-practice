#!/bin/bash
# Контрольная работа Bash, задание 2: калькулятор для двух целых чисел

is_integer() {
    [[ "$1" =~ ^-?[0-9]+$ ]]
}

read -p "Введите первое число: " first_num
read -p "Введите второе число: " second_num
read -p "Введите операцию (+ - * /): " operation

if ! is_integer "$first_num" || ! is_integer "$second_num"; then
    echo "Ошибка: нужно вводить целые числа."
    exit 1
fi

case "$operation" in
    "+") calc_result=$(( first_num + second_num )) ;;
    "-") calc_result=$(( first_num - second_num )) ;;
    "*") calc_result=$(( first_num * second_num )) ;;
    "/")
        if [ "$second_num" -eq 0 ]; then
            echo "Ошибка: деление на ноль."
            exit 1
        fi
        calc_result=$(( first_num / second_num ))
        ;;
    *)
        echo "Ошибка: неизвестная операция '$operation'."
        exit 1
        ;;
esac

echo "Результат: $first_num $operation $second_num = $calc_result"
