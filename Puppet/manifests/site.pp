# node /^.+\.lmc\.dev$/ {
node 'elephant.lmc.dev' {
  include 'cdh_hadoop_node'
  include 'cdh::namenode'
}
