resource "proxmox_vm_qemu" "this" {
  name        = var.name
  target_node = var.target_node

  clone = var.clone_vm_name
  vmid  = var.vmid

  // Cloud-init
  #   force_recreate_on_change_of = ""
  os_type    = "cloud-init"
  ciuser     = var.ciuser
  ipconfig0  = var.ipconfig
  nameserver = var.nameserver
  ciupgrade  = true

  // ハードウェア
  sockets = var.sockets
  cores   = var.cores
  memory  = var.memory
  scsihw  = "virtio-scsi-pci"

  // オプション
  boot   = "order=scsi0;ide2"
  onboot = true

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = var.storage_pool
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = var.storage_size
          storage = var.storage_pool
        }
      }
    }
  }
  serial {
    id   = 0
    type = "socket"
  }

  lifecycle {
    ignore_changes = [
      ciuser,
      sshkeys,
      network,
    ]
  }
}