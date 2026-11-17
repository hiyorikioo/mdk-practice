#!/bin/bash
# Скрипт 9: калькулятор с выбором операции через case

read -p "Первое число: " operand_one
read -p "Второе число: " operand_two
read -p "Операция (+, -, *, /): " chosen_op

case "$chosen_op" in
    +)
        echo "$operand_one + $operand_two = $((operand_one + operand_two))"
        ;;
    -)
        echo "$operand_one - $operand_two = $((operand_one - operand_two))"
        ;;
    \*)
        echo "$operand_one * $operand_two = $((operand_one * operand_two))"
        ;;
    /)
        if [ "$operand_two" -eq 0 ]; then
            echo "Ошибка: деление на ноль"
        else
            echo "$operand_one / $operand_two = $((operand_one / operand_two))"
        fi
        ;;
    *)
        echo "Неизвестная операция: $chosen_op"
        ;;
esac
