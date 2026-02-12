#!/bin/bash

LOG_FILE="file_system_generator_$(date +"%d%m%y_%H%M%S").log"

init_log() {
    local start_time="$1"
    shift
    echo "=== Лог генератора файловой структуры ===" > "$LOG_FILE"
    echo "Время начала: $(date -d "@$start_time" "+%Y-%m-%d %H:%M:%S")" >> "$LOG_FILE"
    echo "Параметры запуска: $@" >> "$LOG_FILE"
    echo "----------------------------------------" >> "$LOG_FILE"

    echo "Параметры запуска: $@"
    echo "Лог-файл: $LOG_FILE"
}

log_entry() {
    local path="$1"
    local type="$2"
    local size="$3"

    if [ "$type" == "file" ]; then
        echo "Файл: $path | Размер: $size" >> "$LOG_FILE"
    else
        echo "Папка: $path" >> "$LOG_FILE"
    fi
}

finalize_log() {
    local start_time="$1"
    local end_time="$2"
    local duration=$(( end_time - start_time ))

    echo "----------------------------------------" >> "$LOG_FILE"
    echo "Время окончания: $(date -d "@$end_time" "+%Y-%m-%d %H:%M:%S")" >> "$LOG_FILE"
    echo "Общее время работы: $duration секунд" >> "$LOG_FILE"

    echo -e "\nСтатистика:"
    echo "Время начала: $(date -d "@$start_time" "+%H:%M:%S")"
    echo "Время окончания: $(date -d "@$end_time" "+%H:%M:%S")"
    echo "Общее время работы: $duration сек."
}
