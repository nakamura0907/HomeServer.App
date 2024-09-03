variable "pm_api_url" {
  type = string
}

variable "target_node" {
  type    = string
  default = "proxmox"
}

variable "basic_ostemplate" {
  type = string
  default = "local:vztmpl/ubuntu-23.10-standard_23.10-1_amd64.tar.zst"
}

variable "ssh_public_keys" {
  type = string
}

// モニタリング
variable "monitoring_hostname" {
  type    = string
  default = "monitoring"
}