## Nextcloud - SSO&SAML設定

### 前提

- レルムが作成されている
- ログイン用のユーザが作成されている

### 設定内容

Create client

- Client type: SAML
- Client ID: `<URL>/apps/user_saml/saml/metadata`
- Root URL: `<URL>`
- Valid redirect URIs: `<URL>/*`

Client details - Keys

- Client signature required: Off

Client details - Client scopes - `<URL>/apps/user_saml/saml/metadata-dedicated`

- User Property
    - Name: username
    - Property: username
    - Friendly Name: username
    - SAML Attribute Name: username
    - SAML Attribute NameFormat: Basic
- User Property
    - Name: email
    - Property: email
    - Friendly Name: email
    - SAML Attribute Name: email
    - SAML Attribute NameFormat: Basic
- Role list
    - Name: role list
    - Role attribute name: Role
    - SAML Attribute NameFormat: Basic
    - Single Role Attribute: On