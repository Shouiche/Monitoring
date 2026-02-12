#!/bin/bash

source ./validators.sh
source ./generators.sh
source ./creators.sh
source ./logger.sh

clear
echo "=== Запуск генератора файловой структуры ==="
START_TIME=$(date +%s)
init_log "$START_TIME" "$@"

validate_input "$@" && echo -e "Параметры проверены: OK\n" || exit 1

echo "Создание структуры..."
create_structure "$@"

END_TIME=$(date +%s)
finalize_log "$START_TIME" "$END_TIME"
echo -e "\n=== Завершение работы ==="
