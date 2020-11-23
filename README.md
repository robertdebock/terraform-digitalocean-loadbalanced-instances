# Webserver

A set of resources to make a webserver environment for serving HTML.

## Overview

```
    +--- loadbalancer ---+
    | - http -> http     |
    | - https -> https   |
    +--------------------+
       |              |
       V              V
+--- web-0 ----+ +--- web-# ----+
| apache httpd | | apache httpd |
+--------------+ +--------------+
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
