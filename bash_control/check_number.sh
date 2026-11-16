#!/bin/bash
# Контрольная работа Bash, задание 3: положительное, отрицательное или ноль
# Использование: bash check_number.sh <число>

if [ $# -ne 1 ]; then
    echo "Использование: $0 <целое число>"
    exit 1
fi

input_value="$1"

if ! [[ "$input_value" =~ ^-?[0-9]+$ ]]; then
    echo "Ошибка: '$input_value' не является целым числом."
    exit 1
fi

if [ "$input_value" -gt 0 ]; then
    echo "Число $input_value является положительным"
elif [ "$input_value" -lt 0 ]; then
    echo "Число $input_value является отрицательным"
else
    echo "Число $input_value является нулём"
fi
