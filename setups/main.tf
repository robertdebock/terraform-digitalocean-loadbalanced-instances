module "default" {
  source  = "../modules/webserver"
  amount  = 3
  ssh_key =  "~/.ssh/id_rsa.pub"
}

output "default" {
  value = module.default.loadbalancer_ip_addr
}
