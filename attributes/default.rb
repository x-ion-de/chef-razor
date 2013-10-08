default[:razor][:server][:ruby] = 'jruby-1.7.4'
default[:razor][:client][:ruby] = '1.9.3-p448'

default[:razor][:install_from] = 'source'
default[:razor][:home] = '/opt/razor'
default[:razor][:repo] = 'git://github.com/puppetlabs/razor-server.git'
default[:razor][:ref] = 'master'

# deploy artifacts:
default[:razor][:torquebox][:url] = 'http://torquebox.org/release/org/torquebox/torquebox-dist/3.0.0/torquebox-dist-3.0.0-bin.zip'
default[:razor][:server][:url] = 'http://links.puppetlabs.com/razor-server-latest.zip'
