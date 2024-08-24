# セットアップ

1. Proxmoxセットアップ - 手動?
1. LXC作成 - Terraform
1. LXCセットアップ - Ansible

## 手順書

### 1. Proxmoxのセットアップ

サーバーにProxmoxをセットアップする。

#### UTM版

1. UTMをインストールして、Proxmoxのisoからセットアップする
1. 仮想マシン側にて、/etc/network/interfacesの値を編集する（/Library/Preferences/SystemConfiguration/com.apple.vmnet.plist）と合わせる

## メモ

- LXC作成後にsshdを自動で有効化する方法を探す
    - Debianでは5分ほど待機するも自動起動せず
        - enabledなのに。。。
    - Ubuntu23.10で自動起動を確認
- クローンしたLXCのネットワーク設定をコマンドラインから変更したい