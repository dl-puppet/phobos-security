class system::user inherits system
{

#Le comportement par défaut de création des comptes est piloté par /etc/adduser.conf.
#On peut y définir le shell de connexion proposé par défaut, 
#le nom du répertoire contenant les home directories, 
#l'endroit des squelettes (les profils), etc...
#L'ajout de groupes et d'utilisateurs se fait respectivement par les commandes addgroup et adduser.

    #Definition des groupes: 
		Group {
		ensure      => 'present',
		attribute_membership => 'minimum', 
		}
				group   { 
				          "stgeopen":
				          gid         => "2020";

				 }

    #Definition des users: 
		User {
		ensure          => 'present',
    allowdupe       => 'false',
    expiry          => 'absent',
    managehome      => 'true',
    purge_ssh_keys  => 'false',
    shell           => '/bin/bash',
		}

				 user { 
				          "stgeopen":
				          comment   => 'stge-user',
				          groups    => 'stgeopen',
				          uid       => '2020',
				          home      => '/home/stgeopen/';
				 }
				 
				 
				 
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

        "/etc/passwd" :
        #user:pwd:uid:gid:gecos:home:shell
        # la configuration par defaut pour 'useradd' et 'groupadd' se fait dans /etc/login.defs
        # Plage UID:
        # 0 => root
        # 1-200 => User statique aux processus système
        # 201 - 999 => User systeme (dynamique) qui ne sont pas proprietaire de fichiers sur le FS. 'Application sans privilége'
        # 1000+ => assignation des utilisateur standard 
        content => template("system/passwd.erb");
        
        "/etc/group" :
        content => template("system/group.erb");
        
        "/etc/shadow" :
        #user:$crypt-sel utiliser pour chiffrer/le hach/
        #l'algo utilisé '$crypt'  =>  1=MD5 ; 5=SHA-256; 6=SHA-512 (defaut RHL7) #peut etre modifier par la commande 'authconfig --passalgo [md5,sha256,sha512] ' 
        #sel: Permet creer un hash different pour deux user qui utilise le meme mot de passe
        # Les options peuvent etre changé avec l'outil 'chage': 
              # chage -m 0 -M 90 -w 7 -I 14 username
              # chage -E $(date +%y-%m-%d -d +90days) username  
        #user:pwd:lastchange:minage:maxage:warning:inactive:expire:blank
        # minage: nombre de jour mini avant changement pwd (0 = pas d'age mini)
        # maxage: nombre de jour max avant changement pwd
        # warning: periode d'avertissment avant expiration (0 = aucun avertissement)
        # inactive: nombre de jour pendant lesquels un compte demeure actif après expiration du pwd. Après le compte est vérouillé (peut etre verrouillé par: usermod -L (-U pour dévérouiller)
        # expire: date d'expiration du compte. Représente le nombre de jour depuis 01/01/1970. Peut etre calculé par: date -d "+45 days"
        # blanck : champ vierge
        content => template("system/shadow.erb");
        
    }   		 
				 
				 
}
