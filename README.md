# yumserver Cookbook
[![Build Status](https://travis-ci.org/kemra102/yumserver-cookbook.svg?branch=master)](https://travis-ci.org/kemra102/yumserver-cookbook)

#### Table of Contents

1. [Overview](#overview)
2. [Requirements](#requirements)
3. [Attributes](#attributes)
4. [Usage](#usage)
    * [yumserver_mirror](#yumserver_mirror)
5. [Contributing](#contributing)
6. [License & Authors](#license-and-authors)

## Overview

This cookbook allows you to mirror remote Yum repos and serve them up via NGINX.

## Requirements

Requires Chef 12.5 or later as this cookbook makes use of [Custom Resources](https://www.chef.io/blog/2015/10/08/chef-client-12-5-released/).

## Attributes

### yumserver::default
| Key                       | Type   | Description                       | Default          |
|:-------------------------:|:------:|:---------------------------------:|:----------------:|
| ['yumserver']['basepath'] | String | Where to store mirroed yum repos. | /var/lib/yum-rep |

### yumserver::_nginx
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['yumserver']['nginx']['config_cookbook']</tt></td>
    <td>String</td>
    <td>Which cookbook to use for the NGINX config template.</td>
    <td><tt>yumserver</tt></td>
  </tr>
  <tr>
    <td><tt>['yumserver']['nginx']['servername']</tt></td>
    <td>String</td>
    <td>Server name to use in NGINX config.</td>
    <td><tt>node['fqdn']</tt></td>
  </tr>
</table>

## Usage

You always need to include the main recipe:

```ruby
include_recipe 'yumserver::default'
```

This creates the `basepath` and installs the following packages:

* yum-utils
* createrepo

Additionally the recipe calls `yumserver::_nginx` which;

* Sets-up the upstream NGINX repo.
* Installs `nginx`.
* Configures `nginx` to serve up the `basepath`.
* Manages the `nginx` service.

### yumserver_mirror

Each Yum repo you wish to mirror can be defined using the `yumserver_mirror` custom resource.

Each `yumserver_mirror` has the following attributes:

<table>
  <tr>
    <th>Attribute</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>name</tt></td>
    <td>String || Symbol</td>
    <td>Resource name.</td>
    <td><tt>N/A</tt></td>
  </tr>
  <tr>
    <td><tt>local_path</tt></td>
    <td>String</td>
    <td>The basepath where the repo should be stored.</td>
    <td><tt>/var/lib/yum-repo</tt></td>
  </tr>
  <tr>
    <td><tt>repo_name</tt></td>
    <td>String</td>
    <td>Name of the Yum repo.</td>
    <td><tt>N/A</tt></td>
  </tr>
  <tr>
    <td><tt>repo_description</tt></td>
    <td>String</td>
    <td>Description of the Yum repo.</td>
    <td><tt>N/A</tt></td>
  </tr>
  <tr>
    <td><tt>repo_baseurl</tt></td>
    <td>String</td>
    <td>Base URL of the Yum repo.</td>
    <td><tt>N/A</tt></td>
  </tr>
</table>

To Mirror EPEL for EL7 for example:

```ruby
yumserver_mirror 'epel7' do
  repo_name 'nginx'
  repo_description 'The NGINX web server & reverse proxy'
  repo_baseurl 'http://nginx.org/packages/centos/7/x86_64/'
  action :create
end
```

## Contributing

If you would like to contribute to this cookbook please follow these steps;

1. Fork the repository on Github.
2. Create a named feature branch (like `add_component_x`).
3. Write your change.
4. Write tests for your change (if applicable).
5. Run the tests, ensuring they all pass.
6. Submit a Pull Request using Github.

## License and Authors

License: [BSD 2-clause](https://tldrlegal.com/license/bsd-2-clause-license-\(freebsd\))

Authors:

  * [Danny Roberts](https://github.com/kemra102)
  * [All Contributors](https://github.com/kemra102/yumserver-cookbook/graphs/contributors)
