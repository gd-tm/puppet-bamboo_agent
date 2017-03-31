
define bamboo_agent::servicefile::sysvinit(
  $service,
  $home,
  $id,
  $user
){
 file { "/etc/init.d/${service}":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('bamboo_agent/init-script.erb'),
  }
}

