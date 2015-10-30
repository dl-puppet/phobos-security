class system::yum inherits system
{
  
     File {
      ensure          => $system::file_ensure,
      group           => $system::file_group,
      mode            => $system::file_mode,
      owner           => $system::file_owner,
      backup          => $system::file_backup,
  }

    file {
      
	    # Configuration fichier sysctl.conf: 
	    "/etc/yum.conf" :
	    content => template("system/yum/yum.conf.erb");
	    
	    # Fichier de log yum: 
	    "/var/log/yum.log" :
  
	    # certificat de droit/Abonnemnts lié au system: 
	    "/etc/pki" :
	    ensure 			=> directory;
	    
	    # Contient les certificats indiquant les produits RedHat installé: 
	    "/etc/pki/product" :
	    ensure 			=> directory; 
	       
	    "/etc/pki/product/69.pem" :
	    content => template("system/yum/69.pem.erb");
	           
	    # Contient les certificats indiquant le compte RedHat sur lequel le system est enregistre: 
	    "/etc/pki/consumer" :
	    ensure 			=> directory;       
	    
	    # Contient les certificats indiquant quels abonnements sont joints au système: 
	    "/etc/pki/entitlement" :
	    ensure 			=> directory;   
	    
	    # Liste de repo (content *.repo)
	    /etc/yum.repos.d/ 
   
    }
    
    # Abonnements des produits: MAJ, contrat assistance, abonnements système:  packagekit / yum
    # Enregistrer: association à un compte RedHat (inventaire). L'inscription d'un systeme au service de gestion des abonnements configure
    # automatiquement l'acces aux depots logiciels en fonction des abonnements liés:
    	#Enregistrer un système sur un compte RedHat: subscription-manage register --username=toto password=toto
    	#Lier un abonnement automatiquement: subscription-manage attach --auto  
    	# Retirer l'enregistrement d'un systeme: subscription-manager unregister
    # Abonner: accorder les MAJ, niveaux d'assistance, date , expiration, dépots
    # Activation depot: activation des depots disponible pour l'abonnement et MAJ
    # Examiner et suivre: Droits disponible ou utilisés (info d'abonnement):  (outil 'rct' est aussi disponible)
    	# Afficher les abonnements disponibles: subscription-manager list --available | less
    	# Afficher les abonnements utilisés: subscription-manager list --consumed
    
    # on peut utiliser subscription-manager avec des keys plutot que nom/password
    
}