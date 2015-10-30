# Avant "system init":  ID1 = init
# les daemons moins utilisés étaient lancé par un autre service: initd ou xinetd qui reste a l'ecoute des connexions clients

# Maintenant "systemd : ID1
# les fichiers de configuration comportant des variables shell telles que contenu dans le fichier /etc/sysconfig sont remplacés.
# Il sont intégrés en tant que fichie d'envirronnement systemd et lus en tant que paire NOM=VALEUR (ils ne proviennent plus de scripts shell)

# systemctl : commande qui gére différent types d'objet systemd (unités)
# systemctl -t help : affiche la liste des types d'unités (.service, .socket (inter-processus IPC), .path (attend une modif)
# systemctl stop/start/restart/reload sshd.service
# systemctl status toto.type : affiche l'etat du service (-l pour afficher la sortie complete) (ex: systemctl status sshd.service) repelnce : service toto status
# systemctl : etat de toutes les unites
# systemctl --type=service : etat de toutes les unites de type service
# systemctl is-active/is-enable sshd : afficher si l'unite est demarrer active) et lancer au demarrage (enable)
# systemctl list-units --type=service (--all): list des unites chargé 'active' et 'desactive' de toutes les unités
# systemctl list-unit-files --type=service :  liste des unites activé et desactivé de toutes les unites
# systemctl --failed --type=service : afficher uniquement les services en état d'échec
# systemctl mask/unmask network :  masque/demasque les unites de la list (ne peut plus etre utilisé)
# systemctl list-dependencies graphical.target: affiche une liste des autres unités qui doivent démarré en meme temps.
#
# systemctl isolate multi-user.target  : Basculer vers d'autre cible (mode de démarrage system). Seules les 
# cilbles dont les fichiers d'unité présente la ligne 'AllowIsolate=yes' peuvent être isolées.
#
# systemctl enable debug-shell.service :  active un shell de debug accessible par le TTY9 (ctrl+alt+f9)
#
#/etc/systemd/system/default.target
#/etc/systemd/system

#Demarrage/Redemarrage/Arret:
# systemctl poweroff: arrete tous les ervices, demonte les FS, puis arrête le système 
# systemctl halt : ne coupe pas l'alimentation du system
# systemctl reboot: arrete tous les ervices, demonte les FS, puis reboot
# 
# /etc/systemd/system/default.target   et   /etc/systemd/system/
# graphical.target
# milti-user.target
# rescue.target
# emergency.target 
# systemctl list-dependencies graphical.target  (pour voir)
 