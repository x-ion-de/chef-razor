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

execute 'fix Gemfile for archive gem bugfix' do
  command "sed -i s#^gem 'archive'$#gem 'archive', git: 'git://github.com/erikh/archive.git', branch: 'd1f7e72e18aefb591af2d638e1ccd7de51d2f308'# #{node[:razor][:home]}/Gemfile"
  action :nothing
  subscribes :run, "git[#{node[:razor][:home]}]", :immediately
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
