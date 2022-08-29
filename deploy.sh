docker build -t dsinkey9/multi-client:latest -t dsinkey9/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dsinkey9/multi-server:latest -t dsinkey9/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dsinkey9/multi-worker:latest -t dsinkey9/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dsinkey9/multi-client:latest
docker push dsinkey9/multi-server:latest
docker push dsinkey9/multi-worker:latest

docker push dsinkey9/multi-client:$SHA
docker push dsinkey9/multi-server:$SHA
docker push dsinkey9/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dsinkey9/multi-server:$SHA
kubectl set image deployments/client-deployment client=dsinkey9/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dsinkey9/multi-worker:$SHA