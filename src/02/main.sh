#!/bin/bash 

# Проверка числа параметров
if [ $# -ne 3 ]; then
  echo "Скрипт запускается с 3 параметрами."
  exit 1
fi

# Параметры
FOLDER_LETTERS=$1
FILE_LETTERS_EXT=$2
FILE_SIZE=$3
DIR=$(pwd)

if [[ "$DIR" == *bin* || "$DIR" == *sbin* ]]; then
  echo "Создание файлов в каталоге $DIR запрещено."
  exit 1
fi

check_free_space() {
  FREE_SPACE_HUMAN=$(df -h $DIR | awk 'NR==2 {print $4}' | tr -d '[:space:]')

  if [[ "$FREE_SPACE_HUMAN" == *G ]]; then
    FREE_SPACE_MB=$(echo "$FREE_SPACE_HUMAN" | sed 's/G//' | awk '{printf "%.0f\n", $1 * 1024}')
  elif [[ "$FREE_SPACE_HUMAN" == *M ]]; then
    FREE_SPACE_MB=$(echo "$FREE_SPACE_HUMAN" | sed 's/M//')
  else
    FREE_SPACE_MB=0
  fi

  if [[ "$FREE_SPACE_MB" -lt 1024 ]]; then
    return 1
  fi
  return 0
}

# Проверка параметров
IFS='.' read -r FILE_LETTERS FILE_EXT <<< "$FILE_LETTERS_EXT"

if [[ ${#FOLDER_LETTERS} -lt 1 || ${#FOLDER_LETTERS} -gt 7 || ! $FOLDER_LETTERS =~ ^[a-zA-Z]+$ ]]; then
  echo "Список букв для папок должен быть длиной от 1 до 7 символов и содержать только латинские буквы."
  exit 1
fi

if [[ -z "$FILE_LETTERS" || ${#FILE_LETTERS} -lt 1 || ${#FILE_LETTERS} -gt 7 || ! "$FILE_LETTERS" =~ ^[a-zA-Z]+$ ]]; then
  echo "Имя файла должно быть длиной от 1 до 7 символов и содержать только латинские буквы."
  exit 1
fi

if [[ -z "$FILE_EXT" || ${#FILE_EXT} -lt 1 || ${#FILE_EXT} -gt 3 || ! "$FILE_EXT" =~ ^[a-zA-Z]+$ ]]; then
  echo "Расширение файла должно быть длиной от 1 до 3 символов и содержать только латинские буквы."
  exit 1
fi

if [[ ! $FILE_SIZE =~ ^[0-9]+(mb|MB|Mb|mB)$ ]]; then
  echo "Размер файла должен быть указан в мегабайтах, например 3Mb."
  exit 1
fi

FILE_SIZE=${FILE_SIZE//[!0-9]/} 

if [[ $FILE_SIZE -le 0 ]] || [[ $FILE_SIZE -gt 100 ]]; then
  echo "Размер файла должен быть от 1 до 100 Мегабайт."
  exit 1
fi

generate_name() {
  local base_name=$1
  local index=$2
  local min_length=5

  while [ ${#base_name} -lt $min_length ]; do
    base_name+="${base_name:0:1}"
  done

  local len=${#base_name}
  for (( i=0; i<index; i++ )); do
    base_name+="${base_name:i%len:1}"
  done

  echo "$base_name"
}

START_TIME=$(date +%s)
LOG_FILE="$DIR/log.txt"
> "$LOG_FILE"

echo "Запуск скрипта: $(date +%d.%m.%Y_%T)" >> "$LOG_FILE"

for ((i = 0; i < 100; i++)); do
  if ! check_free_space; then
    echo "Остановлено: осталось менее 1 Гб свободного места." | tee -a "$LOG_FILE"
    break
  fi

  FOLDER_NAME=$(generate_name "$FOLDER_LETTERS" "$i")_$(date +%d%m%y)
  FOLDER_PATH="$DIR/$FOLDER_NAME"
  mkdir -p "$FOLDER_PATH"
  if [ $? -ne 0 ]; then
    echo "Не удалось создать папку $FOLDER_PATH."
    echo "Не удалось создать папку $FOLDER_PATH." >> "$LOG_FILE"
    continue
  fi
  echo "Создана папка: $FOLDER_PATH, Дата: $(date +%d.%m.%Y)" >> "$LOG_FILE"

  RANDOM_GENERATOR=$(shuf -i 1-10 -n 1)

  for ((j = 0; j <= RANDOM_GENERATOR; j++)); do
    if ! check_free_space; then
      echo "Остановлено: осталось менее 1 Гб свободного места." | tee -a "$LOG_FILE"
      break 2 
    fi

    FILE_NAME=$(generate_name "$FILE_LETTERS" "$j")_$(date +%d%m%y)."$FILE_EXT"
    FILE_PATH="$FOLDER_PATH/$FILE_NAME"

    dd if=/dev/urandom of="$FILE_PATH" bs=1M count="$FILE_SIZE" status=none
    if [ $? -eq 0 ]; then
      echo "Создан файл: $FILE_PATH, Дата: $(date +%d.%m.%Y), Размер: ${FILE_SIZE}MB" >> "$LOG_FILE"
    else
      echo "Не удалось создать файл $FILE_PATH." >> "$LOG_FILE"
    fi
  done
done

END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME - START_TIME))
echo "Время начала: $(date -d @$START_TIME +%T), время окончания: $(date -d @$END_TIME +%T), общее время работы: $TOTAL_TIME секунд." | tee -a "$LOG_FILE"