#!/bin/bash

generate_name() {
    local chars="$1"
    local is_file=${2:-false}
    local min_length=5
    local date_suffix=$(date +"%d%m%y")

    if $is_file; then
        local name_part="${chars%.*}"
        local ext_part="${chars#*.}"
    else
        local name_part="$chars"
        local ext_part=""
    fi

    # Гарантируем использование всех символов в правильном порядке
    local name=""
    for (( i=0; i<${#name_part}; i++ )); do
        name+="${name_part:$i:1}"
    done

    # Добиваем до минимальной длины
    while [ ${#name} -lt $min_length ]; do
        local rand_char=${name_part:$(( RANDOM % ${#name_part} )):1}
        name+="$rand_char"
    done

    # Добавляем расширение для файлов
    if $is_file && [ -n "$ext_part" ]; then
        local ext=""
        for (( i=0; i<${#ext_part}; i++ )); do
            ext+="${ext_part:$i:1}"
        done
        echo "${name}_${date_suffix}.${ext}"
    else
        echo "${name}_${date_suffix}"
    fi
}

get_random_path() {
    local exclude_dirs=("bin" "sbin")
    while true; do
        local path=$(find / -type d 2>/dev/null | grep -vE "$(printf "|%s" "${exclude_dirs[@]}")" | shuf -n 1)
        [ -w "$path" ] && echo "$path" && return
    done
}
