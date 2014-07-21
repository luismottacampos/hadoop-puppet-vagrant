# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant Plugin to manage VB Guess Additions - works as middleware, runs
# automagically, does the right thing for Debian and Ubuntu Boxes. Does
# not work on windows.
# Blog: http://kvz.io/blog/2013/01/16/vagrant-tip-keep-virtualbox-guest-additions-in-sync/
# Source: https://github.com/dotless-de/vagrant-vbguest 
# # vagrant plugin install vagrant-vbguest

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Nodes
  config.vm.define "node001" do |node|
      
    # Every Vagrant virtual environment requires a box to build off of.
    node.vm.box_url = "http://files.vagrantup.com/precise64.box"
    node.vm.box = "hadoop2_precise64"
    node.vm.hostname = "dn001"
  
    # Disable automatic box update checking. If you disable this, then
    # boxes will only be checked for updates when the user runs
    # `vagrant box outdated`. This is not recommended.
    # node.vm.box_check_update = false
  
    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # node.vm.network "forwarded_port", guest: 80, host: 8080
  
    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    # node.vm.network "private_network", ip: "192.168.33.10"
    node.vm.network "private_network", ip: "192.168.1.2"
  
    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
    node.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
  
    # If true, then any SSH connections made will enable agent forwarding.
    # Default value: false
    config.ssh.forward_agent = true
    config.ssh.forward_x11   = true
  
    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # node.vm.synced_folder "../data", "/vagrant_data"
    node.vm.synced_folder "Puppet", "/opt/puppet"
  
    # A range of ports Vagrant can use for handling port collisions and such.
    # Defaults to 2200..2250.
    node.vm.usable_port_range = 2200..2250
  
    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    # Example for VirtualBox:
    #
    # node.vm.provider "virtualbox" do |vb|
    #   # Don't boot with headless mode
    #   vb.gui = true
    #
    #   # Use VBoxManage to customize the VM. For example to change memory:
    #   vb.customize ["modifyvm", :id, "--memory", "1024"]
    # end
    #
    # View the documentation for the provider you're using for more
    # information on available options.
  
    node.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.customize ["modifyvm", :id, "--memory", "512"]
    end
  
    # Puppet standalone
    node.vm.provision "puppet", run: "always" do |puppet|
      puppet.manifests_path = "Puppet"
      puppet.module_path = "Modules"
      puppet.facter = {
        "vagrant" => "1"
      }
      # puppet.hiera_config_path = "~/src/ecg-puppet/hiera/default.yaml"
      puppet.working_directory = "/tmp"
      puppet.options = "--verbose --debug"
    end # puppet

  end # node

end # Vagrant.configure
