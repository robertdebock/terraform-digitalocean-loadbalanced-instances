resource "digitalocean_ssh_key" "default" {
  name       = "key-1"
  public_key = var.ssh_key
}

resource "digitalocean_droplet" "default" {
  count     = var.amount
  image     = var.image
  name      = "web-${count.index}"
  region    = var.region
  size      = var.size
  ssh_keys  = [digitalocean_ssh_key.default.fingerprint]
}

resource "digitalocean_loadbalancer" "default" {
  name   = "loadbalancer-1"
  region = var.region

  forwarding_rule {
    entry_port      = 80
    entry_protocol  = "http"
    target_port     = 80
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port      = 443
    entry_protocol  = "https"
    target_port     = 443
    target_protocol = "https"
    tls_passthrough = true
  }

  healthcheck {
    port     = 80
    protocol = "http"
    path     = var.healthcheck_path
  }

  droplet_ids = digitalocean_droplet.default.*.id
}
