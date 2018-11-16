class system::support inherits system
{

#gnome-control-center-region config de l'environment gnogme , gnogme-terminal mais pas les connexions distantes ssh
# ou par une console local en mode texte (tty2,3...)
 File {
      #ensure          => $system::file_ensure,
      group           => $system::file_group,
      owner           => $system::file_owner,
      backup          => $system::file_backup,
  }

    file {
      
        # Configuration fichier baschrc: 
        "/root/.bashrc" :
        ensure  =>  directory;
        content => template("system/bashrc.erb");   
    }


}