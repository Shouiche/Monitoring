#!/bin/bash

generate_name() {
    local chars="$1"
    local min_length="$2"
    local length=$(( RANDOM % (7 - min_length + 1) + min_length ))
    local name=""

    # Используем каждый символ хотя бы один раз
    for ((i=0; i<${#chars}; i++)); do
        name+=${chars:i:1}
    done

    # Добавляем случайные символы из заданного набора
    while [ ${#name} -lt $length ]; do
        local random_char=${chars:$(( RANDOM % ${#chars} )):1}
        name+="$random_char"
    done

    echo "$name"
}
