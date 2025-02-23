## Part 6. **GoAccess**

#### Запустил скрипт для генерации логов из Part 4. С помощью утилиты GoAccess получил ту же информацию что и в Part 5.
![part6_goaccess](/src/screenshots/1.png)
![part6_goaccess](/src/screenshots/2.png)
![part6_goaccess](/src/screenshots/3.png)

#### По полученной информации с дашборда:
    
- *Всего запросов:* **404**
- *Уникальных посетителей:* **244**
- *Запрошенные файлы:* **40**
- *Рефереры:* **0** (нет переходов с других сайтов)
- *Ошибки* **404** *(не найдено):* **25** запросов
- *Ошибки и исключения:* **0** заблокированных IP, **0** проваленных запросов
- *Лог-файл:* /home/hakearie/D04_LinuxMonitoring_v1.0-1/04/day_1.log


#### Открыть веб интерфейс утилиты на локальной машине.

![part6_goaccess](/src/screenshots/4.png)

- Команда `goaccess ~/DO4_LinuxMonitoring_v1.0-1/04/day_1.log -a -o part_6.html` анализирует лог-файл day_1.log с использованием формата логов COMBINED.
- Переместил сгенерированный файл в директорию `/var/www/html/`, чтобы сделать его доступным через веб-сервер.
- Теперь HTML-отчет доступен по локальному адресу: `localhost/part_6.html`

![part6_goaccess](/src/screenshots/5.png)
![part6_goaccess](/src/screenshots/6.png)
![part6_goaccess](/src/screenshots/7.png)
![part6_goaccess](/src/screenshots/8.png)
![part6_goaccess](/src/screenshots/9.png)

