template "#{node[:razor][:home]}/config.yaml" do
  source 'config.yaml.erb'
  variables(
    db_host: node[:razor][:database][:host],
    db_port: node[:razor][:database][:port],
    repo_store_root: node[:razor][:repo_store_root]
  )
end
