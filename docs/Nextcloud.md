## インストール

```bash
$ helm repo add nextcloud https://nextcloud.github.io/helm/
$ helm repo update

$ helm install -f nextcloud-values.yaml nextcloud-release nextcloud/nextcloud

$ helm delete nextcloud-release
```

## Keycloak - SSO&SAML設定

グローバル設定

- 複数のユーザーのバックエンド（LDAPなど）の使用を許可する: true

一般

- UIDをマップする属性。: username

Identity Providerデータ

- IdPエンティティの識別子（URIでなければならない）: `<URL>/realms/<realm>`
- SPが認証要求メッセージを送信するIdPのURLターゲット: `<URL>/realms/<realm>/protocol/saml`
- IdPの公開X.509証明書: 後述

### IdPの公開X.509証明書

`<URL>/realms/<realm>/protocol/saml/descriptor`にアクセスして、`<dsig:X509Certificate>`タグ内の値をコピーする

```
-----BEGIN CERTIFICATE-----
MII~
-----END CERTIFICATE-----
```

## メモ

- Nextcloudが不調: PVやPVCも削除して再度デプロイする。データベースもやり直すとなおよし