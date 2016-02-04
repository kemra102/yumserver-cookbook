include_recipe 'nginx_server::default'

nginx_server_vhost 'yumserver' do
  listen [{ 'ipaddress' => '0.0.0.0' }]
  server_name [node['hostname'], node['fqdn']]
  root node['yumserver']['basepath']
  config ({ # rubocop:disable Lint/ParenthesesAsGroupedExpression
    'location /' => {
      'autoindex' => 'on'
    }
  })
end
