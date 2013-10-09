node.normal[:dnsmasq][:dhcp] = {
  'dhcp-match' => 'IPXEBOOT,175,19', # supports HTTP
  'dhcp-boot' => ['net:IPXEBOOT,bootstrap.ipxe', 'undionly.kpxe'],
  'enable-tftp' => nil,
  'tftp-root' => '/var/lib/tftpboot'
}
node.normal[:dnsmasq][:enable_dhcp] = true

include_recipe 'dnsmasq::dhcp'

directory '/var/lib/tftpboot'

remote_file '/var/lib/tftpboot/undionly.kpxe' do
  source 'http://boot.ipxe.org/undionly.kpxe'
  action :create_if_missing
end

remote_file '/var/lib/tftpboot/bootstrap.ipxe' do
  source "http://#{node[:razor][:host]}:8080/api/microkernel/bootstrap?nic_max=10"
  action :create_if_missing
end
