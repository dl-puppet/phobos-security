# définition des paramètres par défaut 

class ntp::params
{

	######### PACKAGES ########
	$package_manage       	= true
	$default_package_name   = ['ntp'] 
	$package_ensure       	= 'present' 
		  
	######### SERVICES ########
	$service_manage 		= true
	$default_service_name   = 'ntpd'
	$service_ensure         = 'running'            
	$service_enable         = true
	$service_hasstatus		= true
	$service_hasrestart 	= true

	###### CONFIG_FILES ###### 
	$default_file_name      = 'ntp.conf'
	$default_file_path      = '/etc/ntp.conf'     
	$file_ensure            = 'file'   
	$file_backup            = '.puppet-bak'   
	$file_content           = 'ntp/ntp.conf.erb' 
	$file_group             = '0' 
	$file_mode              = '0644' 
	$file_owner             = '0'   

	####### CONFIG_LOG ####### 
	#$log_manage 			= true
  	#$default_log_name		= 'ntp.log'
  	#$default_log_path		= '/var/log/ntp.log'
  	#$log_ensure				= 'file'
  	#$log_backup				= '.puppet-bak'
  	#$log_owner				=
  	#$log_group				=
  	#$log_mode				=

  	case $::osfamily {

	  		####### CONFIG_REDHAT_FAMILLY ####### 
	  		'RedHat': {
	     		$package_name   = $default_package_name
	      		$service_name   = $default_service_name
	  		 	$file_name 		= $default_file_name     
				$file_path   	= $default_file_path  

	  		 	case $::operatingsystem {

	        		'Fedora': {
	        			$servers  = [
				            '0.fedora.pool.ntp.org',
				            '1.fedora.pool.ntp.org',
				            '2.fedora.pool.ntp.org',
				            '3.fedora.pool.ntp.org',
	          			]
	        		}

	        		default : {
	        			$servers  = [
				            '0.centos.pool.ntp.org',
				            '1.centos.pool.ntp.org',
				            '2.centos.pool.ntp.org',
				            '3.centos.pool.ntp.org',
	          			]

	        		}


	        	}
	  		 }

	  		 ####### CONFIG_AIX_SYSTEM #######
	    	'AIX': {   
		      	$package_name   = [ 'bos.net.tcp.client', ]
		      	$service_name 	= 'xntpd'
		      	$file_name 		= $default_file_name     
				$file_path   	= $default_file_path  
	  		}

	  		##### CONFIG_DEBIAN_SYSTEM ######
	  		'Debian': {
	 			$package_name 	= $default_package_name
	 			$service_name 	= 'ntp'
	 			$file_name 		= $default_file_name     
				$file_path   	= $default_file_path  
	 			$servers        = [
	        		'0.debian.pool.ntp.org',
	        		'1.debian.pool.ntp.org',
	        		'2.debian.pool.ntp.org',
	        		'3.debian.pool.ntp.org',
	      		]
	  		}
	}

}
