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

  # The host list
  # hosts =
  #   Array['elephant', 'tiger', 'horse', 'monkey'].
  #     zip(Array['192.168.1.2', '192.168.1.3', '192.168.1.4', '192.168.1.5'])

  # Development Host list - single host
  hosts =
    Array['elephant'].zip(Array['192.168.1.2'])

  hosts.each do |host|
      config.vm.define host[0] do |node|
          
        node.vm.box_url = "http://files.vagrantup.com/precise64.box"
        node.vm.box = "hadoop2_precise64"
        node.vm.hostname = "#{host[0]}.lmc.dev"
        node.vm.network "private_network", ip: host[1], virtualbox__intnet: "hadoop_cluster_network"
        config.ssh.forward_agent = true
        config.ssh.forward_x11   = true
    
        # VirtualBox-specific
        node.vm.provider "virtualbox" do |vb|
            vb.gui = false
            vb.customize ["modifyvm", :id, "--memory", "512"]

            # # Add extra disks
            # [0, 1, 2, 3].each do |device|
            #     external_disk = "/tmp/hadoop-vm-disks/#{host[0]}_device#{device}.vdi"
            #     vb.customize ['createhd', '--filename', external_disk, '--size', 10 * 1024]
            #     vb.customize ['storageattach', :id, '--storagectl',
            #                   'SATA Controller', '--port', 1, '--device', 0,
            #                   '--type', 'hdd', '--medium', external_disk]
            # end # device

        end # vb
      
        # Puppet standalone
        node.vm.provision "puppet", run: "always" do |puppet|
          puppet.manifests_path = "Puppet/manifests/"
          puppet.manifest_file = "site.pp"
          puppet.module_path = "Puppet/modules/"
          puppet.facter = {
            "vagrant"  => "1",
            "hostname" => host[0],
            "ip_addr"  => host[1]
          }
          puppet.working_directory = "/tmp"
          puppet.options = "--verbose"
        end # puppet
    
      end # node
   end # name

end # Vagrant.configure
