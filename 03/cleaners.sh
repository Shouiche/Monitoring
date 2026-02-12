#!/bin/bash

clean_by_log() {
    read -p "Введите путь к лог-файлу: " log_file
    if [ ! -f "$log_file" ]; then
        echo "Лог-файл не найден!" >&2
        exit 1
    fi

    echo "Начало очистки по лог-файлу..."
    while IFS= read -r line; do
        if [[ "$line" =~ ^(Папка|Файл):\ (/.+)\ \| ]]; then
            local path="${BASH_REMATCH[2]}"
            if [ -e "$path" ]; then
                rm -rf "$path"
                echo "Удалено: $path" | tee -a "$LOG_FILE"
            fi
        fi
    done < "$log_file"
}

clean_by_date() {
    read -p "Введите начальную дату (YYYY-MM-DD HH:MM): " start_date
    validate_date "$start_date" || return 1

    read -p "Введите конечную дату (YYYY-MM-DD HH:MM): " end_date
    validate_date "$end_date" || return 1

    echo "Начало очистки по дате создания ($start_date - $end_date)..."
    find / -type d -newermt "$start_date" ! -newermt "$end_date" -print0 2>/dev/null | 
    while IFS= read -r -d $'\0' dir; do
        if [[ "$dir" =~ [a-zA-Z]+_[0-9]{6}$ ]]; then
            rm -rf "$dir"
            echo "Удалена папка: $dir" | tee -a "$LOG_FILE"
        fi
    done
}

clean_by_mask() {
    read -p "Введите маску имени (без даты, например 'az'): " mask
    if [[ ! "$mask" =~ ^[a-zA-Z]+$ ]]; then
        echo "Маска должна содержать только буквы!" >&2
        exit 1
    fi

    echo "Начало очистки по маске '$mask'..."
    find / -type d -name "${mask}_[0-9][0-9][0-9][0-9][0-9][0-9]" -print0 2>/dev/null |
    while IFS= read -r -d $'\0' dir; do
        rm -rf "$dir"
        echo "Удалена папка: $dir" | tee -a "$LOG_FILE"
    done
}
