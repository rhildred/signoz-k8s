#k3d
echo "installing k3d"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
k3d cluster create k3d-cluster --k3s-arg "--disable=traefik@server:0" --volume $PWD/data:/var/data
# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin
# helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
# signoz
helm repo add signoz https://charts.signoz.io
kubectl create ns platform
helm --namespace platform install my-release signoz/signoz
sleep 3
echo "wait for signoz"
kubectl wait pod --all --for=condition=Ready --namespace=platform
helm install my-k8s-infra signoz/k8s-infra --set otelCollectorEndpoint=my-release-signoz-otel-collector:4317 -n platform


