#!/usr/bin/bash

# Deploying ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Installing ArgoCD CLI
#VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
#sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-linux-amd64
#sudo chmod +x /usr/local/bin/argocd

# Logging using Argo CLI
#kubectl wait -n argocd --for=condition=ready pod --selector=app.kubernetes.io/name=argocd-server --timeout=600s
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
export PASS=$(kubectl --namespace argocd get pods --selector app.kubernetes.io/name=argocd-server --output name | cut -d'/' -f 2)
argocd login --insecure --username admin --password $PASS --grpc-web localhost:8080
