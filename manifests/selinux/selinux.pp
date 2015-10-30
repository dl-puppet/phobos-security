class system::selinux inherits system
{
      File {
      ensure          => $system::file_ensure,
      group           => $system::file_group,
      owner           => $system::file_owner,
      backup          => $system::file_backup,
  }

    file {
        #fichier de configuration des default options pour les commandes 'useradd' et 'groupadd'
        "/etc/login.defs" :
        content => template("system/login.defs.erb");
        
        }
# protection des données users contre des services système compromis
# reglage des controle d'accès obligatoire
# exemple:  Acces Apache => /var/www/html; /tmp; /var/tmp
# afficher les régles SELinux avec l'option 'Z' valable pour: ps, ls, cp, mkdir):  ps axZ
# régle selinux en positionnant les étiquette (Contexte) SELinux => détermine processus + acces fichier + répertoire + ports
# si absence de réglle, aucun accès n'est autorisé

# contexte SELinux:
# user
# role
# type de niveau :  xxxx_t  (httpd_t => daemon apache; httpd_sys_content_t => /var/www/html ;  tmp_t => /tmp; /var/tmp; http_port_t => port)
#
#
# Les modes SELinux:
# Afficher le mode actuel: getenforce
# modifier le mode actuel: setenforce 1/0  ou passer au noyau "selinux=  et/ou enforcing="
# mode strict : refuse activement l'accès. SELinux journalise et protège
# mode permissif : (mode débug) pour résoudre des problèmes. SELinux autorise toutes les interactions et journalise toutes les opérations qu'il aurait refusées
# mode désactivé: désactive complétement SELinux
#
# Modifier le contexte SELinux d'un fichier par d'autre: chcon et restorecon (package policycoreutil)
# exmple changer contexte:  chcon -t httpd_sys_content_t  /toto
# exemple restaurer le contexte par defaut: restorecon -v /toto 
#
# Modifier le contexte SELinux par defaut (utiliser par restorecon): semanage (package policycoreutils-python) fcontext
# exmple:  semanage fcontext -a -t httpd_sys_content_t '/virtual(/.*)?'
#
# Afficher les booleens SELinux:  getsebool -a
#
# voir régles pour fichier distant : NFS, CIFS
#
# Surveillance SELinux :
# Package 'setroubleshoot-server' permet d'envoyer les messages SELinux à /var/log/messages. 
# sealert -l UUID sert à produire un rapport de l'incident uuid spécifié (uuid present dans les log system)
# sealert -a /var/log/audit/audit.log sert a produire des rapports pour tous les incidentsde ce fichier



}
