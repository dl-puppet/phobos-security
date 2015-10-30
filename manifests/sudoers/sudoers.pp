 class system::sudoers inherits system
{

  File {
      ensure          => $system::file_ensure,
      group           => $system::file_group,
      owner           => $system::file_owner,
      backup          => $system::file_backup,
  }

      file { '/etc/sudoers':
    			# fichier de configuration sudo:
    			# Le pwd utilisé et celui du compte actuel:
    			# La journalisation de sudo s'effectue dans /var/log/secure
                content => template('system/sudoers.erb'),
                mode    => '0664',
          }   
          
    #Voir utilisation du tool "PolicyKit" (equivalent au Controle de compte utilisateur (UAC) sous Windows):
    # su - : Si aucun user spécifié, le compte root est utilisé par defaut. Le pwd utilisé et celui du compte appelé.
    # l'option '-' lance un shell de connexion: Il configure l'environnement comme une connexion normal de l'utilisateur, 
    # alors que 'su' seul lance simplement un shell user mais en concervant l'environnement actuel.
    # l'option '-c' de sudo peut l'utiliser comme l'utilitaire 'runas' de windows, pour lancer un programme sous un autre id.
}
