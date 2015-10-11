default['yumserver']['basepath'] = '/var/lib/yum-repo'
default['yumserver']['nginx']['config_cookbook'] = 'yumserver'
default['yumserver']['nginx']['servername'] = node['fqdn']

default['nginx']['repo_source'] = 'nginx'
default['nginx']['default_site_enabled'] = false
