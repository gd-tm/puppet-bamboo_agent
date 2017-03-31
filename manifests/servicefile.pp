define bamboo_agent::servicefile(
  $initsystem,
  $service,
  $home,
  $id,
  $user
){


# instantiate the one service file and ensure the other one is absent:

if $initsystem == 'sysvinit' {
  bamboo_agent::servicefile::sysvinit{ $service:
    service => $service,
    home => $home,
    id => $id,
    user => $user
  }
  file {  "/etc/systemd/system/multi-user.target.wants/${service}.service":
    ensure => absent
  }
  exec{ 'systemctl daemon-reload':
    path => ['/bin', '/sbin', '/usr/sbin', '/usr/bin'],
    onlyif => "test -x /bin/systemctl"
  }
} else {
  bamboo_agent::servicefile::systemd{ $service:
    service => $service,
    home => $home,
    id => $id,
    user => $user
  } ->
  file { "/etc/init.d/${service}":
    ensure => absent
  } ->
  exec{ 'systemctl daemon-reload':
    path => ['/bin', '/sbin', '/usr/sbin', '/usr/bin']
  }
}

}

