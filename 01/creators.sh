#!/bin/bash

create_structure() {
    local base_path="$1"
    local fcount="$2"
    local fchars="$3"
    local filecount="$4"
    local filechars="$5"
    local filesize="$6"
    local today=$(date +'%d%m%y')

    mkdir -p "$base_path" || return 1

    for ((i=1; i<=fcount; i++)); do
        # Генерация имени папки (минимум 4 символа + дата)
        local folder_name=$(generate_name "$fchars" 4)"_$today"
        local full_folder_path="$base_path/$folder_name"

        mkdir -p "$full_folder_path" || return 1
        log_entry "$full_folder_path" "folder" "" "$(date +'%Y-%m-%d %H:%M:%S')"

        # Создание файлов
        for ((j=1; j<=filecount; j++)); do
            local file_name=$(generate_name "${filechars%.*}" 4)"_$today.${filechars#*.}"
            local full_file_path="$full_folder_path/$file_name"

            # Создание файла заданного размера
            dd if=/dev/zero of="$full_file_path" bs=1K count=${filesize%kb} &>/dev/null || return 1
            log_entry "$full_file_path" "file" "${filesize%kb}" "$(date +'%Y-%m-%d %H:%M:%S')"
        done
    done

    return 0
}
