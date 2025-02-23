## Part 7. **Prometheus** и **Grafana**

#### Установил и настроил Prometheus и Grafana на виртуальную машину, также получил доступ к веб интерфейсам Prometheus и Grafana с локальной машины

![part7_monitoring](/src/screenshots/10.jpg)
![part7_monitoring](/src/screenshots/11.jpg)

Для того чтобы Prometheus мог собрать метрики о состоянии сервера (CPU, память, диски, сеть и т.д.), необходимо установить Node Exporter. Это специальный экспортер, который преобразует данные о состоянии сервера в метрики, понятные Prometheus

![part7_monitoring](/src/screenshots/12.jpg)

#### Добавил на дашборд Grafana отображение ЦПУ, доступной оперативной памяти, свободное место и кол-во операций ввода/вывода на жестком диске

![part7_monitoring](/src/screenshots/13.jpg)
![part7_monitoring](/src/screenshots/14.jpg)
![part7_monitoring](/src/screenshots/15.jpg)


##### Запустил bash-скрипт из Part 2 для засорения файловый системы

![part7_monitoring](/src/screenshots/16.jpg)
![part7_monitoring](/src/screenshots/17.jpg)

#### На графике выше видно, как метрики меняются после запуска скрипта. Это позволяет сделать вывод, что сбор метрик работает корректно

##### Установил утилиту **stress** и запустил команду `stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 150s`
![part7_monitoring](/src/screenshots/18.jpg)

![part7_monitoring](/src/screenshots/19.jpg)
![part7_monitoring](/src/screenshots/20.jpg)

На графике выше видно, как метрики меняются после запуска команды `stress`. Это позволяет сделать вывод, что сбор метрик работает корректно.




