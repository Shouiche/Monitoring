#!/bin/bash

show_help() {
    echo "NGINX Log Analyzer"
    echo "Использование: ./main.sh <режим>"
    echo ""
    echo "Режимы работы:"
    echo "1 - Все записи, отсортированные по коду ответа"
    echo "2 - Все уникальные IP"
    echo "3 - Все запросы с ошибками (4xx или 5xx)"
    echo "4 - Уникальные IP с ошибочными запросами"
    echo ""
    echo "Логи должны находиться в директории ./nginx_logs/"
}
