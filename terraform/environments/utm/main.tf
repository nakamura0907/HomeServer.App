// DNS Server
module "homedns" {
  source = "../modules/proxmox-lxc"

  target_node = var.target_node

  ostemplate      = var.basic_ostemplate
  hostname        = var.homedns_hostname
  ssh_public_keys = var.ssh_public_keys
  network_ip      = var.homedns_network_ip
  vmid            = var.homedns_vmid
}

// モニタリング
// FIXME: startがTASK ERROR: can't lock file '/run/lock/lxc/pve-config-102.lock' - got timeoutで失敗
// 並列オプションやVMIDをいじっても動作せず。API経由が無難か
module "monitoring" {
  source = "../modules/proxmox-lxc"

  target_node = var.target_node

  ostemplate      = var.basic_ostemplate
  hostname        = var.monitoring_hostname
  ssh_public_keys = var.ssh_public_keys
  network_ip      = var.monitoring_network_ip
  vmid            = var.monitoring_vmid
}