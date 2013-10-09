require 'vagrant-berkshelf'
require 'vagrant-omnibus'

razor_nodes = 2

Vagrant.configure("2") do |config|
  config.omnibus.chef_version = :latest

  config.vm.box = "precise64"

  config.berkshelf.enabled = true

  config.vm.define :razor do |v|
    v.vm.hostname = 'razor'
    v.vm.network :private_network, ip: '33.33.33.10'
    v.vm.provision :chef_solo do |chef|
      chef.run_list = %w{ apt razor razor::client }
      chef.log_level = :auto
      chef.json = {
        razor: {
          dhcp: 'dnsmasq',
          mk: {
            url: 'file:///vagrant/microkernel-001.tar'
          }
        },
        postgresql: {
          password: 'postgres'
          }
        }
    end
  end

  razor_nodes.to_i.times do |i|
    config.vm.define :"node#{i+1}" do |vm_config|
      vm_config.vm.box      = "blank-amd64"
      vm_config.vm.box_url  = "https://s3.amazonaws.com/fnichol/vagrant-base-boxes/blank-amd64-20121109.box"
      # vm_config.vm.box = "precise64"
      # vm_config.vm.network :private_network, ip: '33.33.33.12'

      vm_config.vm.provider "virtualbox" do |virtualbox|
        virtualbox.gui = true unless ENV['NO_GUI']

        # generate a new mac address for each node, to make them unique
        virtualbox.customize ["modifyvm", :id, "--macaddress1", "auto"]

        # put primary network interface into hostonly network segement
        virtualbox.customize ["modifyvm", :id, "--nic1", "hostonly"]
        virtualbox.customize ["modifyvm", :id, "--hostonlyadapter1", "vboxnet10"]

        # pxe boot the node
        virtualbox.customize ["modifyvm", :id, "--boot1", "net"]

        # newer ipxe rom
        # virtualbox.customize ["setextradata", :id, 'VBoxInternal/Devices/pcbios/0/Config/LanBootRom', '/Users/srenatus/Work/cookbooks/razor/10222000.rom']
      end
    end
  end
end
