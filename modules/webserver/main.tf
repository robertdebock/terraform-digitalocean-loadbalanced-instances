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
  user_data = <<EOF
#cloud-config
yum_repos:
  sonar:
    name: do agent
    baseurl: "https://repos.insights.digitalocean.com/yum/do-agent/$basearch"
    failovermethod: priority
    enabled: true
    gpgcheck: true
    gpgkey: "https://repos.insights.digitalocean.com/sonar-agent.asc"
runcmd:
  - dnf update -y
  - rpm --import https://repos.insights.digitalocean.com/sonar-agent.asc
  - dnf install -y do-agent
  - systemctl --now enable do-agent
  - dnf install -y httpd
  - systemctl --now enable httpd
EOF
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
