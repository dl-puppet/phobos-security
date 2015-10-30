# Gestion des services/daemon du logiciel

class ntp::service inherits ntp
{
 
    if ! ($ntp::service_ensure in [ 'running', 'stopped' ]) {
        fail('La variable service_ensure doit être positionné sur running ou stopped')
    }

    if $ntp::service_manage == true {

        service { $ntp::service_name :
            name        => $ntp::service_name,
            ensure      => $ntp::service_ensure,
            enable      => $ntp::service_enable,
            hasstatus   => $ntp::service_hasstatus,
            hasrestart  => $ntp::service_hasrestart,
        }

    }

}