#!/bin/bash

analyze_logs() {
    local log_dir="$1"
    local mode="$2"

    case "$mode" in
        1)
            log "Записи, отсортированные по коду ответа:"
            analyze_by_response_code "$log_dir"
            ;;
        2)
            log "Уникальные IP:"
            analyze_unique_ips "$log_dir"
            ;;
        3)
            log "Запросы с ошибками (4xx и 5xx):"
            analyze_error_requests "$log_dir"
            ;;
        4)
            log "Уникальные IP с ошибочными запросами:"
            analyze_error_ips "$log_dir"
            ;;
    esac
}

analyze_by_response_code() {
    find "$1" -name "access_*.log" -exec awk '
    {
        print $9, $0
    }' {} + | sort -n | cut -d' ' -f2-
}

analyze_unique_ips() {
    find "$1" -name "access_*.log" -exec awk '
    {
        ips[$1]++
    } 
    END {
        for (ip in ips) {
            print ip
        }
    }' {} + | sort
}

analyze_error_requests() {
    find "$1" -name "access_*.log" -exec awk '
    $9 ~ /^[45][0-9]{2}$/ {
        print $0
    }' {} +
}

analyze_error_ips() {
    find "$1" -name "access_*.log" -exec awk '
    $9 ~ /^[45][0-9]{2}$/ {
        error_ips[$1]++
    }
    END {
        for (ip in error_ips) {
            print ip
        }
    }' {} + | sort
}
