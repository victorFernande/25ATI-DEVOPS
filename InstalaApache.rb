package 'apache2' do
    action :install
end

service 'apache2' do
    action [:enable,:start]
    supports :reload => true
end