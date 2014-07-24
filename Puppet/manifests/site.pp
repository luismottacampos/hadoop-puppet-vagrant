# node /^.+\.lmc\.dev$/ {
node 'elephant.lmc.dev' {
  include 'cdh::namenode'
}

node 'parrot.lmc.dev' {
  # A CDH APT Repository mirror
  include 'apt_mirror'
}
