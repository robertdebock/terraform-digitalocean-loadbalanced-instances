output "loadbalancer_ip_addr" {
  description = "The IP (v4) address of the loadbalaner."
  value       = digitalocean_loadbalancer.default.ip
}
