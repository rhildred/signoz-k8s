# signoz-k8s
signoz setup on k3d with k8s integration

TLDR;

```bash

npm run postinstall
kubectl -n platform port-forward svc/my-release-signoz-frontend 3301:3301

```

Then develop your microfrontend/full stack web component in another terminal. When you are ready to access the otel collector from your web component expose the http port by running:

```bash
kubectl -n platform port-forward svc/my-release-signoz-otel-collector 4318:4318
```

## MYSQL

If your microservice needs mysql, you can run:

```bash
kubectl apply -f https://raw.githubusercontent.com/salesucation/salesucation/refs/heads/richstorage/mysqlpvc.yaml
kubectl apply -f https://raw.githubusercontent.com/salesucation/salesucation/refs/heads/richstorage/mysql.yaml
```

There is an adminer sidecar in the mysql pod on port 8080 and mysql is running on port 3306. Do a `kubectl get pods` to see the name of the pod and `port-forward` as needed.

## S3

There is a similar setup for minio to the mysql setup above at https://github.com/sleighzy/k3s-minio-deployment. Pay special attention to 100-pvc.yaml and 400-deployment.yaml. They should make sense after the mysqlpvc.yaml and mysql.yaml from this repository.

Happy Coding!

