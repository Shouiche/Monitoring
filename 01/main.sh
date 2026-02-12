#!/bin/bash

# Подключение модулей
source ./validators.sh 2>/dev/null || { echo "Ошибка: Не найден validators.sh"; exit 1; }
source ./generators.sh 2>/dev/null || { echo "Ошибка: Не найден generators.sh"; exit 1; }
source ./creators.sh 2>/dev/null || { echo "Ошибка: Не найден creators.sh"; exit 1; }
source ./logger.sh 2>/dev/null || { echo "Ошибка: Не найден logger.sh"; exit 1; }

# Проверка количества параметров
if [ $# -ne 6 ]; then
echo "Ошибка: Неверное количество параметров. Использование: $0 <абсолютный_путь> <количество_папок> <буквы_папок> <количество_файлов> <буквы_файлов> <размер_файлов>"
exit 1
fi

# Параметры
base_path="$1"
folder_count="$2"
folder_chars="$3"
file_count="$4"
file_chars="$5"
file_size_kb="$6"

# Проверка свободного места (1 ГБ = 1048576 КБ)
free_space=$(df -k / | awk 'NR==2 {print $4}')
if [ "$free_space" -lt 1048576 ]; then
echo "Ошибка: Осталось менее 1 ГБ свободного места в системе"
exit 1
fi

# Проверка параметров
validate_input "$base_path" "$folder_count" "$folder_chars" "$file_count" "$file_chars" "$file_size_kb" || exit 1

# Инициализация лога
init_log "$base_path" "$folder_count" "$folder_chars" "$file_count" "$file_chars" "$file_size_kb"

# Создание структуры
if create_structure "$base_path" "$folder_count" "$folder_chars" "$file_count" "$file_chars" "$file_size_kb"; then
finalize_log
echo "Структура успешно создана"
exit 0
else
echo "Ошибка при создании структуры. Проверьте лог для деталей."
exit 1
fi

