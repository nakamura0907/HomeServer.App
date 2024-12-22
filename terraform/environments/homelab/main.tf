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

  sockets = var.k3s_agent_sockets
  cores   = var.k3s_agent_cores
  memory  = var.k3s_agent_memory

  storage_pool = var.storage_pool
  storage_size = var.k3s_agent_storage_size
}
