# LXC K3sセットアップ

参考: https://github.com/d3adwolf/kubernetes-inside-proxmox-lxc

## 補足: トラブルシューティング

### k3s kubectl get nodesコマンドでConnection refused

`iptables`パッケージをインストールする（要確認）

kmsgをマウントする

### 再起動時にK3sサービスがdeadになっている

`network.target`サービスの自動起動を有効にする（おそらく固定IPアドレスにすることでも解消する）

### modprobe overlayなどが失敗する

調査中