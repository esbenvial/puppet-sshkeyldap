# sshkeyldap class
class sshkeyldap (
  String $path = '/usr/local/bin'
) {
  case $::osfamily {
    'SuSE': {
      $ldap_conf = '/etc/openldap/ldap.conf'
    }
    'Debian': {
      $ldap_conf = '/etc/ldap/ldap.conf'
    }
    'RedHat': {
      $ldap_conf = '/etc/openldap/ldap.conf'
    }
    default: {}
  }

  file { 'ssh-getkey-ldap':
    mode    => '0755',
    path    => "${path}/ssh-getkey-ldap",
    content => epp("${module_name}/ssh-getkey-ldap.epp", { 'ldap_conf' => $ldap_conf }),
  }
}
