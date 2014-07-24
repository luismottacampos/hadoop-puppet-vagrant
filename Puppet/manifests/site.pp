# node /^.+\.lmc\.dev$/ {
node 'elephant.lmc.dev' {
  class{ 'cdh::namenode':
    zookeeper_server_id => 1;
  }
}

node 'parrot.lmc.dev' {
  # A CDH APT Repository mirror
  include 'apt_mirror'
}
