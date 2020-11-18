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

resource "digitalocean_volume" "default" {
  count                   = var.amount
  region                  = var.region
  name                    = "volume-${count.index}"
  size                    = 32
  initial_filesystem_type = "ext4"
  description             = "Volume for persistent data."
}

resource "digitalocean_volume_attachment" "default" {
  count      = var.amount
  droplet_id = element(digitalocean_droplet.default.*.id, count.index)
  volume_id  = element(digitalocean_volume.default.*.id, count.index)
}

resource "null_resource" "null-1" {
  depends_on = [
    digitalocean_droplet.default
  ]
  provisioner "local-exec" {
    command = "ansible-playbook -i inventory ${path.module}/ansible/playbook.yml"
  }
}

resource "digitalocean_loadbalancer" "default" {
  name   = "loadbalancer-1"
  region = var.region

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 443
    target_protocol = "https"

    tls_passthrough = true
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_ids = digitalocean_droplet.default.*.id
}
