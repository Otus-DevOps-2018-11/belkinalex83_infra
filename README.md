# belkinalex83_infra
belkinalex83 Infra repository

bastion_IP = 35.198.155.250
someinternalhost_IP = 10.156.0.3

Способ подключения к someinternalhost в одну команду из рабочего устройства:
ssh -i ~/.ssh/privatekey user@someinternalhost-ip -o "proxycommand ssh -W %h:%p -i ~/.ssh/privatekey user@bastion-ip"

Способ подключения из консоли при помощи команды ssh someinternalhost из локальной консоли рабочего устройства
Необходимо добавить в ~/.ssh/config такие строки:
Host bastion
  Hostname bastion-ip
  User user
  IdentityFile  ~/.ssh/privatekey
Host someinternalhost
  Hostname someinternalhost-ip
  IdentityFile ~/.ssh/privatekey
  User user
  ProxyCommand ssh -W %h:%p user@bastion

============================================================

ДЗ4:

Данные для подключения:
testapp_IP = 35.233.123.8
testapp_port = 9292

командa gcloud для запуска инстанса с уже запущенным приложением:

gcloud compute instances create reddit-app-startup \
 --boot-disk-size=10GB \
 --image-family ubuntu-1604-lts \
 --image-project=ubuntu-os-cloud \
 --machine-type=g1-small \
 --tags puma-server \
 --restart-on-failure \
 --metadata-from-file startup-script=startup.sh

командa gcloud для запуска инстанса с уже запущенным приложением с использованием загрузки скрипта из URL:

gcloud compute instances create reddit-app-startup-url \
 --boot-disk-size=10GB \
 --image-family ubuntu-1604-lts \
 --image-project=ubuntu-os-cloud \
 --machine-type=g1-small \
 --tags puma-server \
 --restart-on-failure \
 --metadata startup-script-url=gs://devops-startup-scripts/startup.sh \
 --scopes storage-ro

командa gcloud для создания правила файерволла для работы приложения default-puma-server.
gcloud compute firewall-rules create default-puma-server \
--allow=tcp:9292 \
--target-tags=puma-server

============================================================

ДЗ5:

В процессе сделано:

- Установка Packer
- Создал ADC для доступа Packer к GCP.
- Создал шаблон Packer для сборки  базового образа ubuntu с установленными ruby и mongodb и задеплоил в него приложение.
- Параметризировал созданный шаблон, добавил в шаблон несколько переменных, файл variables.json в .gitignore и variables.json.example в репозиторий.
- Создал образ семейства reddit-full, добавив в него systemd unit для автозагрузки веб-сервера Puma с приложением и деплой приложения (задание со *)
- Добавил скрипт создания машины из готового образа redit-full (задание со *).

