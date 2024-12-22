// provider
variable "pm_api_url" {
  type = string
}
variable "pm_api_token_id" {
  type      = string
  sensitive = true
}
variable "pm_api_token_secret" {
  type      = string
  sensitive = true
}

// Proxmox
variable "target_node" {
  type    = string
  default = "pve"
}
variable "clone_vm_name" {
  type    = string
  default = "debian-template"
}
variable "ciuser" {
  type      = string
  default   = "root"
  sensitive = true
}
variable "ipconfig_gw" {
  type    = string
  default = "gw=192.168.0.1"
}
variable "nameserver" {
  type    = string
  default = "192.168.0.1"
}
variable "storage_pool" {
  type    = string
  default = "local-lvm"
}
// k3s_server_
variable "k3s_server_sockets" {
  type    = number
  default = 1
}
variable "k3s_server_cores" {
  type    = number
  default = 4
}
variable "k3s_server_memory" {
  type    = string
  default = "4096"
}
variable "k3s_server_storage_size" {
  type    = string
  default = "32G"
}
// k3s_agent_
variable "k3s_agent_sockets" {
  type    = number
  default = 1
}
variable "k3s_agent_cores" {
  type    = number
  default = 4
}
variable "k3s_agent_memory" {
  type    = string
  default = "4096"
}
variable "k3s_agent_storage_size" {
  type    = string
  default = "32G"
}

// リソース別
variable "k3s_server_1_vmid" {
  type    = number
  default = 9110
}
variable "k3s_server_1_ipconfig" {
  type    = string
  default = "ip=192.168.0.110/24"
}

variable "k3s_agent_1_vmid" {
  type    = number
  default = 9111
}
variable "k3s_agent_1_ipconfig" {
  type    = string
  default = "ip=192.168.0.111/24"
}