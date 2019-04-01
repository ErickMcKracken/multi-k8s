docker build -t erickmckracken/multi-client:latest -t erickmckracken/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t erickmckracken/multi-server:latest -t erickmckracken/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t erickmckracken/multi-worker:latest -t erickmckracken/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push erickmckracken/multi-client:latest
docker push erickmckracken/multi-server:latest 
docker push erickmckracken/multi-worker:latest

docker push erickmckracken/multi-client:$SHA
docker push erickmckracken/multi-server:$SHA 
docker push erickmckracken/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=erickmckracken/multi-client:$SHA
kubectl set image deployments/server-deployment server=erickmckracken/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=erickmckracken/multi-worker:$SHA