// モニタリング
// FIXME: startがTASK ERROR: can't lock file '/run/lock/lxc/pve-config-102.lock' - got timeoutで失敗
module "monitoring" {
  source = "../modules/proxmox-lxc"

  target_node = var.target_node

  ostemplate      = var.basic_ostemplate
  hostname        = var.monitoring_hostname
  ssh_public_keys = var.ssh_public_keys
}

// DNS Server
module "homedns" {
  source = "../modules/proxmox-lxc"

  target_node = var.target_node

  ostemplate      = var.basic_ostemplate
  hostname        = var.homedns_hostname
  ssh_public_keys = var.ssh_public_keys
  network_ip      = var.homedns_network_ip
}