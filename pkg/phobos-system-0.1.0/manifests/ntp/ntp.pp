class system::ntp inherits system
# voir l'outil 'timedatectl RHL7 et le service 'chronyd' (/etc/chrony.conf) : chronyc sources -v
# tzselect :  identifiez le fuseau horaire
{
  File {
      ensure          => $system::file_ensure,
      group           => $system::file_group,
      #mode            => $system::file_mode,
      owner           => $system::file_owner,
      backup          => $system::file_backup,
  }
       
    file {
			"/etc/ntp.conf" : 
			content         => template("system/ntp.conf.erb"),
			mode            => '0744' ;
			#require        => Class['ntp::install'],
    }

}
