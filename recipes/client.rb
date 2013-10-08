include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby node[:razor][:client][:ruby]

rbenv_gem 'razor-client' do
  ruby_version node[:razor][:client][:ruby]
end

