# Webserver

A set of resources to make a redundant webserver environment for serving HTML.

Nota bene: the configuration of the instances/droplets is not done in Terraform.

```
+--- loadbalancer ---+
| - http -> http     |
| - https -> https   |
+--------------------+
         |
         V
 +--- web-0 ----+
 |              |-+    <- Amount of machines depends on the `amount`.
 +--------------+ |-+     Here the `amount = 3` is used.
   +--------------+ |
     +--------------+
```
