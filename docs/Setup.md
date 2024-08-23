# セットアップ

- LXC作成後にsshdを自動で有効化する方法を探す
- クローンしたLXCのネットワーク設定をコマンドラインから変更したい

## 1. Proxmoxのセットアップ

サーバーにProxmoxをセットアップする。

### UTM版

1. UTMをインストールして、Proxmoxのisoからセットアップする
1. 仮想マシン側にて、/etc/network/interfacesの値を編集する（/Library/Preferences/SystemConfiguration/com.apple.vmnet.plist）と合わせる