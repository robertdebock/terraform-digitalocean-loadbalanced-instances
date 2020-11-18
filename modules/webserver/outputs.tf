output "loadbalancer_ip_addr" {
  value = digitalocean_loadbalancer.default.ip
}

resource "local_file" "inventory" {
  content = templatefile("${path.module}/inventory.tmpl",
  {
    webservers = digitalocean_droplet.default.*.ipv4_address,
  }
  )
  filename = "inventory"
}
