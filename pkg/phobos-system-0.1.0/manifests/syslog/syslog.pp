# Protocole standard 'syslog' pour enregistrer et trier les fichiers journaux
# le service "systemd-journald"  transmet le message à  rsyslog qui trie les messages par type, fonction, priorité
# voir l'outil 'journactl' pour analyser les logs
# puis les écris dans /var/log/*
# Le fichier de configuration /etc/rsyslog.conf et dans /etc/rsyslog.d
# Priorité: 0=emerg; 1=alert; 2=crit; 3=err; 4=warning; 5=notice; 6=info; 7=debug
# /var/log/messages: full log syslog
# /var/log/secure: lié à la sécurité et à l'identification
# /var/log/maillog: lié au serveur de messagerie
# /var/log/cron: lié aux tâches planifiés
# /var/log/boot.log: lié au démarrage systeme
#
# Activation crontab pour logrotate
# logger permet d'envoyer un message syslog. Par defaut il est envoyer au user du service avec le niveau "notice"
# ex: logger -p local7.notice "toto text"