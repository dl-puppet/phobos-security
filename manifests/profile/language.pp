class system::network inherits system
{

#gnome-control-center-region config de l'environment gnogme , gnogme-terminal mais pas les connexions distantes ssh
# ou par une console local en mode texte (tty2,3...)


#Le contenu du fichier /etc/profile sera exécuté (réglages génériques pour tous les utilisateurs). 
#Selon le shell de connexion, d'autres scripts seront utilisés : 
#si il s'agit d'un shell de login, et que le shell est bash, alors ~/.bash_profile ou ~/.bash_login ou ~/.profile seront lus. A la déconnexion, ~/.bash_logout sera exécuté.

#Si il s'agit d'une connexion distante, d'un sous-shell, ou d'un xterm, alors /etc/bash.bashrc puis ~/.bashrc seront exécutés.

#activez la complétion étendue (tapez . /etc/bash_completion .
#Consultez vos propres fichiers de connexion (.bash_profile, et .bashrc). Modifiez .bash_profile afin qu'il exécute .bashrc (ainsi, .bashrc est exécuté toujours, en shell de login ou autre). Puis, dans .bashrc, dé commentez l'accès à /etc/bash_completion.
 
#/etc/skel :vous trouverez le squelette de tous les nouveaux comptes : tout ce qui y est présent sera recopié par défaut dans le répertoire de chaque nouvel utilisateur
#Créez ce répertoire et un texte 'mode_d_emploi_du_reseau.txt' dans le répertoire /etc/skel.



 File {
      ensure          => $system::file_ensure,
      group           => $system::file_group,
      owner           => $system::file_owner,
      backup          => $system::file_backup,
  }

    file {
      
        # Configuration fichier baschrc: 
        "/root/.bashrc" :
        content => template("system/bashrc.erb");
    }    


}
