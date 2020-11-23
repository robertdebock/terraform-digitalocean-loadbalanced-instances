# Webserver

A set of resources to make a redundant webserver environment for serving HTML.

```
+--- loadbalancer ---+
| - http -> http     |
| - https -> https   |
+--------------------+
         |
         V
 +--- web-0 ----+
 | apache httpd |-+    <- Amount of machines depends on the `amount`.
 +--------------+ |-+     Here the `amount = 3` is used.
   +--------------+ |
     +--------------+
```
