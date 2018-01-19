# sshkeyldap class
class sshkeyldap (
  Boolean $gssapi      = false,
  String $attribute    = 'uid',
  String $objectclass  = 'posixAccount',
  String $keytab       = '/etc/krb5.keytab',
  Boolean $use_tls     = true,
  String $base_dn      = undef,
  Integer $timeout     = 5,
  String $host         = undef,
  String $pubkey_attr  = 'sshPublicKey',
  String $scope        = 'subtree',
  String $path         = '/usr/local/bin',
) {

  case $::osfamily {
    'SuSE': {
      $sshd_service     = 'sshd'
      $lua_package      = 'lua51'
      $lua_ldap_package = undef
    }
    'Debian': {
      $sshd_service     = 'ssh'
      $lua_package      = 'lua5.1'
      $lua_ldap_package = 'lua-ldap'
    }
    'RedHat': {
      $sshd_service     = 'sshd'
      $lua_package      = 'lua'
      $lua_ldap_package = 'lua-ldap'
    }
    default: {}
  }

  package { $lua_package:
    ensure => present,
  }
  package { $lua_ldap_package:
    ensure => present,
  }

  file { 'ssh-getkey-ldap':
    mode   => '0755',
    path   => "${path}/ssh-getkey-ldap",
    source => "puppet:///modules/${module_name}/ssh-getkey-ldap",
    notify => Service[$sshd_service],
  }
  file { 'getkey-ldap.conf':
    mode    => '0644',
    path    => '/etc/ssh/getkey-ldap.conf',
    content => template("${module_name}/getkey-ldap.conf.erb"),
  }
}
