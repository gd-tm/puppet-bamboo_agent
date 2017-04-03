
# create something for an init system, defaults to systemd

define bamboo_agent::service(
  $home,
  $user,
  $id = $title,
){

  $service = "bamboo-agent${id}"
  $script  = "${home}/bin/bamboo-agent.sh"
  $agent_id = $id

  if $::osfamily == 'Debian' and
    $::lsbmajdistrelease < 8 {
      $initsystem = 'sysvinit'
    }
  elsif $::kernel == 'Linux' {
    $initsystem = 'systemd'
  }
  else {
    fail('Unsupported non-Linux platform')
  }

  bamboo_agent::servicefile { "bamboo-agent-${title}":
    initsystem => $initsystem,
    service    => $service,
    home       => $home,
    id         => $id,
    user       => $user
  }
#  ->
#  service { $service:
#    ensure => running,
#    enable => true,
#  }
}
