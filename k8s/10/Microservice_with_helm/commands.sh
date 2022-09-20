helm create microservice  # generates all base files needed for a helm chart

# makes sure the syntaxt of the values file is correct
helm template -f values/email-service-values.yml microservice  
# checks the yaml file's syntaxt
helm lint -f values/email-service-values.yml microservice

# install the service into the microservice cluster
# repeat it for each of services
helm install -f values/email-service-values.yml emailservice microservice

# same as above, but this one injects values to kubernetes cluster temporarily to make sure it works fine
helm install --dry-run -f values/redis-values.yml redis

# shows all microservices running
helm ls

# unistall helm services
helm uninstall emailservice
helm uninstall redis-cart

# install helmfile tool
brew install helmfile

# deploy helm charts via helmfile
helmfile sync

# shows all the applied charts
helmfile list

# delete all the service
helmfile destroy





