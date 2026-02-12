#!/bin/bash

LOG_FILE="creation_log_$(date +'%Y%m%d_%H%M%S').txt"

init_log() {
    echo "Лог создания файловой структуры" > "$LOG_FILE"
    echo "Дата начала: $(date +'%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
    echo "Параметры: $@" >> "$LOG_FILE"
    echo "=================================" >> "$LOG_FILE"
}

log_entry() {
    local path="$1"
    local type="$2"
    local size="$3"
    local date="$4"

    if [ "$type" == "file" ]; then
        echo "Файл: $path | Размер: ${size}KB | Дата: $date" >> "$LOG_FILE"
    else
        echo "Папка: $path | Дата: $date" >> "$LOG_FILE"
    fi
}

finalize_log() {
    echo "=================================" >> "$LOG_FILE"
    echo "Дата завершения: $(date +'%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
    echo "Лог сохранен в: $LOG_FILE"
}
