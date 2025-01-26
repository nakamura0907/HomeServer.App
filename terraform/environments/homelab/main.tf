// k3s_server
module "k3s_server_1" {
  source = "../../modules/proxmox-vm-cloud-init"

  name        = var.k3s_server_1_name
  target_node = var.target_node

  clone_vm_name = var.clone_vm_name
  vmid          = var.k3s_server_1_vmid

  ciuser     = var.ciuser
  ipconfig   = "${var.k3s_server_1_ipconfig},${var.ipconfig_gw}"
  nameserver = var.nameserver
  sshkeys    = var.sshkeys

  sockets = var.k3s_server_sockets
  cores   = var.k3s_server_cores
  memory  = var.k3s_server_memory

  storage_pool = var.storage_pool
  storage_size = var.k3s_server_storage_size
}

// k3s_agent
module "k3s_agent_1" {
  source = "../../modules/proxmox-vm-cloud-init"

  name        = var.k3s_agent_1_name
  target_node = var.target_node

  clone_vm_name = var.clone_vm_name
  vmid          = var.k3s_agent_1_vmid

  ciuser     = var.ciuser
  ipconfig   = "${var.k3s_agent_1_ipconfig},${var.ipconfig_gw}"
  nameserver = var.nameserver
  sshkeys    = var.sshkeys

  sockets = var.k3s_agent_sockets
  cores   = var.k3s_agent_cores
  memory  = var.k3s_agent_memory

  storage_pool = var.storage_pool
  storage_size = var.k3s_agent_storage_size
}

module "k3s_agent_2" {
  source = "../../modules/proxmox-vm-cloud-init"

  name        = var.k3s_agent_2_name
  target_node = var.target_node

  clone_vm_name = var.clone_vm_name
  vmid          = var.k3s_agent_2_vmid

  ciuser     = var.ciuser
  ipconfig   = "${var.k3s_agent_2_ipconfig},${var.ipconfig_gw}"
  nameserver = var.nameserver
  sshkeys    = var.sshkeys

  sockets = var.k3s_agent_sockets
  cores   = var.k3s_agent_cores
  memory  = var.k3s_agent_memory

  storage_pool = var.storage_pool
  storage_size = var.k3s_agent_storage_size
}

// k3s_staging
module "k3s_staging_server_1" {
  source = "../../modules/proxmox-vm-cloud-init"

  name        = var.k3s_staging_server_1_name
  target_node = var.target_node

  clone_vm_name = var.clone_vm_name
  vmid          = var.k3s_staging_server_1_vmid

  ciuser     = var.ciuser
  ipconfig   = "${var.k3s_staging_server_1_ipconfig},${var.ipconfig_gw}"
  nameserver = var.nameserver
  sshkeys    = var.sshkeys

  sockets = var.k3s_agent_sockets
  cores   = var.k3s_agent_cores
  memory  = var.k3s_agent_memory

  storage_pool = var.storage_pool
  storage_size = var.k3s_agent_storage_size
}

// NAS
// BUGFIX: パススルー周りのエラー解消
// rootのトークンでも不可能だったためrootユーザでの直接アクセスに変更する
// https://github.com/Telmate/terraform-provider-proxmox/issues/1056
module "openmediavault" {
  source = "../../modules/proxmox-vm-cloud-init"

  name        = var.openmediavault_name
  target_node = var.target_node

  clone_vm_name = var.clone_vm_name
  vmid          = var.openmediavault_vmid

  ciuser     = var.ciuser
  ipconfig   = "${var.openmediavault_ipconfig},${var.ipconfig_gw}"
  nameserver = var.nameserver
  sshkeys    = var.sshkeys

  sockets = var.openmediavault_sockets
  cores   = var.openmediavault_cores
  memory  = var.openmediavault_memory

  storage_pool = var.storage_pool
  storage_size = var.openmediavault_storage_size

  add_passthrough  = true
  passthrough_file = var.openmediavault_passthrough_file
}

// Secret Manager
// BUGFIX: 生成時に起動しない
// TASK ERROR: can't lock file '/run/lock/lxc/pve-config-212.lock' - got timeout
module "secret_manager" {
  source = "../../modules/proxmox-lxc"

  target_node = var.target_node

  ostemplate  = var.lxc_ostemplate
  cpuunits    = var.secret_manager_cpuunits
  hostname    = var.secret_manager_hostname
  memory      = var.secret_manager_memory
  network_ip  = var.secret_manager_network_ip
  rootfs_size = var.secret_manager_rootfs_size
  swap        = var.secret_manager_swap
  vmid        = var.secret_manager_vmid
}
# TODO: curlを使ったlocal-execに修正する
# resource "null_resource" "configure_lxc" {
#   depends_on = [ module.secret_manager ]

#   connection {
#     type = "ssh"
#     user = "root"
#     host = var.proxmox_server_ip
#     private_key = file(var.ssh_private_key_path)
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sleep 10",
#       "pct set ${var.secret_manager_vmid} --onboot 1",
#       "pct start ${var.secret_manager_vmid}"
#      ]
#   }
# }

// development
