# `razor create-repo` doesn't do error handling:
# name already in use: 400, exit code 0
# iso-url not there: 200, exit code 0, broken entry in repos
node[:razor][:repos].each do |name, url|
  rbenv_execute "include repo #{name}" do
    ruby_version node[:razor][:client][:ruby]
    command "razor create-repo --name #{name} --iso-url #{url}"
  end
end
