include_recipe 'runit'

runit_service 'razor-server' do
  default_logger true
  options(
    rbenv_version: node[:razor][:server][:ruby]
  )
end

