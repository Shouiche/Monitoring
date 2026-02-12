#!/bin/bash

validate_input() {
    [ $# -ne 3 ] && { 
        echo "Ошибка: Необходимо 3 параметра: буквы_папок буквы_файлов.расширение размер(Mb)" >&2
        return 1
    }

    local folder_chars="$1"
    local file_chars="$2"
    local size="${3/Mb/}"

    [[ ! "$folder_chars" =~ ^[a-zA-Z]{1,7}$ ]] && {
        echo "Ошибка: Параметр 1 должен содержать 1-7 букв английского алфавита" >&2
        return 1
    }

    [[ ! "$file_chars" =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$ ]] && {
        echo "Ошибка: Параметр 2 должен быть в формате 'буквы.буквы' (1-7.1-3 символа)" >&2
        return 1
    }

    [[ ! "$size" =~ ^[0-9]+$ ]] || [ "$size" -gt 100 ] && {
        echo "Ошибка: Параметр 3 должен быть числом от 1 до 100 Mb" >&2
        return 1
    }

    check_free_space || return 1
    return 0
}

check_free_space() {
    local free_gb=$(df -BG / | awk 'NR==2 {print $4}' | tr -d 'G')
    if [ "$free_gb" -lt 1 ]; then
        echo "Ошибка: В системе осталось меньше 1GB свободного места" >&2
        return 1
    fi
    return 0
}
