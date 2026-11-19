#!/bin/bash
# Домашнее задание 4: игра «Угадай число»
# $RANDOM даёт случайное число от 0 до 32767,
# остаток от деления на 10 (0..9) плюс 1 — число от 1 до 10

secret_num=$((RANDOM % 10 + 1))

read -p "Я загадал число от 1 до 10. Ваш вариант: " player_guess

if [ "$player_guess" -eq "$secret_num" ]; then
    echo "Победа!"
else
    echo "Не угадал, было $secret_num"
fi
