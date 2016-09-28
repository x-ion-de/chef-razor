include_recipe 'java'
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby node[:razor][:server][:ruby]

rbenv_gem 'bundler' do
  ruby_version node[:razor][:server][:ruby]
  version '1.12.0'
end

git node[:razor][:home] do
  repository node[:razor][:repo]
  reference node[:razor][:ref]
  action :sync
end

directory node[:razor][:repo_store_root] do
  action :nothing
  recursive true
  subscribes :create, "git[#{node[:razor][:home]}]", :immediately
end

include_recipe 'razor::_config'

[
  'bundle install',
  'rake db:migrate',
  'torquebox deploy'
].each do |cmd|
  rbenv_execute cmd do
    cwd node[:razor][:home]
    ruby_version node[:razor][:server][:ruby]
    #action :run
  end
end
