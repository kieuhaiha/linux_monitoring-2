#!/bin/bash 
 
# Проверка числа параметров 
if [ $# -ne 6 ]; then 
  echo "Скрипт запускается с 6 параметрами." 
  exit 1 
fi 
 
# Параметры 
DEST_DIR=$1 
FOLDER_COUNT=$2 
FOLDER_LETTERS=$3 
FILE_COUNT=$4 
FILE_LETTERS_EXT=$5 
FILE_SIZE=$6 
 
# Проверка существования директории 
if [[ ! -d "$DEST_DIR" ]]; then 
    echo "Директория не существует: $DEST_DIR." 
    exit 1
fi 

# Проверка свободного места 
FREE_SPACE=$(df "$DEST_DIR" --output=avail | tail -1 | tr -d ' ') 
if [[ -z "$FREE_SPACE" || "$FREE_SPACE" -lt 1048576 ]]; then 
  echo "Недостаточно места на диске для $DEST_DIR." 
  exit 1 
fi 
 
# Проверка параметров 
if [[ ! $FOLDER_COUNT =~ ^[0-9]+$ ]] || [[ $FOLDER_COUNT -le 0 ]]; then 
  echo "Количество папок должно быть положительным числом." 
  exit 1 
fi  
 
if [[ ${#FOLDER_LETTERS} -lt 1 || ${#FOLDER_LETTERS} -gt 7 || ! $FOLDER_LETTERS =~ ^[a-zA-Z]+$ ]]; then
  echo "Список букв для папок должен быть длиной от 1 до 7 символов и содержать только латинские буквы." 
  exit 1 
fi 

if [[ ! $FILE_COUNT =~ ^[0-9]+$ ]] || [[ $FILE_COUNT -le 0 ]]; then 
  echo "Количество файлов должно быть положительным числом." 
  exit 1 
fi 

IFS='.' read -r FILE_LETTERS FILE_EXT <<< "$FILE_LETTERS_EXT" 
 
if [[ -z "$FILE_LETTERS" || ${#FILE_LETTERS} -lt 1 || ${#FILE_LETTERS} -gt 7 || ! "$FILE_LETTERS" =~ ^[a-zA-Z]+$ ]]; then 
  echo "Имя файла должно быть длиной от 1 до 7 символов и содержать только латинские буквы." 
  exit 1 
fi 
 
if [[ -z "$FILE_EXT" || ${#FILE_EXT} -lt 1 || ${#FILE_EXT} -gt 3 || ! "$FILE_EXT" =~ ^[a-zA-Z]+$ ]]; then 
  echo "Расширение файла должно быть длиной от 1 до 3 символов и содержать только латинские буквы." 
  exit 1 
fi 
 
if [[ ! $FILE_SIZE =~ ^[0-9]+(kb|KB|Kb|kB)$ ]]; then 
  echo "Размер файла должен быть указан в килобайтах, например 3kb." 
  exit 1 
fi 
 
FILE_SIZE=${FILE_SIZE//[!0-9]/} 
if [[ $FILE_SIZE -le 0 ]] || [[ $FILE_SIZE -gt 100 ]]; then 
  echo "Размер файла должен быть от 1 до 100 килобайт." 
  exit 1 
fi 
 

generate_name() { 
  local base_name=$1 
  local index=$2 
  local min_length=4  
 
  while [ ${#base_name} -lt $min_length ]; do 
    base_name+="${base_name:0:1}" 
  done
 
  local len=${#base_name} 
  for (( i=0; i<index; i++ )); do 
    base_name+="${base_name:i%len:1}" 
  done 
 
  echo "$base_name" 
} 
 

mkdir -p "$DEST_DIR" 
LOG_FILE="$DEST_DIR/log.txt" 
> "$LOG_FILE" 
 
for ((i = 0; i < FOLDER_COUNT; i++)); do 
  FOLDER_NAME=$(generate_name "$FOLDER_LETTERS" "$i")_$(date +%d%m%y) 
  FOLDER_PATH="$DEST_DIR/$FOLDER_NAME" 
  mkdir -p "$FOLDER_PATH" 
  if [ $? -ne 0 ]; then 
    echo "Не удалось создать папку $FOLDER_PATH." 
    echo "Не удалось создать папку $FOLDER_PATH." >> "$LOG_FILE" 
    continue 
  fi 
  echo "Создана папка: $FOLDER_PATH, Дата: $(date +%d.%m.%Y)" >> "$LOG_FILE" 
 
  for ((j = 0; j < FILE_COUNT; j++)); do 
    FILE_NAME=$(generate_name "$FILE_LETTERS" "$j")_$(date +%d%m%y)."$FILE_EXT" 
    FILE_PATH="$FOLDER_PATH/$FILE_NAME" 
    dd if=/dev/zero of="$FILE_PATH" bs=1K count=$FILE_SIZE status=none 
    if [ $? -eq 0 ]; then 
      echo "Создан файл: $FILE_PATH, Дата: $(date +%d.%m.%Y), Размер: ${FILE_SIZE}KB" >> "$LOG_FILE" 
    else 
      echo "Не удалось создать файл $FILE_PATH." >> "$LOG_FILE" 
    fi 
  done 
 
done