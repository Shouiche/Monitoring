#!/bin/bash

validate_input() {
    local path="$1"
    local fcount="$2"
    local fchars="$3"
    local filecount="$4"
    local filechars="$5"
    local filesize="$6"

    # Проверка абсолютного пути
    [[ "$path" != /* ]] && { echo "Ошибка: Путь должен быть абсолютным"; return 1; }

    # Проверка числовых параметров
    [[ ! "$fcount" =~ ^[0-9]+$ ]] && { echo "Ошибка: Количество папок должно быть числом"; return 1; }
    [[ ! "$filecount" =~ ^[0-9]+$ ]] && { echo "Ошибка: Количество файлов должно быть числом"; return 1; }
    [[ ! "$filesize" =~ ^[0-9]+kb$ ]] && { echo "Ошибка: Размер файлов должен быть в формате 'Nkb'"; return 1; }

    # Проверка размера файлов (не более 100kb)
    local size_num=${filesize%kb}
    [ "$size_num" -gt 100 ] && { echo "Ошибка: Размер файлов не должен превышать 100kb"; return 1; }

    # Проверка символов (только буквы a-z)
    [[ "$fchars" =~ [^a-zA-Z] ]] && { echo "Ошибка: Символы папок должны быть только буквами a-z"; return 1; }
    [[ "$filechars" =~ [^a-zA-Z.] ]] && { echo "Ошибка: Символы файлов должны быть только буквами a-z и точкой"; return 1; }

    # Проверка длины символов
    [ "${#fchars}" -gt 7 ] && { echo "Ошибка: Символы папок не должны превышать 7 знаков"; return 1; }

    local file_part=${filechars%.*}
    local ext_part=${filechars#*.}
    [ "${#file_part}" -gt 7 ] && { echo "Ошибка: Имя файла не должно превышать 7 знаков"; return 1; }
    [ "${#ext_part}" -gt 3 ] && { echo "Ошибка: Расширение файла не должно превышать 3 знаков"; return 1; }

    return 0
}
