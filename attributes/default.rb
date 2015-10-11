default['yumserver']['basepath'] = '/var/lib/yum-repo'
default['yumserver']['nginx']['config_cookbook'] = 'yumserver'
default['yumserver']['nginx']['servername'] = node['fqdn']
