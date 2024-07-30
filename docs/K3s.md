## Installation

### Requirements

[Raspberry pi](https://docs.k3s.io/installation/requirements?os=pi)

### Configuration Options

```
$ curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --node-external-ip <value>
```


```bash
# Error: Kubernetes cluster unreachable: Get "http://localhost:8080/version": dial tcp [::1]:8080: connect: connection refused
$ export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

$ kubectl run -i --tty --rm debug --image=busybox --restart=Never -- sh
```