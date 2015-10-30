# installation du logiciel

class motd::install inherits motd
{

   File {
    ensure          => $motd::file_ensure,
    group           => $motd::file_group,
    mode            => $motd::file_mode,
    owner           => $motd::file_owner,
    backup          => $motd::file_backup,
    #notify          => Service['mcollective'],
    #require         => Package['mcollective']
  }

    ##### Configuration MOTD Dynamic ##########
    if $dynamic == true {

        file { $motd::file_dynamic :
          content => template('motd/motd.sh.erb'),
         }
    }
    else
    {
            file { $motd::file_no_dynamic :
                  content => template('motd/motd.erb'),
            }
    }

    ##### Configuration issue.net ##########
    ### Require:  Activate option 'Banner /etc/issue.net' in file /etc/ssh/sshd_config ###

     if $issue {

        file { $motd::file_issue :
          content => template('motd/issue.erb'),

         }
    }
}
