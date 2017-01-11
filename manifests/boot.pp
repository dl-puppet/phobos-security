 class system::boot
(
  $shutdown_name            = $system::shutdown_name,
  
) 
{
  case $::osfamily {
		'RedHat': {
						  ######### PACKAGES ########
						  Package {       
						      ensure               => $system::package_ensure_boot,         
						  }
						  
						    $package_name   = ['initscripts','chkconfig','ntsysv', 'grubby', 'grub'],
						    package { $package_name : }
						
						   
						        
						  ###### CONFIG_FILES ######      
						  File {
						      ensure          => $system::file_ensure_boot,
						      group           => $system::file_group_boot,
						      mode            => $system::file_mode_boot,
						      owner           => $system::file_owner_boot,
						      backup          => $system::file_backup_boot,
						  }
						  
						      file {
						        
						      #####################################  
						      # Fichier d'autorisation pour l'arrêt système
						      #####################################
						      "/etc/shutdown.allow" : 
						      content         => template("system/boot/shutdown.allow.erb"); 
						      
						      
						      #####################################
						      #Configuration du noyau:
						      #####################################
				          $boot = 
							    "/boot/" :
							    #AIX /unix (lien symbolique cers /usr/lib/boot/unix)
						      #Linux /boot/vmlinuz
							    ensure => directory,
							    source => ["puppet:///modules/system/$boot"],
							    recurse => true,
							    backup => false;
						      
						      # Configuration de Grub  et Grub2: (il y a une différence importante entre Grub et Grub2 dans la numérotation des partitions )
						      # après les modifications de grub.conf : update-grub
						      "/boot/grub/grub.conf" : 
						      content         => template("system/boot/grub.conf.erb"); 
						        
								      "/boot/grub/menu.lst" :
								      ensure => link,
								      target => "/boot/grub/grub.conf;       
								
													# Pou RHL7 a verifier:
													# tools 'grub2-mkconfig > /boot/grub2/grub.cfg' permet de générer le fichier de config grub.cfg
													# /etc/grub.d/  (sous Debian)
													# /etc/default/grub (sous Debian)
													# /boot/grub2/grub.cfg
						
						
						      #####################################
									# PID0: innitramfs  (file cpio gzip)
									#####################################
						      "/etc/dracut.conf" : 
						      content         => template("system/boot/dracut.conf.erb"); 
						      
						      
						      #####################################      
									# PID1: /sbin/init (systemd sous RHL7)   &&  démon udev
									#####################################
									# initrd.target qui inclus montage /sysroot  (voir /etc/fstab)
									# bascule de initramfs vers /sysroot.systemd
									# /etc/systemd/system/default.target   ( pour modifier le lien : systemctl get-default / systemctl set-default xxxx)
									  # graphical.target
									  # milti-user.target
									  # rescue.target
									  # emergency.target (boot pour diagnostiquer et corriger des pbs)
									    # rd.break :  demarrer sur un shell admin sans login   
									# systemctl list-dependencies graphical.target  (pour voir les dépendances)
									# systemctl isolate multi-user.target  : Basculer vers d'autre cible (mode de démarrage system). Seules les 
									# cibles dont les fichiers d'unité présente la ligne 'AllowIsolate=yes' peuvent être isolées	
									
									#AIX /unix (lien symbolique cers /usr/lib/boot/unix)
									#Linux /boot/vmlinuz	
									#Les niveau peuvent être adaptés, afin d'activer certains logiciels automatiquement au démarrage.
									# relancer le programme pour changer dynamiquement de configuration.
									#Les processus non associés au nouveau niveau demandé sont alors éliminés.
									#Il est possible de changer le niveau d'exécution par défaut au moment du démarrage en modifiant les arguments transmis par le chargeur de démarrage au noyau.
											 		 
									      # Mise en place fichier INITTAB:
									      # sous AIX: INIT 2  Niveau multiuser par defaut
						            # INIT 3  Niveau multiuser avec utilisateur d'un serveur en mode texte
						            # INIT 4  Niveau multiuser utilisé pour une configuration personnalisée.
									      "/etc/inittab" : 
									      content         => template("system/boot/inittab.erb");
									
									      # Mise en place des scripts pour applications :
									      "/etc/rc.d/rc.local": 
									      content         => template("system/boot/rc.local.erb"); 
									
									          "/etc/rc.d/rc4.d/S99rc.local" :
									          ensure => link,
									          target => "/etc/rc.d/rc.local";
									
									          "/etc/rc.d/rc4.d/K00rc.local" :
									          ensure => link,
									          target => "/etc/rc.d/rc.local";       
						     }  					     
			} 
    }
}
