# définition des paramètres par défaut 

class system::params
{
  
	######### PACKAGES ######## ruby-shadow
	$package_manage       	    = true
    $package_name               = ['ntp', 'net-snmp', 'sudo','openssh-server', 'mcollective', 'rubygem-stomp'] 
	$package_ensure       	    = 'installed' 
		  
		  
	######### SERVICES ########
	$service_manage 		    = true
	$service_name               = ['ntpd', 'snmpd', 'sshd','network', 'mcollective']   # lvm2-lvmetad start et service lvm2-monitor
	$service_ensure             = 'running'            
	$service_enable             = true
	$service_hasstatus		    = true
	$service_hasrestart 	    = true


	###### CONFIG_FILES ######     
	$file_ensure                = 'present'    
	$file_group                 = '0' 
	$file_mode                  = '0644' 
	$file_owner                 = '0'   
	$file_backup                = '.puppet-bak' 


	# /etc/sysconfig/network:
	$network_networking			= 'yes'
	#$HOSTNAME					= 'phobos'
	$network_nm					= 'no'
	$network_nozeroconf			= 'yes'
	$network_gateway			= 'eth0'
	#$GATEWAYDEV				='10.40.44.192'

	# /etc/resolv.conf:
	$resolv_device              =  'eth0'
	$resolv_type                =  'Ethernet'
	$resolv_hotplug             =  'yes'
	$resolv_onboot              =  'yes'
	$resolv_controlled          =  'no'
	#$HWADDR                    =  <%= scope.lookupvar('::macaddress_eth0') %>,
	$resolv_bootproto           =  'dhcp'
	$resolv_peerdns             =  'no'
	$resolv_ipv6init            =  'no'

	# /etc/host.conf:
	$host_conf                  =  "order hosts,bind"

  	# /etc/hosts:
  	$list_host                  =  ['']

}