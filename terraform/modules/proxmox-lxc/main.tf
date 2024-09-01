resource "proxmox_lxc" "basic" {
  target_node  = variable.target_node

  ostemplate   = var.ostemplate
  cmode        = var.cmode
  cpuunits     = var.cpuunits
  hostname     = var.hostname
  memory       = var.memory
  password     = var.password
  ssh_public_keys = var.ssh_public_keys
  start        = var.start
  swap         = var.swap
  unprivileged = true

  // Terraform will crash without rootfs defined
  rootfs {
    storage = var.rootfs_storage
    size    = var.rootfs_size
  }

  network {
    name   = var.network_name
    bridge = var.network_bridge
    ip     = var.network_ip
  }
}