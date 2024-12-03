# VM

VMは基本的にCloud-init設定をしたテンプレートをクローンする形で使用する。

## Cloud-initテンプレートの作成

[公式ドキュメント](https://pve.proxmox.com/wiki/Cloud-Init_Support#_preparing_cloud_init_templates)

- [Debian](https://cdimage.debian.org/images/cloud/)

```bash
$ wget <cloud-image>.qcow2

$ qm create 8000 --memory 2048 --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci
$ qm set 8000 --scsi0 local-lvm:0,import-from=/path/to/bionic-server-cloudimg-amd64.img

$ qm set 8000 --ide2 local-lvm:cloudinit
$ qm set 8000 --boot order=scsi0
$ qm set 8000 --serial0 socket --vga serial0

$ qm template 8000
```

## トラブルシューティング

### WebUIのコンソールでキーボード入力するとリロードしてしまう

ハードウェアでシリアルポートを追加し、ディスプレイを該当のシリアルターミナルに変更する。

### cloud-initで静的なIPアドレスを設定するとインターネットに接続できなくなる

ゲートウェイも設定する。
