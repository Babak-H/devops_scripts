# first we should have an up and running kubernetes cluster
# then we can use these commands to add prometheus operator helm chart (which includes all needed services) to the cluster
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# update the repository
helm repo update

# create helm chart in its own name-space. so it won't be mixed we the main cluster
kubectl create namespace monitoring

# install the prometheus stack
# -n at the end specifies the name-space to install it
helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring

# show the installed charts
helm ls
kubectl get all -n monitoring

# show the cinfiguration files related to prometheus stack
kubectl get configmap -n monitoring
kubectl get secret -n monitoring

# see the inside of prometheus statefulset file
kubectl describe statefulset prometheus-monitoring-kube-prometheus-prometheus -n monitoring > prom.yml

# # see the inside of prometheus deployment operator
kubectl describe deployment monitoring-kube-prometheus-operator -n monitoring > oper.yml

# configuration file => what endpoint to scrape
# address of applications => expose /metrics endpoints

# make prometheusUI avaialable through port forwarding of its service to localhost
kubectl port-forward svc/monitoring-kube-prometheus-prometheus 9090:9090 -n monitoring &  # 127.0.0.1:9090

# instance => an endpoint you can scrape
# job => collection of instances with same purpose

# make Grafana avaialable through port forwarding of its service to localhost
 kubectl port-forward service/monitoring-grafana 8080:80 -n monitoring  # 127.0.0.1:8080

 # default user/pass for grafana
 # username: admin
 # password: prom-operator

 # prometheus operator extends the Kubernetes API => 
        # we create custom kubernetes resources => 
            # operator takes our custom resources and tells prometheus to reload its alert rules

# apply prometheus alert_rules file
kubectl apply -f alert_rules.yml

# check to see the object is created (shows all existing prometheus rules)
kubectl get PrometheusRule -n monitoring

# we can add "containerstack/cpustress" file docker image to our k8s cluster, to cpu load test and trigger prometheus alerts
# here we run docker image as a pod directly, without writing a yaml config file for it
kubectl run cpu-test --image=containerstack/cpustress -- --cpu 4 --timeout 30s --metric-brief

# looking at the alert_manager UI
kubectl port-forwarding svc/monitoring-kube-prometheus-alertmanager -n monitoring 9093:9093 &   # 127.0.0.1:9093

# this is our original alert manager  configuration file
kubectl get secret alertmanager-monitoring-kube-prometheus-alertmanager-generated -n monitoring -o yaml
 
 # apply the alert manager config file (for sending alert emails)
 # after this users should receive alert emails in case of the alert rules apply
 kubectl apply -f alert-manager-configuration.yml


# to also monitor the redis database inside our cluster we need extra packages to connect prometheus to redis endpoint since prometheus can't directly read redis logs
# here we use redis-exporter helm chart
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
# now install the chart with custom values inside the same namespace as redis-cart 
helm install redis-exporter prometheus-community/prometheus-redis-exporter -f redis-values.yml

# apply redis alert rules file
kubectl apply -f redis-rules.yml


