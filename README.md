# belkinalex83_infra
belkinalex83 Infra repository

Способ подключения к someinternalhost в одну команду из рабочего устройства:
ssh -i ~/.ssh/privatekey user@someinternalhost_ip -o "proxycommand ssh -W %h:%p -i ~/.ssh/privatekey user@bastion_ip"

