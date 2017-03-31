# Declares the agent a Puppet service and ensures it is running and enabled,
# after rendering an init script that delegates to the agent's bamboo-agent.sh
# script.
# *** This type should be considered private to this module ***


define bamboo_agent::service(
  $home,
  $user,
  $id = $title,
){

  $service = "bamboo-agent${id}"
  $script  = "${home}/bin/bamboo-agent.sh"
  $agent_id = $id

  if $::osfamily == 'Debian' and
    $::lsbmajdistrelease >= 8 {
      $initsystem = 'sysvinit'
    }
  elsif $::facts['kernel'] == 'Linux' {
    $initsystem = 'sysvinit'
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
  ->
  service { $service:
    ensure => running,
    enable => true,
  }
}
