#!/bin/bash

show_help() {
    echo "Использование: ./main.sh"
    echo "Генерирует 5 файлов логов nginx в формате combined"
    echo "Каждый файл содержит данные за один день (100-1000 записей)"
    echo ""
    echo "Результат сохраняется в ./nginx_logs/"
}
