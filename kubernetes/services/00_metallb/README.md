```bash
$ helm repo add metallb https://metallb.github.io/metallb

$ kubectl apply -f ../../../namespaces/metallb-system.yaml
$ helm install metallb metallb/metallb --namespace metallb-system

$ kubectl apply -f ./metallb-config.yaml
$ kubectl apply -f ./metallb-test.yaml
```

## K3sの場合

```bash
# https://hassiweb.gitlab.io/memo/docs/memo/k3s/k3s-disable-klipper-lb/
$ curl -sfL https://get.k3s.io | sh -s - server --disable servicelb
$ sudo kubectl get ds -n kube-system
No resources found in kube-system namespace.
```

```bash
# もとに戻す
$ curl -fL https://get.k3s.io | sh -s - server
```