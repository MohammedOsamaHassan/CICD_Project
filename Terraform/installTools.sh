#!/bin/bash

# ON Jenkins Server
# Step 1: Install Docker
# install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

#Step 2: Install kubectl
# install kubectl
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg # allow unprivileged APT programs to read this keyring
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list   # helps tools such as command-not-found to work correctly
sudo apt-get update
sudo apt-get install -y kubectl
# install kubectl autocomplete
apt-get install bash-completion
echo 'source <(kubectl completion bash)' >>~/.bashrc
source ~/.bashrc

# Step 3:
#--> copy Kube config file to local machine under ~/.kube/config
mkdir -p ~/.kube
export KUBECONFIG=~/.kube/config


# Step 4: run jenkins in docker
# install jenkins in docker
docker run -p 8080:8080 -p 50000:50000 -d --name jenkins --user root \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(which docker):/usr/bin/docker \
  -v ~/.kube:/root/.kube \
  -v /usr/bin/kubectl:/usr/bin/kubectl \
  jenkins/jenkins:lts

# Enter container 
docer exec -it jenkins bash
# export KUBECONFIG

docker exec -it jenkins export KUBECONFIG=/root/.kube/config



# ON K3s Master 
# install K3s
curl -sfL https://get.k3s.io | sh -
cat /var/lib/rancher/k3s/server/node-token

# ON K3s Worker
curl -sfL https://get.k3s.io | K3S_URL=https://myserver:6443 K3S_TOKEN=mynodetoken sh -
