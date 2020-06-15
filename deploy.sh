docker build -t gkamstra/multi-client:latest -t gkamstra/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gkamstra/multi-server:latest -t gkamstra/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gkamstra/multi-worker:latest -t gkamstra/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gkamstra/multi-client:latest
docker push gkamstra/multi-server:latest
docker push gkamstra/multi-worker:latest

docker push gkamstra/multi-client:$SHA
docker push gkamstra/multi-server:$SHA
docker push gkamstra/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=gkamstra/multi-client:$SHA
kubectl set image deployments/server-deployment server=gkamstra/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=gkamstra/multi-worker:$SHA

