include_recipe 'java'
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby node[:razor][:server][:ruby]

rbenv_gem 'bundler' do
  ruby_version node[:razor][:server][:ruby]
end

git node[:razor][:home] do
  repository node[:razor][:repo]
  reference node[:razor][:ref]
  action :sync
end

[
  node[:razor][:home],
  node[:razor][:repo_store_root]
].each do |dir|
  directory dir do
    recursive true
  end
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
    action :nothing
    subscribes :run, "git[#{node[:razor][:home]}]", :immediately
  end
end
