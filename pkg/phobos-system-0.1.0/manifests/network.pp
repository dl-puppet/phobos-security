class system::network
(
  # Config /etc/sysconfig/network :
  $network_networking           = $system::network_networking,
  #$HOSTNAME                    = $system::HOSTNAME,
  $network_nm                   = $system::network_nm,
  $network_nozeroconf           = $system::network_nozeroconf,
  $network_gateway              = $system::network_gateway,
  #GATEWAY                      = $system::GATEWAY,


  # /etc/sysconfig/network-scripts/ifcfg-eth0:
  $resolv_device                = $system::resolv_device,
  $resolv_type                  = $system::resolv_type,
  $resolv_hotplug               = $system::resolv_hotplug,
  $resolv_onboot                = $system::resolv_onboot,
  $resolv_controlled            = $system::resolv_controlled,
  #$HWADDR                      = <%= scope.lookupvar('::macaddress_eth0') %>,
  $resolv_bootproto             = $system::resolv_bootproto,
  $resolv_peerdns               = $system::resolv_peerdns,
  $resolv_ipv6init              = $system::resolv_ipv6init,


  # /etc/host.conf:
  $host_conf                    = $system::host_conf,


  # /etc/hosts:
  $list_host                    = $system::list_host,
)
{

            File {
              ensure          => $system::file_ensure,
              group           => $system::file_group,
              mode            => $system::file_mode,
              owner           => $system::file_owner,
              backup          => $system::file_backup,
            }
               
                file {
                  
                    # /etc/services: 
                    # http://www.iana.org/assignments/port-numbers
                    # port (entre 0 et 1023) sont réservés pour les applications « standards 
                    # port pour les applications développées par les utilisateurs (1024 à 65535).
                    "/etc/services" :
                    content => template("system/services.erb");

                    # /etc/sysctl.conf: 
                    #  Paramètres par défaut du système #vivent dans /usr/lib/sysctl.d/00-system.conf.
                    "/etc/sysctl.conf" :
                    content => template("system/sysctl.erb");
                    
                    # /etc/sysconfig/network (/etc/hostname):
                    "/etc/sysconfig/network" :
                    content => template("system/network.erb");
             
                     # /etc/networks :
                     # Permet d'affecter un nom logique à un réseau (definition des domains)
                     # permet par exemple d'adresser un réseau (route) sur son nom, plutôt que sur son adresse.
                    "/etc/networks" :
                    content => template("system/networks.erb");
                    
                     # /etc/host.conf:
                     # Donne l'ordre dans lequel le processus de résolution de noms est effectué.
                    "/etc/host.conf" :
                    content => template("system/host.conf.erb");
                    
                    # /etc/hosts: 
                    # Moyen d'assurer la résolution de noms, de donner un nom FQDN à un hôte
                    "/etc/hosts" :
                    content => template("system/hosts.erb");
                     
                    # /etc/resolv.conf:
                    # Permet d'affecter les serveurs de noms. 
                    # ATTENTION !!! Il peut etre configurer via DHCP
                    "/etc/resolv.conf" :
                    content => template("system/resolv.erb"),
                    replace => "no";

                    # Configuration des interfaces reseaux:
                    # Configuration /etc/sysconfig/network-scripts/ifcfg-eth0:
                #"/etc/sysconfig/network-scripts/ifcfg-eth0" :
                #content => template("system/ifcfg-eth0.erb"),
                #replace => "no";
                    #notify  => Service['$system::service_name'];
                        # Configuration de la route eth0:
                        #"/etc/sysconfig/network-scripts/route-eth0" :
                        #content => template("system/route-eth0.erb");
                         
                    # Configuration /etc/sysconfig/network-scripts/ifcfg-eth1:
                    #/etc/sysconfig/network-scripts/ifcfg-eth1" :
                    #content => template("system/ifcfg-eth1.erb");
                        
                    #"/etc/sysconfig/network-scripts/ifcfg-eth2" :
                    #replace => "no",
                    #content => template("system/ifcfg-eth2.erb");
                }

}