variable "image" {
  description = "The name of the image."
  type        = string
  default     = "fedora-33-x64"
}

variable "size" {
  description = "The size of image to deploy."
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "region" {
  description = "The name of the region."
  type        = string
  default     = "ams3"
}

variable "amount" {
  description = "The number of webservers to deploy."
  type        = number
  default     = 3
}

variable "healtcheck_path" {
  description = "The path to check for in the loadbalancer."
  type        = string
  default     = "/"
}

variable "ssh_key" {
  description = "The public ssh key to place on the webservers."
  type        = string
}
