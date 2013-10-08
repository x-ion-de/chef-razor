# Workaround COOK-1406 (postgresql w/ omnibus chef)
# https://tickets.opscode.com/browse/COOK-1406?focusedCommentId=28255&page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel#comment-28255
require 'open-uri'
bash 'workaround script for COOK-1406' do
  code open('https://gist.github.com/jtimberman/3954641/raw/375cdd8bd1e7d899702d9e34d411cda3f4fca99b/install.sh').read
  not_if '/opt/chef/embedded/bin/gem list pg | grep pg'
end

include_recipe 'postgresql::server'

user 'razor' do
  supports(
    managed_home: true
  )
end

pg_conn = {
  :host      => '127.0.0.1',
  :port      => 5432,
  :username  => 'postgres',
  :password  => node['postgresql']['password']['postgres']
}

postgresql_database_user 'razor' do
  connection pg_conn
  password   'razor'
  action     :create
end

#pg_conn[:username] = pg_conn[:password] = 'razor'

%w{
  razor_prd
  razor_dev
  razor_test
}.each do |db|
  postgresql_database db do
    connection pg_conn
    action :create
  end
end

package 'libarchive-dev'


# jruby, ruby, gems...

include_recipe 'java'
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby node[:razor][:jruby]

rbenv_gem "bundler" do
  ruby_version node[:razor][:jruby]
end

# node.default['rbenv']['gems'] = {
#   '1.9.3-p0' => [
#     { 'name'    => 'razor-client' },
#   ],
#   'jruby-1.6.5' => [
#     { 'name'    => 'bundler' }
#   ]
# }

#git clone https://github.com/puppetlabs/razor-server.git
git '~razor/razor-server' do
  repository 'https://github.com/puppetlabs/razor-server.git'
  reference 'master'
  action :sync
end

#TODO config.yml

# rbenv_script 'deploy razor-server' do
#   rbenv_version 'jruby-1.6.5'
#   cwd '~razor/razor-server'
#   action :nothing
#   code <<-EOF
# bundle install
# rake db:migrate
# torquebox deploy
# EOF
# end
