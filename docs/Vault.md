# Vault

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

$ helm install vault hashicorp/vault \
    --set "global.externalVaultAddr=https://192.168.0.211:8200"
    
$ cat > vault-secret.yaml <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: vault-token-g955r
  annotations:
    kubernetes.io/service-account.name: vault
type: kubernetes.io/service-account-token
EOF

$ VAULT_HELM_SECRET_NAME=$(kubectl get secrets --output=json | jq -r '.items[].metadata | select(.name|startswith("vault-token-")).name')

$ TOKEN_REVIEW_JWT=$(kubectl get secret $VAULT_HELM_SECRET_NAME --output='go-template={{ .data.token }}' | base64 --decode)

$ KUBE_CA_CERT=$(kubectl config view --raw --minify --flatten --output='jsonpath={.clusters[].cluster.certificate-authority-data}' | base64 --decode)

$ KUBE_HOST=$(kubectl config view --raw --minify --flatten --output='jsonpath={.clusters[].cluster.server}')

$ vault write auth/kubernetes/config \
     token_reviewer_jwt="$TOKEN_REVIEW_JWT" \
     kubernetes_host="$KUBE_HOST" \
     kubernetes_ca_cert="$KUBE_CA_CERT" \
     issuer="https://kubernetes.default.svc.cluster.local"



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