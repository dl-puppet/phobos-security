# Configuration du logiciel

class ntp::config inherits ntp
{

	file { $ntp::file_name :
    	path            => $ntp::file_path,
		ensure          => $ntp::file_ensure,
		backup          => $ntp::file_backup,
		content 		=> template($ntp::file_content),   
		group           => $ntp::file_group,
		mode            => $ntp::file_mode,
		owner           => $ntp::file_owner,
		require 		=> Class['ntp::install'],
	}

	#if $ntp::log_manage == true {

	#    file { $ntp::log_name :
	#    	path   => $ntp::log_path,
	#      	ensure => $ntp::log_ensure,
	#      	backup => $ntp::log_backup,
	#      	group  => $ntp::log_group,
	#      	mode   => $ntp::log_mode,
	#      	owner  => $ntp::log_owner,
	#    }

	#}

}