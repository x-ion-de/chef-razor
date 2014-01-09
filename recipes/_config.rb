template "#{node[:razor][:home]}/config.yaml" do
  source 'config.yaml.erb'
  variables(
    db_host: node[:razor][:database][:host],
    repo_service_uri: "http://#{node[:fqdn]}/razor/repo",
    repo_store_root: node[:razor][:repo_store_root]
  )
end
