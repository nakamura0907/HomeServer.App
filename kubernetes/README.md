## 前提条件

- Helm CLIインストール済み
- Vaultサーバ稼働中

## コマンド

```bash
# Helm
helm repo add metallb https://metallb.github.io/metallb
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts

helm update

# 名前空間
kubectl apply -f ./kubernetes/namespaces

# MetalLB
helm install metallb metallb/metallb --namespace metallb-system
kubectl apply -f ./kubernetes/services/00_metallb

# Vault
helm install csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver --namespace kube-system
kubectl apply -f ./kubernetes/roles/sci-driver.yaml
helm install vault hashicorp/vault -n secret-manager --set "server.enabled=false" --set "injector.enabled=false" --set "csi.enabled=true"

# Pi-hole
kubectl apply -f ./kubernetes/services/pihole
```
