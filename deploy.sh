docker build -t Xecius/multi-client:latest -t Xecius/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t Xecius/multi-server:latest -t Xecius/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t Xecius/multi-worker:latest -t Xecius/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push Xecius/multi-client:latest 
docker push Xecius/multi-server:latest
docker push Xecius/multi-worker:latest

docker push Xecius/multi-client:$SHA 
docker push Xecius/multi-server:$SHA 
docker push Xecius/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=Xecius/multi-client:$SHA 
kubectl set image deployments/server-deployment server=Xecius/multi-server:$SHA 
kubectl set image deployments/worker-deployment worker=Xecius/multi-worker:$SHA 