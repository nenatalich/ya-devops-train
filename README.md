### Bingo

Задание выполнялось в рамках тренировок по DevOps от Яндекса, подробнее тут https://yandex.ru/yaintern/training/devops-training 
Условия задания в файле [task.md](task.md)
По итогам проверки занял второе место в рейтинге решений.

#### Запуск
_Образ контейнера собран и запушен руками_ 
1. Указать свои значения в файле terraform/terraform.tfvars, для примера есть рядом terraform.tfvars.sample
2. Установить зависимости ансибла `ansible-galaxy role install -r requirements.yml`
3. В каталоге terraform выполнить `terraform apply`
4. В каталоге ansible выполнить `ansible-playbook playbook.yaml`
5. Приложение готово к работе 
   * Будет доступно на хосте nginx, адрес можно посмотеть в консоли яндекса или в файле ansible/hosts.yaml



#### Общая схема автоматической установки
* Терраформ создает 6 тачек, где две для бинго, одна для nginx, две для постгре и одна для мониторингов. 
* Так же терраформ генерирует файл hosts.yaml и db_vars.yaml для ансибла.
* Ансибл устанавливает бд, настраивает слейв, накатывает схему и миграции, подготавливает всё для приложения 
(генерирует конфиг, создает директории) и запускает его.
* Рядом с бинго так же поднимается promtail для отправки логов в loki, но loki надо уже поднимать руками


#### Что докручено руками после автоматизации
* Установлен самоподписаный сертификат для nginx
* Поднят мониторинг, достаточно скопировать всю папку services/monitoring и выполнить docker-compose up -d
* Настройка logrotate на тачках с бинго
* Настройка nginx экспортера для prometheus, но в итоге выбрал не тот и нет статистики по ручкам


### Нюансы бинго
* Добавлен healthcheck на /ping в контейнере
* Запрет на поход в google dns
* Добавлены индексы в бд
* Порт и директория для логов зависит от student_email в конфиге бинго

### Техдолг
_Не в порядке важности_
* http3
* Пайплайн сборки и пуша образа в реджистри
* Резервирование балансера
* Масштабирование терраформом через count
* Есть хардкод в некоторых местах развертывания, не успел вынести
* Не все таски в ансибле идемпотентны
* Локи не закрыт авторизацией
* Пароль графаны захардкожен в docker-compose
* Не сильно настроены лейблы логов
* Для бд разрешены все соединения, надо разрешать только с тачек бинго
* Не безопасно забирается контейнер из реджистри, надо бы выпускать временные токены для пула контейнеров, а не держать ключ на тачке
* Мониторинг ручек приложения
