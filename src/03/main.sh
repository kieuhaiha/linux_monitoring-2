#!/bin/bash

LOG_FILE="log.txt"

function cleanup_by_log() {
  if [[ ! -f "$LOG_FILE" ]]; then
    echo "Log-файл не найден."
    exit 1
  fi

  echo "Очистка по лог-файлу..."
  grep -E "Создана папка" "$LOG_FILE" | awk -F', Дата:' '{print $1}' | awk -F': ' '{print $2}' | while read -r ITEM; do
    if [[ -d "$ITEM" ]]; then
      rm -rf "$ITEM" && echo "Удалена папка: $ITEM"
    else
      echo "Папка не найдена: $ITEM"
    fi
  done
  echo "Очистка завершена."
}

function cleanup_by_date() {
  echo "Очистка по дате и времени..."
  echo "Введите начальную дату и время (формат: ГГГГ-ММ-ДД ЧЧ:ММ):"
  read -r start_date
  echo "Введите конечную дату и время (формат: ГГГГ-ММ-ДД ЧЧ:ММ):"
  read -r end_date

  if ! date -d "$start_date" >/dev/null 2>&1 || ! date -d "$end_date" >/dev/null 2>&1; then
    echo "Ошибка в формате даты или времени."
    exit 1
  fi

  start_timestamp=$(date -d "$start_date" +%s)
  end_timestamp=$(date -d "$end_date" +%s)

  while IFS= read -r folder; do
    if [[ "$folder" != "." && "$folder" != ".." ]]; then
      rm -rf "$folder" && echo "Удалена папка: $folder"
    fi
  done < <(find . -type d -newermt "$start_date" ! -newermt "$end_date" ! -name '.' ! -name '..')
  echo "Очистка по дате завершена."
}


function cleanup_by_mask() {
  echo "Очистка по маске имени..."
  echo "Введите маску имени (например, *_221224):"
  read -r mask

  while IFS= read -r folder; do
    rm -rf "$folder" && echo "Удалена папка: $folder"
  done < <(find . -type d -name "$mask")
  echo "Очистка по маске завершена."
}

# Проверка параметра запуска
if [[ $# -ne 1 ]]; then
  echo "Использование: $0 <1|2|3>"
  echo "1 - Очистка по лог-файлу"
  echo "2 - Очистка по дате и времени"
  echo "3 - Очистка по маске имени"
  exit 1
fi

case $1 in
  1)
    cleanup_by_log
    ;;
  2)
    cleanup_by_date
    ;;
  3)
    cleanup_by_mask
    ;;
  *)
    echo "Неверный параметр. Используйте 1, 2 или 3."
    exit 1
    ;;
esac
