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

include_recipe "razor::_#{node[:razor][:install_from]}"
include_recipe 'razor::_install_mk'
include_recipe 'razor::_repos'

if node[:razor][:dhcp]
  include_recipe "razor::#{node[:razor][:dhcp]}"
end

if node[:razor][:service][:provider]
  include_recipe "razor::#{node[:razor][:service][:provider]}"
end
