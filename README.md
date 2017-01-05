# yumserver Cookbook
[![Build Status](https://travis-ci.org/kemra102/yumserver-cookbook.svg?branch=master)](https://travis-ci.org/kemra102/yumserver-cookbook)

#### Table of Contents

1. [Overview](#overview)
2. [Requirements](#requirements)
3. [Attributes](#attributes)
4. [Usage](#usage)
    * [yumserver_mirror](#yumserver_mirror)
    * [yumserver_rsync_mirror](#yumserver_rsync_mirror)
5. [Contributing](#contributing)
6. [License & Authors](#license-and-authors)

## Overview

This cookbook allows you to mirror remote Yum repos and serve them up via NGINX.

## Requirements

Requires Chef 12.5 or later as this cookbook makes use of [Custom Resources](https://www.chef.io/blog/2015/10/08/chef-client-12-5-released/).

## Attributes

### yumserver::default
| Key                       | Type    | Description                                | Default          |
|:-------------------------:|:-------:|:------------------------------------------:|:----------------:|
| ['yumserver']['basepath'] | String  | Where to store mirroed yum repos.          | /var/lib/yum-rep |

## Usage

You always need to include the main recipe:

```ruby
include_recipe 'yumserver::default'
```

This creates the `basepath` and installs the following packages:

* yum-utils
* createrepo
* rsync

Additionally the recipe calls `yumserver::_nginx` which;

* Sets-up the upstream NGINX repo.
* Installs `nginx`.
* Configures `nginx` to serve up the `basepath`.
* Manages the `nginx` service.

### yumserver_mirror

Each Yum repo you wish to mirror can be defined using the `yumserver_mirror` custom resource.

Each `yumserver_mirror` has the following attributes:

| Attribute        | Type             | Description                                              | Default           |
|:----------------:|:----------------:|:--------------------------------------------------------:|:-----------------:|
| name             | String or Symbol | Resource name.                                           | N/A               |
| local_path       | String           | The basepath where the repo should be stored.            | /var/lib/yum-repo |
| repo_name        | String           | Name of the Yum repo.                                    | N/A               |
| repo_description | String           | Description of the Yum repo.                             | N/A               |
| repo_baseurl     | String           | Base URL of the Yum repo.                                | N/A               |
| options          | String           | Additional options to pass to `reposync`.                | N/A               |
| timeout          | Integer          | Timeout for the `reposync` command.                      | 600               |
| use_repo         | Boolean          | If the repo should be availble for the yumserver to use. | true              |
| repo_workers     | Integer          | Number of createrepo workers to start up.                | server cpu count  |

To Mirror EPEL for EL7 for example:

```ruby
yumserver_mirror 'epel7' do
  repo_name 'epel'
  repo_description 'Extra Packages for Enterprise Linux 7'
  repo_baseurl 'https://dl.fedoraproject.org/pub/epel/7/x86_64/'
  action :create
end
```

### yumserver_rsync_mirror

Each Yum repo you wish to mirror that provides an rsync endpoint can be defined using the `yumserver_rsync_mirror` custom resource.

Each `yumserver_rsync_mirror` has the following attributes:

| Attribute        | Type             | Description                                              | Default                                                    |
|:----------------:|:----------------:|:--------------------------------------------------------:|:----------------------------------------------------------:|
| name             | String or Symbol | Resource name.                                           | N/A                                                        |
| local_path       | String           | The basepath where the repo should be stored.            | /var/lib/yum-repo                                          |
| repo_name        | String           | Name of the Yum repo.                                    | N/A                                                        |
| repo_description | String           | Description of the Yum repo.                             | N/A                                                        |
| repo_url         | String           | URL of the Yum repo.                                     | N/A                                                        |
| timeout          | Integer          | Timeout for the `rsync` command.                         | 600                                                        |
| rsync_options    | String           | Options to pass to rsync.                                | -aHS --numeric-ids --delete --delete-delay --delay-updates |
| use_repo         | Boolean          | If the repo should be availble for the yumserver to use. | true                                                       |

To Mirror EPEL for EL7 for example:

```ruby
yumserver_rsync_mirror 'epel7' do
  repo_name 'epel'
  repo_description 'Extra Packages for Enterprise Linux 7'
  repo_url 'rsync://dl.fedoraproject.org/pub/epel/7/x86_64/'
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
