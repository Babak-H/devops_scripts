# install minikube
brew update
brew install hyperkit
brew install minikube
 
# make sure it works properly
kubectl
minikube
 
# start it
minikube start 
 
# view all the available nodes
kubectl get nodes
 
# get current status
minikube status
 
# version of kubectl CLI
kubectl version
 
# show all the deployments (images)
kubectl get deployment
 
# show all pods (running deployments)
kubectl get pod
 
# network services related to k8
kubectl get services
 
# create a new pod based on an image
kubectl create deployment NAME --image=image
kubectl create deployment nginx-depl --image=nginx
kubectl create deployment mongo-depl --image=mongo
 
# show replica sets
kubectl get replicaset
 
# edit deployment options
kubectl edit deployment nginx-depl
 
# show the pod history logs
kubectl logs PodName
kubectl logs nginx-depl-5c8bf76b5b-5k52h
 
# show details of a running pod
kubectl describe pod PodName
kubectl describe pod
kubectl describe service nginx-service
mongo-depl-5fd6b7d4b4-dvlx6
 
# similar to docker images, go into a pod OS as root user
kubectl exec -it PodName -- bin/bash
kubectl exec -it mongo-depl-5fd6b7d4b4-dvlx6 -- bin/bash
 
# delete a deployment based on their name
kubectl get deployment
kubectl delete deployment mongo-depl
 
# create a yaml file and use it for installing a pod, instead of writing everything in command line
# this will replace => kubectl create deployment NAME --image=image
kubectl apply -f config-file.yaml
kubectl apply -f nginx-deployment.yaml
 
# get more info about the pods
kubectl get pod -o wide
 
# view the automatically generated Status of the the yaml configuration file
kubectl get deployment nginx-deployment -o yaml > nginx-deployment-result.yaml
 
# will delete configuration file and the pods
kubectl delete -f nginx-deployment.yml
 
# encrypt a normal string called "username"|"password" into base64
echo -n 'username' | base64
echo -n 'password' | base64
 
# after saying the encrypted values in the secret yaml file, apply them so they are available for the whole project
kubectl apply -f mongo-secret.yml
 
# shows the secret values
kubectl get secret
 
# get all components of an application
kubectl get all | grep AppName
kubectl get all | grep mongodb
 
 
# this command will assign a public ip address to the service
minikube service serviceName
minikube service mongo-express-service
 
# get all the available namespaces
kubectl get namespace
kubectl get ns
 
# information about public-space namespace
Kubectl cluster-info
 
# show all the components inside the default namespace
kubectl api-resources --namespaced=false
 
# show all the components with particular namespace
kubectl api-resources --namespaced=false
 
# create component inside a namespace (if not defined inside config file)
Kubectl apply -f mysql-configmap.yml --namespace=my-space
 
# in case you would want to change active namespace
brew install kubectl
# show all available namespaces
Kubens
# change active namespace to “my-namespace”
Kubens my-namespace
 
# add ingress to minikube
minikube addons enable ingress
 
# view all ingress controllers
kubectl get pod -n kube-system
 
# how to apply ingress config file named “dashboard-ingress”
kubectl apply -f dashboard-ingress.yaml
 
# how to see if the ingress controller is installed
kubectl get ingress -n dashboard-ingress
# same as above with more info
kubectl get ingress -n dashboard-ingress --watch
 
# search for a helm chart
helm search <keyword>
 
# install a helm chart
helm install <chartname>
 
# how to inject values into helm template file
helm install --values=my-values.yml <chartname>
 
helm install --set version=2.0.0
 
# how to update helm charts
helm upgrade <chartname>

# save helm values in yaml file to use them later
helm show values prom-repo/kube-prometheus-stack > values.yml

# apply changes after updating values.yml file
helm  upgrade monitoring prom-repro/kub-promethues-stack -- values=values.yaml

# download chart from local directory
helm pull prom-repo/kube-prometheus-stack
 
Kubectl rollout status deployment <AppName>
 
Kubectl rollout history deployment <AppName>
 
Kubectl rollout undo deployment <AppName> –to-revision=2
 
# update the image container for a deployment
kubectl set image <resource type>/<resource name> <container name>=<image name with tag>
kubectl set image deployment/client-deployment client=fhsinchy/notes-client:edge
 

### how to run metric server on kubernetes cluster ###
# metrics server is just a pod that its job is measuring the hardware usage of cluster objects
# show all addons
minikube addons list
# enable metrics server addon for our cluster
minikube addons enable metrics-server

# shows how much memory/cpu each pod is using
kubectl top pod
# shows hardware usage for entire cluster
kubectl top node


# Job
# create a job
kubectl apply -f [job-definition.yml]
# list all jobs
kubectl get job
# describe a job
kubectl describe job [JobName]
# delete a job
kubectl delete -f [job-definition.yml]
kubectl delete job [JobName]


# Rolling Updates
# get the progess of the update status
kubectl rollout status
# get history of the deployment
kubectl rollout history deployment [deplayment-name]
# rollnback the deployment update
kubectl rollout undo [deplayment-name]



# Horizontal Pod Autoscaler HPA
# apply the Scaler
kubectl apply -f [hpa.yml]
# get autoscaler status
kubectl get hpa [name]
# delete autoscaler
kubectl delete -f [hpa.yml]
kubectl delete hpa [name]