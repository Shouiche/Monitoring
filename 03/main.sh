#!/bin/bash

# Определяем абсолютный путь к директории скрипта
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Подключаем модули с абсолютными путями
source "${SCRIPT_DIR}/validators.sh"
source "${SCRIPT_DIR}/cleaners.sh"
source "${SCRIPT_DIR}/logger.sh"
source "${SCRIPT_DIR}/utils.sh"

# Инициализация лога
LOG_FILE="${SCRIPT_DIR}/cleaner_$(date +"%d%m%y_%H%M%S").log"
init_log "$LOG_FILE" "$1"

# Проверка и обработка параметров
validate_input "$@"
case $1 in
    1) clean_by_log ;;
    2) clean_by_date ;;
    3) clean_by_mask ;;
    *) echo "Неизвестный метод очистки" >&2; exit 1 ;;
esac

# Финализация
finalize_log
