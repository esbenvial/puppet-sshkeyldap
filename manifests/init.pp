# sshkeyldap class
class sshkeyldap (
  Boolean $gssapi      = $sshldap::params::gssapi,
  String $attribute    = $sshldap::params::attribute,
  String $objectclass  = $sshldap::params::objectclass,
  String $keytab       = $sshldap::params::keytab,
  Boolean $use_tls     = $sshldap::params::use_tls,
  String $base_dn      = $sshldap::params::base_dn,
  Integer $timeout     = $sshldap::params::timeout,
  String $host         = $sshldap::params::host,
  String $pubkey_attr  = $sshldap::params::pubkey_attr,
  String $scope        = $sshldap::params::scope,
  String $sshd_service = $sshldap::params::sshd_service,
  String $path         = $sshldap::params::path,
) inherits sshkeyldap::params {

  package { $lua_package:
    ensure => present,
  }
  package { $lua_ldap_package:
    ensure => present,
  }

  file { 'ssh-getkey-ldap':
    mode   => '0755',
    path   => "${path$}/ssh-getkey-ldap",
    source => "puppet:///modules/${module_name}/ssh-getkey-ldap",
    notify => Service[$sshd_service],
  }
  file { 'getkey-ldap.conf':
    mode    => '0644',
    path    => '/etc/ssh/getkey-ldap.conf',
    content => template("${module_name}/getkey-ldap.conf.erb"),
  }
}
