variable "target_node" {
  type = string
  default = "proxmox"
}

variable "basic_ostemplate" {
  type = string
  // TODO: 修正
  default = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
}

variable "ssh_public_keys" {
  type = string
}

// モニタリング
variable "monitoring_hostname" {
  type = string
  default = "monitoring"
}