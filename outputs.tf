output "loadbalancer_ip" {
  description = "The IP (v4) address of the loadbalaner."
  value       = digitalocean_loadbalancer.default.ip
}

output "droplet_ips" {
  description = "The IP (v4) address of the droplet."
  value       = digitalocean_droplet.default.*.ipv4_address
}
