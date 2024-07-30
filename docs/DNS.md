# pi-hole

1. 上流DNSにUnboundを指定する

```
<IPアドレス>[#ポート番号]
192.168.x.x#5053
```

1. その他の上流DNSの設定を削除する

↑で設定したカスタムDNSの優先順位が低いため

## メモ

- Pod内で名前解決ができない
    - pi-holeの「Interface settings」でeth0バインドのみになっていないか