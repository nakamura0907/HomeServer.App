// モニタリング
module "monitoring" {
  source = "../modules/proxmox-lxc"

  target_node = var.target_node

  ostemplate = var.basic_ostemplate
  hostname = var.monitoring_hostname
  ssh_public_keys = var.ssh_public_keys
}