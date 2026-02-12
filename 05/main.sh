#!/bin/bash

source ./validators.sh
source ./analyzer.sh
source ./logger.sh

# Проверка параметров
validate_input "$@"

# Используем абсолютный путь к директории с логами
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOG_DIR="${SCRIPT_DIR}/nginx_logs"

# Проверяем существование директории с логами
check_log_dir "$LOG_DIR"

# Анализ логов
analyze_logs "$LOG_DIR" "$1"
