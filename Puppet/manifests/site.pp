# node /^.+\.lmc\.dev$/ {
node 'elephant.lmc.dev' {
  class{ 'cdh::namenode':
    zookeeper_server_id => 1;
  }
}

node 'tiger.lmc.dev' {
  include 'cdh::datanode'
}

node 'horse.lmc.dev' {
  include 'cdh::datanode'
}

node 'monkey.lmc.dev' {
  include 'cdh::datanode'
}
