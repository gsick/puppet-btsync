[![Build Status](https://travis-ci.org/gsick/puppet-btsync.svg?branch=0.0.5)](https://travis-ci.org/gsick/puppet-btsync)
[![Coverage Status](https://coveralls.io/repos/gsick/puppet-btsync/badge.png?branch=0.0.5)](https://coveralls.io/r/gsick/puppet-btsync?branch=0.0.5)
(100% with rspec-puppet)

puppet-btsync
=============

BTSync installation and configuration module<br />
[BTSync](http://www.bittorrent.com/intl/en/sync)<br />

## Table of Contents

* [Status](#status)
* [Usage](#usage)
* [Parameters](#parameters)
* [Installation](#installation)
    * [puppet](#puppet)
    * [librarian-puppet](#librarian-puppet)
* [Tests](#tests)
    * [Unit tests](#unit-tests)
    * [Smoke tests](#smoke-tests)
* [Authors](#authors)
* [Contributing](#contributing)
* [Licence](#licence)

## Status

Beta version like BTSync<br />
(0.0.5 released)

## Usage

In your puppet file

```puppet
node default {
  include btsync
}
```

In your hieradata file

```yaml
---
btsync::webui_login: my_login
btsync::webui_pwd: my_password
btsync::api_key: my_api_key
```

It will create `/opt/btsync/btsync.json` with these default values:

```json
{
  "device_name": "My Sync Device",
  "listening_port" : 0,
  "storage_path" : "/opt/btsync/.sync",
  "pid_file" : "/var/run/btsync.pid",
  "check_for_updates" : false,
  "use_upnp" : true,
  "download_limit" : 0,
  "upload_limit" : 0,
  "use_gui" : false,
  "webui" : {
    "listen" : "127.0.0.1:8888",
    "login" : "my_login",
    "password" : "my_password",
    "api_key" : "my_api_key"
  }
}
```

## Parameters

  * `btsync::device_name`: name of the device, default all `My Sync Device`
  * `btsync::listening_port`: listening port, default all `0`
  * `btsync::use_upnp`: upnp activated, default `true`
  * `btsync::download_limit`: download limit, default no limit `0`
  * `btsync::upload_limit`: upload limit, default no limit `0`
  * `btsync::webui_login`: the login for web ui (required)
  * `btsync::webui_pwd`: the password for web ui (required)
  * `btsync::api_key`: the btsync api key (required)
  * `btsync::glibc23`: boolean, btsync version, default `true`
  * `btsync::install_dir`: btsync installation directory, default `/opt/btsync`
  * `btsync::storage_conf_path`: btsync configuration directory, default `/opt/btsync/.sync`
  * `btsync::webui_ip`: the web ui ip, default `127.0.0.1`
  * `btsync::webui_port`: the web ui port, default `8888`
  * `btsync::tmp`: tmp directory used by install, default `/tmp`

## Installation

### puppet

```bash
$ puppet module install gsick/btsync
```

### librarian-puppet

Add in your Puppetfile

```text
mod 'gsick/btsync'
```

and run

```bash
$ librarian-puppet update
```

## Tests

### Unit tests

```bash
$ bundle install
$ rake test
```

### Smoke tests

```bash
$ puppet apply tests/init.pp --noop
```

## Authors

Gamaliel Sick

## Contributing

  * Fork it
  * Create your feature branch (git checkout -b my-new-feature)
  * Commit your changes (git commit -am 'Add some feature')
  * Push to the branch (git push origin my-new-feature)
  * Create new Pull Request

## Licence

```
The MIT License (MIT)

Copyright (c) 2014 gsick

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
