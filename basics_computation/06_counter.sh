#!/bin/bash
# Скрипт 6: счётчик и разные способы изменить число

step_counter=0

step_counter=$((step_counter + 1))     # обычное присваивание
echo "После первого увеличения: $step_counter"

(( step_counter++ ))                    # инкремент
echo "После второго увеличения: $step_counter"

(( step_counter += 5 ))                 # прибавить 5
echo "После += 5: $step_counter"

(( step_counter *= 2 ))                 # умножить на 2
echo "После *= 2: $step_counter"
