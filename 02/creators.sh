#!/bin/bash

source ./generators.sh
source ./logger.sh

create_structure() {
    local folder_chars="$1"
    local file_chars="$2"
    local file_size_mb="${3/Mb/}"
    local total_folders=0
    local total_files=0

    echo "Поиск подходящих директорий..."

    while true; do
        check_free_space || { echo -e "\nДостигнут минимальный лимит свободного места"; break; }

        local folder_count=$(( RANDOM % 100 + 1 ))
        echo -ne "\rСоздано папок: $total_folders | Файлов: $total_files"

        for (( i=0; i<folder_count; i++ )); do
            check_free_space || break 2

            local base_path=$(get_random_path)
            [ -z "$base_path" ] && continue

            local folder_name=$(generate_name "$folder_chars")
            local full_path="${base_path}/${folder_name}"

            if mkdir -p "$full_path"; then
                log_entry "$full_path" "folder" ""
                ((total_folders++))

                local file_count=$(( RANDOM % 20 + 1 ))
                for (( j=0; j<file_count; j++ )); do
                    check_free_space || break 3

                    local file_name=$(generate_name "$file_chars" true)
                    local full_file_path="${full_path}/${file_name}"

                    if dd if=/dev/zero of="$full_file_path" bs=1M count="$file_size_mb" 2>/dev/null; then
                        log_entry "$full_file_path" "file" "${file_size_mb}M"
                        ((total_files++))
                        echo -ne "\rСоздано папок: $total_folders | Файлов: $total_files"
                    fi
                done
            fi
        done
    done

    echo -e "\nИтог: создано $total_folders папок и $total_files файлов"
}
