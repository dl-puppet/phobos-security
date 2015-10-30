# Gestion des services/daemon du logiciel

class system::service inherits system
{

    if $system::service_manage == true {

        Service { 
            ensure      => $system::service_ensure,
            enable      => $system::service_enable,
            hasstatus   => $system::service_hasstatus,
            hasrestart  => $system::service_hasrestart,
            #require    => File['/../.....conf']
        }


			  service { $system::service_name : }

    }
    
}