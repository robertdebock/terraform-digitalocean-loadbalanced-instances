# Webserver

A set of resources to make a webserver environment for serving HTML.

## Overview

```
+--- loadbalancer ---+
| - http -> http     |
| - https -> https   |
+--------------------+
       |
       V
 +--- web-0 ----+
 | apache httpd |-+
 +--------------+ |-+
   +--------------+ |
     +--------------+
```

## Setup

## Input

| parameter | default          | type   | description                         |
|-----------|------------------|--------|-------------------------------------|
| image     | ubuntu-18-04-x64 | string | The name of the image to use.       |
| size      | s-1vcpu-1gb      | string | The size of the instance to use.    |
| region    | ams3             | string | The region to deploy to.            |
| amount    | 3                | number | The amount of webservers to start.  |
| ssh_key   | NONE             | string | The contents of the public ssh key. |

## Output

| parameter           | description                         |
|---------------------|-------------------------------------|
|loadbalancer_ip_addr | The IP address of the loadbalancer. |

## Example

Here is an example `main.tf`.

```json
module "loadbalanced-instances" {
  source  = "robertdebock/loadbalanced-instances/digitalocean"
  version = "1.0.2"
  amount  = 5
  ssh_key =  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCWswOogkZz/ihQA0lENCwDwSzmtmBWtFwzIzDlfa+eb4rBt6rZBg7enKeMqYtStI/NDneBwZUFBDIMu5zJTbvg7A60/WDhWXZmU21tZnm8K7KREFYOUndc6h//QHig6IIaIwwBZHF1NgXLtZ0qrUUlNU5JSEhDJsObMlPHtE4vFP8twPnfc7hxAnYma5+knU6qTMCDvhBE5tGJdor4UGeAhu+SwSVDloYtt1vGTmnFn8M/OD/fRMksusPefxyshJ37jpB4jY/Z9vzaNHwcj33prwl1b/xRfxr/+KRJsyq+ZKs9u2TVw9g4p+XLdfDtzZ8thR2P3x3MFrZOdFmCbo/5"
}

output "default" {
  value = module.loadbalanced-instances.loadbalancer_ip_addr
}
```
