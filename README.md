# Homelab

Bare-metal Kubernetes cluster on [Raspberry Pi 5](https://www.raspberrypi.org/).

- Apps
  - [ArgoCD](https://argoproj.github.io/argo-cd/)
  - [Grafana](https://grafana.com/)
  - [Kubernetes](https://kubernetes.io/)
  - [MetalLB](https://metallb.universe.tf/)
  - [Nginx Ingress](https://kubernetes.github.io/ingress-nginx/)
  - [Prometheus](https://prometheus.io/)
  - [Cilium](https://cilium.io/)
  - [Helm](https://helm.sh/)
  - [Loki](https://grafana.com/oss/loki/)

- Hardware
  - Raspberry Pi 5
    - 4GB RAM
    - 64GB SSD
    - 2.4GHz Quad-Core CPU
    - Switches (managed)

- Pending...

## Usage

```bash

# Set up the master node
make setup-master

# Set up the worker nodes
make setup-nodes

# Run post-installation tasks
make post-install
```

## Test with multipass

```bash
multipass launch 22.04 --name k8s-master --cpus 2 --memory 2G --disk 5G
multipass launch 22.04 --name k8s-worker1 --cpus 1 --memory 1G --disk 4G
multipass launch 22.04 --name k8s-worker2 --cpus 1 --memory 1G --disk 4G

multipass exec k8s-master -- bash -c "echo '$(cat ~/.ssh/id_rsa.pub)' >> ~/.ssh/authorized_keys"

multipass exec k8s-worker1 -- bash -c "echo '$(cat ~/.ssh/id_rsa.pub)' >> ~/.ssh/authorized_keys"

multipass exec k8s-worker2 -- bash -c "echo '$(cat ~/.ssh/id_rsa.pub)' >> ~/.ssh/authorized_keys"

multipass exec k8s-master -- bash

multipass list ## Check the IP address of the master node and the worker nodes and put them in the inventory file

## Optional SSH
ssh ubuntu@192.168.64.16
ssh ubuntu@192.168.64.20 

ssh-keygen -t rsa -b 4096 ## if you don't have an ssh key, create one

multipass exec k8s-master -- bash -c "echo '$(cat ~/.ssh/id_rsa.pub)' >> ~/.ssh/authorized_keys"
multipass exec k8s-worker1 -- bash -c "echo '$(cat ~/.ssh/id_rsa.pub)' >> ~/.ssh/authorized_keys"
multipass exec k8s-worker2 -- bash -c "echo '$(cat ~/.ssh/id_rsa.pub)' >> ~/.ssh/authorized_keys"

make config
make setup-master
make setup-nodes
make post-install


multipass shell k8s-master
kubectl get nodes

multipass stop --all
multipass delete --all

multipass delete --purge node1 node2 node3
multipass purge
```
