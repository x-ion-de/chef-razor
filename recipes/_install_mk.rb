execute 'fetch microkernel image' do
  command "curl -L #{node[:razor][:mk][:url]} | tar xvf -"
  cwd node[:razor][:repo_store_root]
  not_if { ::File.exists? "#{node[:razor][:repo_store_root]}/microkernel" }
end
