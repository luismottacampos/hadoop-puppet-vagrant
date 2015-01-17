# Elephant roles:
## Cluster Node
## Data Node
## Name Node
## Zookeeper #1
node 'elephant.lmc.dev' {
  class {
    'cdh::namenode':;
    'cdh::datanode':;
    'cdh::zookeeper':
      server_id => 1;
  }
}

# Tiger roles:
## Cluster Node
## Data Node
## Zookeeper #2
node 'tiger.lmc.dev' {
  class {
    'cdh::datanode':;
    'cdh::zookeeper':
      server_id => 2;
  }
}

# Horse roles:
## Cluster Node
## Data Node
## Zookeeper #3
node 'horse.lmc.dev' {
  class {
    'cdh::datanode':;
    'cdh::zookeeper':
      server_id => 3;
  }
}

# Monkey roles:
## Cluster Node
## Data Node
node 'monkey.lmc.dev' {
  include 'cdh::datanode'
}
