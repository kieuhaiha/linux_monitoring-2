## Part 8. Готовый дашборд

##### Установил готовый дашборд *Node Exporter Full* с официального сайта **Grafana Labs**

![part8_monitoring](/src/screenshots/21.jpg)

##### Провел те же тесты, что и в Part 7

Нагрузка жесткого диска (место на диске и операции чтения/записи и т.д) после запуска bash-скрипта из Part 2

![part8_monitoring](/src/screenshots/25.jpg)
![part8_monitoring](/src/screenshots/22.jpg)
![part8_monitoring](/src/screenshots/23.jpg)
![part8_monitoring](/src/screenshots/24.jpg)

Нагрузка жесткого диска, оперативной памяти и ЦПУ после выполнения команды `stress -c 2 -i 1 -m 20 --vm-bytes 64M -t 150s`

![part8_monitoring](/src/screenshots/26.jpg)
![part8_monitoring](/src/screenshots/27.jpg)

##### Запустил ещё одну виртуальную машину, находящуюся в одной сети с текущей
##### Запустил тест нагрузки сети с помощью утилиты **iperf3**

На первой машине (ws1),запустил `iperf3` в режиме сервера: `iperf3 -s`
Сервер будет ожидать подключения клиентов на порту 5201 по умолчанию

![part8_monitoring](/src/screenshots/28.jpg)

На второй машине (ws2), запустил `iperf3` в режиме клиента: `iperf3 -c 10.20.0.20 -t 150`

![part8_monitoring](/src/screenshots/29.jpg)

Мониторинг нагрузки сетевого интерфейса в Grafana

![part8_monitoring](/src/screenshots/30.jpg)
