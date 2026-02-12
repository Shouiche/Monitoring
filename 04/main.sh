#!/bin/bash

source ./validators.sh
source ./generators.sh
source ./logger.sh

# Проверка наличия директории для логов
LOG_DIR="./nginx_logs"
mkdir -p "$LOG_DIR"

# Генерация 5 лог-файлов
for day in {1..5}; do
    generate_nginx_log "$day" "$LOG_DIR"
done

log "Генерация логов завершена. Файлы сохранены в $LOG_DIR"
