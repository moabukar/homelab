# K8s on multipass

## Install multipass

```bash
brew install --cask multipass

multipass launch --name k3s-master --cpus 1 --mem 1024M --disk 3G
multipass launch --name k3s-node1 --cpus 1 --mem 1024M --disk 3G
multipass launch --name k3s-node2 --cpus 1 --mem 1024M --disk 3G
multipass exec k3s-master -- /bin/bash -c "curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -"
multipass list
multipass shell k3s-master

sudo cat /var/lib/rancher/k3s/server/node-token
K3S_TOKEN=ID

multipass exec k3s-node1 -- /bin/bash -c "curl -sfL https://get.k3s.io | K3S_TOKEN=${K3S_TOKEN} K3S_URL=${K3S_NODEIP_MASTER} sh -"

multipass exec k3s-node2 -- /bin/bash -c "curl -sfL https://get.k3s.io | K3S_TOKEN=${K3S_TOKEN} K3S_URL=${K3S_NODEIP_MASTER} sh -"

multipass shell k3s-master
kubectl get nodes
```
