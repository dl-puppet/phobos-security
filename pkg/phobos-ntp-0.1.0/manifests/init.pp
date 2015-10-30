#Classe principale

class ntp 
(  

  ######### PACKAGES ########
  $package_manage         = $ntp::params::package_manage,
  $package_name           = $ntp::params::package_name,
  $package_ensure         = $ntp::params::package_ensure,  
  
  ######### SERVICES ########
  $service_manage         = $ntp::params::service_manage,
  $service_name           = $ntp::params::service_name, 
  $service_ensure         = $ntp::params::service_ensure,            
  $service_enable         = $ntp::params::service_enable,   
  $service_hasstatus      = $ntp::params::service_hasstatus,
  $service_hasrestart     = $ntp::params::service_hasrestart,

  ###### CONFIG_FILES ###### 
  $file_name              = $ntp::params::file_name,    
  $file_path              = $ntp::params::file_path,     
  $file_ensure            = $ntp::params::file_ensure,      
  $file_backup            = $ntp::params::file_backup,      
  $file_content           = $ntp::params::file_content,          
  $file_group             = $ntp::params::file_group,        
  $file_mode              = $ntp::params::file_mode,        
  $file_owner             = $ntp::params::file_owner,       

  ####### CONFIG_LOG #######  
  #$log_manage             = $ntp::params::log_manage, 
  #$log_name               = $ntp::params::log_name,
  #$log_path               = $ntp::params::log_path,
  #$log_ensure             = $ntp::params::log_ensure,
  #$log_backup             = $ntp::params::log_backup,
  #$log_owner              = $ntp::params::log_owner,
  #$log_group              = $ntp::params::log_group,
  #$log_mode               = $ntp::params::log_mode,

  $servers                = $ntp::params::servers,

) inherits ntp::params  

{
  validate_string         ($package_ensure)
  validate_bool           ($package_manage)
  validate_array          ($package_name)

  validate_bool           ($service_manage)
  validate_string         ($service_name)
  validate_string         ($service_ensure)
  validate_bool           ($service_enable)
  validate_bool           ($service_hasstatus)
  validate_bool           ($service_hasrestart)

  validate_string         ($file_name) 
  validate_string         ($file_path)    
  validate_string         ($file_ensure)      
  validate_string         ($file_backup)     
  validate_string         ($file_content)          

  #validate_bool           ($log_manage)
  #validate_string         ($log_name)
  #validate_string         ($log_path)
  #validate_string         ($log_ensure)
  #alidate_string          ($log_backup)

  validate_array          ($servers)


  anchor { 'ntp::begin': } ->
    class { '::ntp::install': } ->
    class { '::ntp::config': } ~>
    class { '::ntp::service': } ->
  anchor { 'ntp::end': }
  
		  
}

