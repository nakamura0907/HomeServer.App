# インストール

```bash
$ helm repo add nextcloud https://nextcloud.github.io/helm/
$ helm repo update

$ helm install -f nextcloud-values.yaml nextcloud-release nextcloud/nextcloud

$ helm delete nextcloud-release
```