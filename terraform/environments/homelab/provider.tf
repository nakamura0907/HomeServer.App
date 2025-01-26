terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  // 1にしてもLXC生成時のエラーは解消せず
  // https://github.com/Telmate/terraform-provider-proxmox/issues/173
  pm_parallel         = 4
}
