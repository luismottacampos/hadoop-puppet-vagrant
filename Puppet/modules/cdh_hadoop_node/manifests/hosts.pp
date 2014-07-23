# Class cdh_hadoop_node::hosts - configure /etc/hosts entries for your cluster
class cdh_hadoop_node::hosts {

  host {'elephant':
    ensure       => present,
    host_aliases => 'elephant.lmc.dev',
    ip           => '192.168.1.2'
  }

  host {'tiger':
    ensure       => present,
    host_aliases => 'tiger.lmc.dev',
    ip           => '192.168.1.3'
  }

  host {'horse':
    ensure       => present,
    host_aliases => 'horse.lmc.dev',
    ip           => '192.168.1.4'
  }

  host {'monkey':
    ensure       => present,
    host_aliases => 'monkey.lmc.dev',
    ip           => '192.168.1.5'
  }

}
