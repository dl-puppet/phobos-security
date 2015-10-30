# installation du logiciel

class ntp::install inherits ntp
{
	if $ntp::package_manage == true { 

	    package { $ntp::package_name :      
			ensure 	=> $ntp::package_ensure,       
		}

    } 

}