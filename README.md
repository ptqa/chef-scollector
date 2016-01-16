scollector Cookbook
===================

This cookbook downloads and installs [scollector](https://github.com/bosun-monitor/bosun/tree/master/cmd/scollector) for [bosun](bosun.org).


Requirements
------------

- Chef Client 11.x or better

### Platforms

* Centos
* Ubuntu
* Debian


### Dependent Cookbooks

- [poise-service-runit](https://github.com/poise/poise-service)
- golang

Attributes
----------

* `node['scollector']['host']` - Sets bosun server host
* `node['scollector']['port']` - Sets bosun server port
* `node['scollector']['bin_path']` - Sets path to scollector executable
* `node['scollector']['conf_dir']` - Sets dir for scollector config dir
* `node['scollector']['collectors_dir']`  - Sets dir for external collectors (scollector runs all executables every `interval` sec in collectors_dir/`interval`/)
* `node['scollector']['config_cookbook']` - Cookbook where template scollector.conf.erb is stored
* `node['scollector']['tags']` - Tags to add to metrics, that scollector sends to bosun.
* `node['scollector']['init_style']` - explicitly set the init system used (`systemd`, `runit`, `sysvinit`, `upstart` or `inittab`). Systemd default for CentOS.


Recipes
-------

This section describes the recipes in the cookbook and how to use them in your environment.

### default

Includes the `golang::packages` and `scollector::configure` recipes by default.

### configure

Configures scollector.conf and:

* On CentOS 7+: installs systemd service for scollector and starts it
* Elsewhere: enables runit service for scollector and starts it


Usage
-----

You can include `scollector::default` in your company cookbook and redefine attributes there like
### companyname-scollector/attributes/default.rb:
* `default['scollector']['host'] = '192.168.169.21'`
* `default['scollector']['port'] = 8070`

Or you can redefine it in your role or environment.

NOTE: Make sure that you are using golang cookbook from github (see Berksfile).

Testing
-----

[Kitchen](http://kitchen.ci) tests via [busser-serverspec](https://github.com/test-kitchen/busser-serverspec):
* `kitchen test`

License & Authors
-----------------
- Author:: Tony Nyurkin (<ptqa.mail@gmail.com>)
- Author:: Alex Hewson (<alex@mbird.biz>)

```text

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
