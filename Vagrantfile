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
  config.vm.define "elephant" do |node|
      
    node.vm.box_url = "http://files.vagrantup.com/precise64.box"
    node.vm.box = "hadoop2_precise64"
    node.vm.hostname = "elephant.lmc.dev"
    node.vm.network "private_network", ip: "192.168.1.2"
    node.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
    config.ssh.forward_agent = true
    config.ssh.forward_x11   = true
    # node.vm.usable_port_range = 2200..2250

    # VirtualBox-specific
    node.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.customize ["modifyvm", :id, "--memory", "512"]
    end
  
    # Puppet standalone
    node.vm.provision "puppet", run: "always" do |puppet|
      puppet.manifests_path = "Puppet/manifests/"
      puppet.manifest_file = "site.pp"
      puppet.module_path = "Puppet/modules/"
      puppet.facter = {
        "vagrant" => "1"
      }
      puppet.working_directory = "/tmp"
      puppet.options = "--verbose --debug"
    end # puppet

  end # node

end # Vagrant.configure
