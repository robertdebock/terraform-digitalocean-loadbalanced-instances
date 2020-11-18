# Webserver

A set of resources to make a webserver environment

## Overview

```
    +--- loadbalancer ---+
    | - http -> http     |
    | - https -> https   |
    +--------------------+
       |              |
       V              V
+--- web-0 ---+ +--- web-# ---+
|             | |             |
+-------------+ +-------------+
```

## Setup

For this code to run, you will needs a [terraform-ansible plugin](https://github.com/radekg/terraform-provisioner-ansible):

```bash
version=2.4.0
curl -sL \
  https://raw.githubusercontent.com/radekg/terraform-provisioner-ansible/master/bin/deploy-release.sh \
  --output /tmp/deploy-release.sh
chmod +x /tmp/deploy-release.sh
/tmp/deploy-release.sh -v ${version}
rm -rf /tmp/deploy-release.sh
```


## Input

| parameter | default          | type   | description                        |
|-----------|------------------|--------|------------------------------------|
| amount    | 2                | number | The amount of webservers to start. |
| region    | ams3             | string | The region to deploy to.           |
| image     | ubuntu-18-04-x64 | string | The name of the image to use.      |
| size      | s-1vcpu-1gb      | string | The size of the instance to use.   |
| ssh_key   | NONE             | string | The path to the public ssh key     |

## Output

| parameter           | description                         |
|---------------------|-------------------------------------|
|loadbalancer_ip_addr | The IP address of the loadbalancer. |
