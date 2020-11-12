docker build -t andrewdiedrich/multi-client:latest -t andrewdiedrich/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andrewdiedrich/multi-server:latest -t andrewdiedrich/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andrewdiedrich/multi-worker:latest -t andrewdiedrich/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push andrewdiedrich/multi-client:latest
docker push andrewdiedrich/multi-server:latest
docker push andrewdiedrich/multi-worker:latest
docker push andrewdiedrich/multi-client:$SHA
docker push andrewdiedrich/multi-server:$SHA
docker push andrewdiedrich/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=andrewdiedrich/multi-server:$SHA
kubectl set image deployments/client-deployment client=andrewdiedrich/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=andrewdiedrich/multi-worker:$SHA
