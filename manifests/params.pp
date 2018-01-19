class sshkeyldap::params {

  $gssapi      = false
  $attribute   = 'uid'
  $objectclass = 'posixAccount'
  $keytab      = '/etc/krb5.keytab'
  $use_tls     = true
  $base_dn     = undef
  $timeout     = 5
  $host        = undef
  $pubkey_attr = 'sshPublicKey'
  $scope       = 'subtree'
  $path        = '/usr/local/bin'

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
  }
}
