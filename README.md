kubernetesでRedisクラスターを構成するサンプルです。

```
docker build -t redis-cluster-job -f Dockerfile.job .
kubectl create namespace myapp
kubectl apply -f k8s-sample.yml
```