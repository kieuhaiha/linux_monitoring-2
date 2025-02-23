#!/bin/bash

# Список возможных значений
IP_POOL=("192.168.1." "10.0.0." "172.16.0.")
STATUS_CODES=(200 201 400 401 403 404 500 501 502 503)
METHODS=(GET POST PUT PATCH DELETE)
USER_AGENTS=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")
URLS=("/index.html" "/api/data" "/login" "/logout" "/admin" "/profile" "/search" "/download")

generate_ip() {
    local prefix=${IP_POOL[RANDOM % ${#IP_POOL[@]}]}
    echo "$prefix$((RANDOM % 256))"
}

format_date() {
    input_date="$1"
    if [[ $input_date =~ ([0-9]{4})-([0-9]{1,2})-([0-9]{1,2}):([0-9]{2}):([0-9]{2}):([0-9]{2}) ]]; then
        year="${BASH_REMATCH[1]}"
        month="${BASH_REMATCH[2]}"
        day="${BASH_REMATCH[3]}"
        hour="${BASH_REMATCH[4]}"
        minute="${BASH_REMATCH[5]}"
        second="${BASH_REMATCH[6]}"

        months=(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
        month_name="${months[month-1]}"

        echo "[$(printf '%02d' $day)/$month_name/$year:$hour:$minute:$second +0000]"
    else
        echo "Неверный формат даты"
        exit 1
    fi
}

generate_time() {
    local day="$1"
    local hour=$(printf "%02d" $((RANDOM % 24)))
    local minute=$(printf "%02d" $((RANDOM % 60)))
    local second=$(printf "%02d" $((RANDOM % 60)))
    echo "2024-12-$day:$hour:$minute:$second"
}

for day in {1..5}; do
    LOG_FILE="day_$day.log"
    RECORDS=$((RANDOM % 901 + 100))

    echo "Генерация $RECORDS записей в файл $LOG_FILE"

    for ((i = 1; i <= RECORDS; i++)); do
        IP=$(generate_ip)
        STATUS_CODE=${STATUS_CODES[RANDOM % ${#STATUS_CODES[@]}]}
        METHOD=${METHODS[RANDOM % ${#METHODS[@]}]}
        USER_AGENT=${USER_AGENTS[RANDOM % ${#USER_AGENTS[@]}]}
        URL=${URLS[RANDOM % ${#URLS[@]}]}
        RAW_TIME=$(generate_time "$day")
        TIME=$(format_date "$RAW_TIME")

        echo "$IP - - $TIME \"$METHOD $URL HTTP/1.1\" $STATUS_CODE - \"-\" \"$USER_AGENT\"" >> "$LOG_FILE"
    done

done

# Коды ответов:
# 200: Успешный запрос
# 201: Успешное создание ресурса
# 400: Некорректный запрос
# 401: Неавторизован
# 403: Доступ запрещен
# 404: Ресурс не найден
# 500: Внутренняя ошибка сервера
# 501: Метод не реализован
# 502: Ошибка шлюза
# 503: Сервис временно недоступен