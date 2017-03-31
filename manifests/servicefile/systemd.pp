
define bamboo_agent::servicefile::systemd(
  $service,
  $home,
  $id,
  $user
){
 file { "/etc/systemd/system/multi-user.target.wants/${service}.service":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('bamboo_agent/systemd-unit.erb'),
  }
}

