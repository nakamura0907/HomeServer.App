terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

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

provider "proxmox" {
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
}

resource "proxmox_vm_qemu" "k3s_server_1" {
  name        = "k3s-server-1"
  target_node = "pve"

  clone = "debian-template"

  // Cloud-init
  #   force_recreate_on_change_of = ""
  os_type    = "cloud-init"
  ciuser     = "root"
  ipconfig0  = "ip=192.168.0.110/24,gw=192.168.0.1"
  nameserver = "192.168.0.1"
  ciupgrade  = true

  // ハードウェア
  sockets = 1
  cores   = 4
  memory  = "4096"
  scsihw  = "virtio-scsi-pci"

  // オプション
  boot   = "order=scsi0;ide2"
  onboot = true

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = "32G"
          storage = "local-lvm"
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