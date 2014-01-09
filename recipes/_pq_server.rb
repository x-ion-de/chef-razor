include_recipe 'postgresql::server'
node.override[:razor][:database][:host] = '127.0.0.1'
node.override[:razor][:database][:port] = 5432
node.override[:razor][:database][:username] = 'postgres'
node.override[:razor][:database][:password] = node['postgresql']['password']['postgres']
