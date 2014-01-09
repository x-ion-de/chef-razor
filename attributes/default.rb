default[:razor][:server][:ruby] = 'jruby-1.7.8'
default[:razor][:client][:ruby] = '1.9.3-p448'

default[:razor][:host] = node[:ipaddress]

default[:razor][:home] = '/opt/razor'
default[:razor][:repo_store_root] = "#{node[:razor][:home]}/repo_store"

default[:razor][:mk][:url] = 'http://hypnotoad/microkernel-001.tar'
default[:razor][:ipxe][:url] = 'http://boot.ipxe.org/undionly.kpxe'

default[:razor][:install_from] = 'source'
default[:razor][:repo] = 'git://github.com/puppetlabs/razor-server.git'
default[:razor][:ref] = 'master'

# deploy artifacts:
default[:razor][:torquebox][:url] = 'http://torquebox.org/release/org/torquebox/torquebox-dist/3.0.0/torquebox-dist-3.0.0-bin.zip'
default[:razor][:server][:url] = 'http://links.puppetlabs.com/razor-server-latest.zip'

default[:razor][:dhcp] = nil

default[:razor][:service][:provider] = nil

default[:razor][:repos] = {}
# "ubuntu" => "file:///vagrant/ubuntu.iso"
