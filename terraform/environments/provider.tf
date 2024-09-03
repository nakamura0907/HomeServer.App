terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

provider "proxmox" {
  // TODO: 接続情報の管理最適化
  pm_api_url = var.pm_api_url
}