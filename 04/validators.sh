#!/bin/bash

validate_environment() {
    # Проверка необходимых утилит
    if ! command -v date &> /dev/null; then
        echo "Ошибка: утилита 'date' не найдена" >&2
        exit 1
    fi
}

check_log_dir() {
    local log_dir=$1
    if [ ! -d "$log_dir" ]; then
        mkdir -p "$log_dir" || {
            echo "Не удалось создать директорию для логов: $log_dir" >&2
            exit 1
        }
    fi
}
