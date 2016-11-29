#
define svncredentials (
  String $home_path       = undef,
  String $owner           = undef,
  String $svn_realmstring = undef,
  String $svn_username    = undef,
  String $svn_password    = undef,
) {

  $namehash = md5($svn_realmstring)

  file { [
    "${home_path}/.subversion",
    "${home_path}/.subversion/auth",
    "${home_path}/.subversion/auth/svn.simple",
  ]:
    ensure => 'directory',
    owner  => $owner,
    group  => $owner,
    mode   => '0700',
  } ->
  file { "${home_path}/.subversion/auth/svn.simple/${namehash}":
    owner   => $owner,
    group   => $owner,
    mode    => '0600',
    content => template('svncredentials/simple.erb'),
  }

}
