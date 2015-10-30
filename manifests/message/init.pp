
class motd
(

	###### CONFIG_MOTD ######  
  	$dynamic                      = $motd::params::dynamic,
  	$file_dynamic                 = $motd::params::file_dynamic,
	$file_no_dynamic              = $motd::params::file_no_dynamic,

	###### CONFIG_ISSUE ######   
	$issue                        = $motd::params::issue,
	$file_issue                   = $motd::params::file_issue,

	###### CONFIG_FILES ######    
	$file_ensure                  = $motd::params::file_ensure,
	$file_group                   = $motd::params::file_group,        
	$file_mode                    = $motd::params::file_mode,        
	$file_owner                   = $motd::params::file_owner,        
	$file_backup                  = $motd::params::file_backup, 

) inherits motd::params

{

  validate_bool           ($dynamic)
  validate_string         ($file_dynamic)
  validate_string         ($file_no_dynamic)

  validate_bool		      ($issue)
  validate_string         ($file_issue)

  validate_string         ($file_name) 
  validate_string         ($file_path)    
  validate_string         ($file_ensure)      
  validate_string         ($file_backup)     
  validate_string         ($file_content)   


  anchor { 'motd::begin': } ->
    class { '::motd::install': } 
  anchor { 'motd::end': }

}


