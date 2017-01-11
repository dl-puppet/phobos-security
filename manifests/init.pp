class system 
(  

  ######### PACKAGES ########
  $package_manage               = $system::params::package_manage,
  $package_name                 = $system::params::package_name,
  $package_ensure               = $system::params::package_ensure,    
    
 
  ######### SERVICES ########
  $service_manage               = $system::params::service_manage,
  $service_name                 = $system::params::service_name, 
  $service_ensure               = $system::params::service_ensure,            
  $service_enable               = $system::params::service_enable,   
  $service_hasstatus            = $system::params::service_hasstatus,
  $service_hasrestart           = $system::params::service_hasrestart,


  ###### CONFIG_FILES ######   
  $file_ensure                  = $system::params::file_ensure,                  
  $file_group                   = $system::params::file_group,        
  $file_mode                    = $system::params::file_mode,        
  $file_owner                   = $system::params::file_owner, 
  $file_backup                  = $system::params::file_backup,       


  #####   NETWORK  ######
  # Config /etc/sysconfig/network :
  $network_networking           = $system::params::network_networking,
  #$HOSTNAME                    = $system::params::HOSTNAME,
  $network_nm                   = $system::params::network_nm,
  $network_nozeroconf           = $system::params::network_nozeroconf,
  $network_gateway              = $system::params::network_gateway,
  #GATEWAY                      = $system::params::GATEWAY,
  # /etc/sysconfig/network-scripts/ifcfg-eth0:
  $resolv_device                = $system::params::resolv_device,
  $resolv_type                  = $system::params::resolv_type,
  $resolv_hotplug               = $system::params::resolv_hotplug,
  $resolv_onboot                = $system::params::resolv_onboot,
  $resolv_controlled            = $system::params::resolv_controlled,
  #$HWADDR                      = <%= scope.lookupvar('::macaddress_eth0') %>,
  $resolv_bootproto             = $system::params::resolv_bootproto,
  $resolv_peerdns               = $system::params::resolv_peerdns,
  $resolv_ipv6init              = $system::params::resolv_ipv6init,
  # /etc/host.conf:
  $host_conf                    = $system::params::host_conf,
  # /etc/hosts:
  $list_host                    = $system::params::list_host,


  #####   MESSAGE ######
  #/etc/motd: 
  $dynamic                      = $system::params::dynamic,
  $file_dynamic                 = $system::params::file_dynamic,
  $file_no_dynamic              = $system::params::file_no_dynamic,
  #/etc/issue.net: 
  $issue                        = $system::params::issue,
  $file_issue                   = $system::params::file_issue,
  #files:    
  $file_ensure_message          = $system::params::file_ensure,
  $file_group_message           = $system::params::file_group,        
  $file_mode_message            = $system::params::file_mode,        
  $file_owner_message           = $system::params::file_owner,        
  $file_backup_message          = $system::params::file_backup, 

##### BOOT  ######
	$file_ensure_boot             = $system::params::file_ensure_boot,
	$file_group_boot              = $system::params::file_group_boot,
	$file_mode_boot               = $system::params::file_mode_boot,
	$file_owner_boot              = $system::params::file_owner_boot,
	$file_backup_boot             = $system::params::file_backup_boot,
	$package_ensure_boot          = $system::params::package_ensure_boot,
  $shutdown_name                = $system::params::shutdown_name,

) inherits system::params  

{
  ######### PACKAGES ########
  validate_bool           ($package_manage)
  validate_array          ($package_name)
  validate_string         ($package_ensure)

  ######### SERVICES ########
  validate_bool           ($service_manage)
  validate_array          ($service_name)
  validate_string         ($service_ensure)
  validate_bool           ($service_enable)
  validate_bool           ($service_hasstatus)
  validate_bool           ($service_hasrestart)
  
  ###### CONFIG_FILES ######
  validate_string         ($file_ensure)      
  validate_string         ($file_backup)     
         
  ###### MESSAGE ######
  validate_bool           ($dynamic)
  validate_string         ($file_dynamic)
  validate_string         ($file_no_dynamic)

  validate_bool           ($issue)
  validate_string         ($file_issue)

  validate_string         ($file_name) 
  validate_string         ($file_path)    
  validate_string         ($file_ensure)      
  validate_string         ($file_backup)     
  validate_string         ($file_content)   



  anchor { 'system::begin': } ->
	   class { '::system::network': } 
	   #class { '::system::boot': } 
	   #class { '::system::selinux': } 
	   #class { '::system::lvm': } 
	   #class { '::system::ntp': } 
	   #class { '::system::support': } 
	   #class { '::system::language': } 
	   #class { '::system::sudoers': } 
	   #class { '::system::user': } 
	   #class { '::system::ssh': } 
	   #class { '::system::yum': } 
	   class { '::system::message': } 
	   #class { '::system::snmp': } 
	   #class { '::system::service': } 
  anchor { 'system::end': }
		  
}

