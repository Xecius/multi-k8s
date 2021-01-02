docker build -t xecius/multi-client:latest -t xecius/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t xecius/multi-server:latest -t xecius/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t xecius/multi-worker:latest -t xecius/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push xecius/multi-client:latest 
docker push xecius/multi-server:latest
docker push xecius/multi-worker:latest

docker push xecius/multi-client:$SHA 
docker push xecius/multi-server:$SHA 
docker push xecius/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=xecius/multi-client:$SHA 
kubectl set image deployments/server-deployment server=xecius/multi-server:$SHA 
kubectl set image deployments/worker-deployment worker=xecius/multi-worker:$SHA 