# belkinalex83_infra
belkinalex83 Infra repository

Способ подключения к someinternalhost в одну команду из рабочего устройства:
ssh -i ~/.ssh/privatekey user@someinternalhost_ip -o "proxycommand ssh -W %h:%p -i ~/.ssh/privatekey user@bastion_ip"

Способ подключения из консоли при помощи команды ssh someinternalhost из локальной консоли рабочего устройства
Необходимо добавить в ~/.ssh/config такие строки:
Host bastion
  Hostname bastion_ip
  User user
  IdentityFile  ~/.ssh/privatekey
Host someinternalhost
  Hostname someinternalhost_ip
  IdentityFile ~/.ssh/privatekey
  User user
  ProxyCommand ssh -W %h:%p user@bastion
