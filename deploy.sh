docker build -t ewiklund/multi-client:latest -t ewiklund/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ewiklund/multi-server:latest -t ewiklund/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t ewiklund/multi-worker:latest -t ewiklund/multi-worker:$SHA -f ./client/Dockerfile ./worker
docker push ewiklund/multi-client:latest
docker push ewiklund/multi-server:latest
docker push ewiklund/multi-worker:latest

docker push ewiklund/multi-client:$SHA
docker push ewiklund/multi-server:$SHA
docker push ewiklund/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ewiklund/multi-server:$SHA
kubectl set image deployments/client-deployment client=ewiklund/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ewiklund/multi-worker:$SHA