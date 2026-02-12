#!/bin/bash

validate_input() {
    if [ $# -ne 1 ]; then
        echo "Использование: $0 <метод_очистки>" >&2
        echo "Методы очистки:" >&2
        echo "1 - По лог-файлу" >&2
        echo "2 - По дате создания" >&2
        echo "3 - По маске имени" >&2
        exit 1
    fi

    if [[ ! "$1" =~ ^[1-3]$ ]]; then
        echo "Ошибка: Метод очистки должен быть 1, 2 или 3" >&2
        exit 1
    fi
}

validate_date() {
    local date_regex="^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}$"
    if [[ ! "$1" =~ $date_regex ]]; then
        echo "Неверный формат даты. Используйте YYYY-MM-DD HH:MM" >&2
        return 1
    fi
    return 0
}
