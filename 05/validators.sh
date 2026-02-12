#!/bin/bash

validate_input() {
    if [ $# -ne 1 ]; then
        echo "Использование: $0 <режим>"
        echo "Режимы работы:"
        echo "1 - Все записи, отсортированные по коду ответа"
        echo "2 - Все уникальные IP"
        echo "3 - Все запросы с ошибками (4xx или 5xx)"
        echo "4 - Уникальные IP с ошибочными запросами"
        exit 1
    fi

    if [[ ! "$1" =~ ^[1-4]$ ]]; then
        echo "Ошибка: режим должен быть числом от 1 до 4" >&2
        exit 1
    fi
}

check_log_dir() {
    local log_dir="$1"
    if [ ! -d "$log_dir" ]; then
        echo "Ошибка: директория с логами не существует: $log_dir" >&2
        echo "Создайте директорию и поместите туда логи nginx" >&2
        exit 1
    fi

    if [ -z "$(ls -A "$log_dir" 2>/dev/null)" ]; then
        echo "Ошибка: директория с логами пуста: $log_dir" >&2
        echo "Поместите в неё файлы логов access_*.log" >&2
        exit 1
    fi
}
