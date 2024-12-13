# Vault

## 【LXC】　インストール

```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vault

openssl req -x509 -nodes -newkey rsa:4096 -keyout /etc/vault.d/vault.key -out /etc/vault.d/vault.crt -subj "/CN=vault.local" -addext "subjectAltName=IP:192.168.0.211"
chown vault:vault /etc/vault.d/vault.key /etc/vault.d/vault.crt
```

`/etc/vault.d/vault.hcl`の編集

```hcl
# HTTPS listener
listener "tcp" {
  address       = "0.0.0.0:8200"
 # tls_cert_file = "/opt/vault/tls/tls.crt"
 #  tls_key_file  = "/opt/vault/tls/tls.key"
  tls_cert_file = "/etc/vault.d/vault.crt"
  tls_key_file = "/etc/vault.d/vault.key"
}

# 省略

disable_mlock = true
api_addr = "https://192.168.0.211:8200"
```

## セットアップ

### Kubernetes

## OLD

メモ
問題点
- Vault難しい
- 固定IPだと証明書のエラーが出る (tls: failed to verify certificate: x509: cannot validate certificate for 192.168.0.211 because it doesn't contain any IP SANs" backoff=2m3.83s)
    - 証明書の更新
    - 検証スキップアノテーション

Vault関連Todo
- Vaultそのもの勉強問題
- 証明書検証スキップ問題
- 別名前空間

↑
1. secret-manager名前空間でVaultからシークレットを取得できるようにする

https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-external-vault#install-the-vault-helm-chart-configured-to-address-an-external-vault

$ kubectl create sa internal-app

$ helm install vault hashicorp/vault --set "global.externalVaultAddr=https://192.168.0.211:8200" -n secret-manager
    
$ cat > vault-secret.yaml <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: vault-token-g955r
  annotations:
    kubernetes.io/service-account.name: vault
type: kubernetes.io/service-account-token
EOF

$ VAULT_ADDR="https://192.168.0.211:8200"
$ VAULT_SKIP_VERIFY=true 

$ VAULT_HELM_SECRET_NAME=$(kubectl get secrets --output=json -n secret-manager | jq -r '.items[].metadata | select(.name|startswith("vault-token-")).name')

$ TOKEN_REVIEW_JWT=$(kubectl get secret $VAULT_HELM_SECRET_NAME --output='go-template={{ .data.token }}' -n secret-manager | base64 --decode)

$ KUBE_CA_CERT=$(kubectl config view --raw --minify --flatten --output='jsonpath={.clusters[].cluster.certificate-authority-data}' -n secret-manager | base64 --decode)

$ KUBE_HOST=$(kubectl config view --raw --minify --flatten --output='jsonpath={.clusters[].cluster.server}' -n secret-manager)

$ vault write auth/kubernetes/config \
     token_reviewer_jwt="$TOKEN_REVIEW_JWT" \
     kubernetes_host="$KUBE_HOST" \
     kubernetes_ca_cert="$KUBE_CA_CERT" \
     issuer="https://kubernetes.default.svc.cluster.local"

$ vault kv put secret/kubernetes/xxx 

$ vault policy write kubernetes-secrets - <<EOF
path "secret/data/kubernetes/*" {
  capabilities = ["read"]
}
EOF

$ vault write auth/kubernetes/role/xxx-app \
     bound_service_account_names=xxx-app \
     bound_service_account_namespaces=xxx \
     policies=kubernetes-secrets \
     ttl=24h


Vault CSI Provider

helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts
helm install csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver --namespace kube-system
helm install vault hashicorp/vault -n secret-manager \
  --set "server.enabled=false" \
  --set "injector.enabled=false" \
  --set "csi.enabled=true"

CSIドライバに権限を与える

kubectl logs -n kube-system -l app=secrets-store-csi-driver

ClusterRoleとClusterRoleBindingを作成する

## 要件

```bash
$ apt update -y
$ apt install -y sudo gpg
$ apt-get install lsb-release
```

## Consul

```bash
$ consul agent -dev -data-dir /tmp/consul
$ consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -node=consul-server -bind=192.168.0.211 -config-dir /etc/consul.d &
```

↓の方法でインストールするとagentモードで動くサービスファイルが作成される

```bash
$ wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
$ echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
$ sudo apt update && sudo apt install consul
```