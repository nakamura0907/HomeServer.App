# セットアップ

## 1. Proxmoxのセットアップ

サーバーにProxmoxをセットアップする。

### UTM版

1. UTMをインストールして、Proxmoxのisoからセットアップする
1. 仮想マシン側にて、/etc/network/interfacesの値を編集する（/Library/Preferences/SystemConfiguration/com.apple.vmnet.plist）と合わせる