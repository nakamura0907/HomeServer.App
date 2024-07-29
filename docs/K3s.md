## Installation

### Requirements

[Raspberry pi](https://docs.k3s.io/installation/requirements?os=pi)

### Configuration Options

```
$ curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --node-external-ip <value>
```


```
$ export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
```