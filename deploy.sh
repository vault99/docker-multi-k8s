docker build -t vault99/docker-multi-client:latest -t vault99/docker-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vault99/docker-multi-server:latest -t vault99/docker-multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vault99/docker-multi-worker:latest -t vault99/docker-multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vault99/docker-multi-client:latest
docker push vault99/docker-multi-server:latest
docker push vault99/docker-multi-worker:latest

docker push vault99/docker-multi-client:$SHA
docker push vault99/docker-multi-server:$SHA
docker push vault99/docker-multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vault99/docker-multi-server:$SHA
kubectl set image deployments/client-deployment client=vault99/docker-multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vault99/docker-multi-worker:$SHA