#!/bin/bash

# Коды HTTP ответов и их значения:
# 200 - OK (успешный запрос)
# 201 - Created (ресурс создан)
# 400 - Bad Request (неверный синтаксис)
# 401 - Unauthorized (требуется аутентификация)
# 403 - Forbidden (доступ запрещен)
# 404 - Not Found (ресурс не найден)
# 500 - Internal Server Error (ошибка сервера)
# 501 - Not Implemented (метод не поддерживается)
# 502 - Bad Gateway (ошибка шлюза)
# 503 - Service Unavailable (сервис недоступен)

generate_ip() {
    echo "$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256))"
}

generate_status() {
    local codes=(200 201 400 401 403 404 500 501 502 503)
    echo "${codes[$((RANDOM%10))]}"
}

generate_method() {
    local methods=("GET" "POST" "PUT" "PATCH" "DELETE")
    echo "${methods[$((RANDOM%5))]}"
}

generate_url() {
    local paths=("/" "/admin" "/user" "/api" "/static" "/login" "/logout")
    echo "${paths[$((RANDOM%7))]}"
}

generate_agent() {
    local agents=(
        "Mozilla/5.0"
        "Google Chrome/91.0"
        "Opera/9.80"
        "Safari/537.36"
        "Internet Explorer/11.0"
        "Microsoft Edge/91.0"
        "Crawler/2.0"
        "Wget/1.21.1"
    )
    echo "${agents[$((RANDOM%8))]}"
}

generate_nginx_log() {
    local day=$1
    local log_dir=$2
    local log_file="${log_dir}/access_$(date -d "-${day} days" +"%Y-%m-%d").log"
    local entries=$((RANDOM%901 + 100))  # 100-1000 записей

    for ((i=1; i<=entries; i++)); do
        local ip=$(generate_ip)
        local status=$(generate_status)
        local method=$(generate_method)
        local url=$(generate_url)
        local agent=$(generate_agent)
        local timestamp=$(date -d "-${day} days $((RANDOM%86400)) seconds" +"%d/%b/%Y:%H:%M:%S %z")

        # Формат combined:
        # $remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent"
        echo "$ip - - [$timestamp] \"$method $url HTTP/1.1\" $status $((RANDOM%5000)) \"-\" \"$agent\"" >> "$log_file"
    done

    log "Сгенерирован файл $log_file с $entries записями"
}
