puppet-btsync
=============

BTSync configuration module<br />
[BTSync](http://www.bittorrent.com/intl/en/sync)<br />

## Status
Beta version like BTSync

## Dependencies

*`parser = future in puppet.conf`, due to [each](http://docs.puppetlabs.com/references/latest/function.html#each) function

## Usage
In your hieradata file...

Basic usage:
```yaml
---
btsync::login: my_login
btsync::pwd: my_password
btsync::api_key: my_api_key
```

With more options:
```yaml
---
btsync::login: my_login
btsync::pwd: my_password
btsync::api_key: my_api_key

btsync::install_dir: /opt/btsync
btsync::storage_conf_path: /opt/btsync/.btsync
btsync::webui_ip: 127.0.0.1
btsync::webui_port: 8888
```

## Autor

Gamaliel Sick

## License

The MIT License (MIT)

Copyright (c) 2014 gsick

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
