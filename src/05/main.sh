#!/bin/bash

# Проверяем, что скрипт был запущен с одним параметром
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <1|2|3|4>"
    exit 1
fi

option=$1

# Путь к файлу логов Nginx
LOG_FILE="../04/day_1.log"
RESULT_FILE="result.log"
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

case $option in
    1)
        # Все записи, отсортированные по коду ответа
        awk '{print $0}' "$LOG_FILE" | sort -k9,9n > "$RESULT_FILE"
        ;;
    2)
        # Все уникальные IP-адреса
        awk '{print $1}' "$LOG_FILE" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | sort | uniq > "$RESULT_FILE"
        ;;
    3)
        # Все запросы с ошибками (код ответа 4xx или 5xx)
        awk '$9 ~ /^4|^5/ {print $0}' "$LOG_FILE" > "$RESULT_FILE"
        ;;
    4)
        # Все уникальные IP-адреса среди ошибочных запросов
        awk '$9 ~ /^4|^5/ {print $1}' "$LOG_FILE" | sort | uniq > "$RESULT_FILE"
        ;;
    *)
        echo "Invalid option: $option"
        echo "Valid options are: 1, 2, 3, 4"
        exit 1
        ;;
esac

exit 0
