template "#{node[:razor][:home]}/config.yaml" do
  source 'config.yaml.erb'
  variables(
    repo_service_uri: 'http://razor.example.com/razor/repo'
  )
end
