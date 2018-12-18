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

