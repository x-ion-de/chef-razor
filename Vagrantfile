require 'vagrant-berkshelf'
require 'vagrant-omnibus'

Vagrant.configure("2") do |config|
  config.omnibus.chef_version = :latest

  config.vm.box = "precise64"

  config.berkshelf.enabled = true

  config.vm.define :razor do |v|
    v.vm.hostname = 'razor'
    v.vm.network :private_network, ip: "33.33.33.10"
    v.vm.provision :chef_solo do |chef|
      chef.run_list = %w{ apt razor razor::client }
      chef.log_level = :auto
      chef.json = {
        postgresql: {
          password: 'postgres'
          }
        }
    end
  end
end
