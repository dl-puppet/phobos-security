  class system::ssh inherits system
{
  
 #Il existe des solutions permettant de sécuriser un minimum les transactions.
 #Nous allons voir rapidement quelques modes d'utilisation de ssh et de logiciels 
 #comme scp, sftp, unisson et rsync 
 #Avec ssh, il sera possible d'établir un tunnel crypté (ou chiffré) entre le client et le serveur.
   #package {'openssh-server.x86_64':
   #       ensure => installed,
   #       before => File['/etc/ssh/sshd_config'],
   #}
   #Sur la machine serveur vous allez avoir 2 processus serveurs. 
   #Le serveur pop3 et le serveur SSH. Sur le client, vous allez également avoir 
   #2 processus. Le client pop3 et le client ssh. 
   #Le client pop3 se connecte au tunnel (le client ssh local). 
   #Le serveur pop3, est relié au serveur ssh distant. 
   #Les transactions passent dans le tunnel.
#Le client ssh devient un serveur mandataire (proxy) pour le protocole tunnelé. Le serveur ssh devient le client proxy pour le serveur. 
 
 #Les packages OpenSSH requièrent le paquetage OpenSSL (openssl).
#penSSH général, (openssh), 
#le serveur OpenSSH (openssh-server) 
#le client (openssh-clients).

#OpenSSH est constitué de deux ensembles de fichiers de configuration
#Il y a un fichier de configuration pour les programmes clients (ssh, scp et sftp) et l'autre pour le service serveur(sshd). 
#Les informations de configuration SSH qui s'appliquent à l'ensemble du système sont stockées dans le répertoire /etc/ssh.

ssh_config               fichier de configuration client SSH pour l'ensemble 
                         du système. Il est écrasé si un même fichier est
                         présent dans le répertoire personnel de
                         l'utilisateur 
                         (~/.ssh/config). 
sshd_config              fichier de configuration pour sshd. 
ssh_host_dsa_key         clé DSA privée utilisée par sshd. 
ssh_host_dsa_key.pub     clé DSA publique utilisée par sshd. 
ssh_host_key             clé RSA privée utilisée par sshd pour la 
                         version 1 du protocole SSH. 
ssh_host_key.pub         clé RSA publique utilisée par sshd pour la 
                         version 1 du protocole SSH. 
ssh_host_rsa_key         clé RSA privée utilisée par sshd pour la 
                         version 2 du protocole SSH. 
ssh_host_rsa_key.pub     clé RSA publique utilisée par sshd pour la 
                         version 2 du protocole SSH. 

   Les informations spécifiques à un utilisateur sont stockées dans son répertoire personnel à l'intérieur du répertoire ~/.ssh/:
    authorized_keys ou parfois   authorized_keys2
                           ce fichier contient une liste de clés
                           publiques "autorisées". Si un utilisateur
                           se connecte et prouve qu'il connaît la clé
                           privée correspondant à l'une de ces clés, 
                           il obtient l'authentification. Notez qu'il
                           ne s'agit que d'une méthode d'authentification 
                           facultative. 

id_dsa                     contient l'identité d'authentification 
                           DSA de l'utilisateur. 
id_dsa.pub                 la clé DSA publique de l'utilisateur. 
id_rsa                     la clé RSA publique utilisée par sshd pour
                           la version 2 du protocole SSH. 
identity                   la clé RSA privée utilisée par sshd pour la 
                           version 1 du protocole SSH. 
known_hosts                ce fichier contient les clés hôte DSA des
                           serveurs SSH auxquels l'utilisateur s'est connecté. 

                    

   File {
      ensure          => $system::file_ensure,
      group           => $system::file_group,
      owner           => $system::file_owner,
      backup          => $system::file_backup,
   }
  
		  file    { 
		          "/etc/ssh/sshd_config":
		          content => template('system/sshd_config.erb'),
		          mode    => '0600';
   
		          "/home/stgeopen/.ssh":
		          ensure => "directory",
		          owner  => "stgeopen",
		          group  => "stgeopen",
		          mode   => 700;
		          
		          "/home/stgeopen/.ssh/authorized_keys":
		          source => 'puppet:///modules/user/authorized_keys',
		          mode    => '0600',
		          owner   => 'stgeopen',
		          group   => 'stgeopen';
		   }
		   
		  #service { 'sshd':
      #    ensure => 'running',
      #    enable => 'true',
      #    hasrestart => 'true',
      #    hasstatus => 'true',
      #    subscribe => File['/etc/ssh/sshd_config'],
      #    require => Package['openssh-server.x86_64'],
      #}
	   
}




