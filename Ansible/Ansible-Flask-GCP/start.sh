### Tasks ###
# deploy 2 compute instances and one database server as VMs
# install required dependancies and applications: mysql, python, flask
# edit mysql config file and bind the address tp internal IP or 0.0.0.0
# create db, users, tables in mysql
# download source code from web server using git
# run services on port 80
# add firewall rule to allow port 80 traffic internally between load balancer and VMs
# create load balancer and add memebers to it



# install ansible on the ansible controller server
pip install apache-libcloud
# next we have to create a service account on GCP to establish secure connection between ansible and google cloud

# save the key file of the service account in a file inside the controller server
touch ansible-service-account.json

# run the instance creation playbook
ansible-playbook create_instance_gcp.yml

# install google cloud CLI on the ansible controller machine
sudo apt-get install apt-transport-https ca-certificates gnupg
# Add the gcloud CLI distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# Import the Google Cloud public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
# Update and install the gcloud CLI
sudo apt-get update && sudo apt-get install google-cloud-cli
# initialize the CLI
gcloud init
# login to your account
# select the current project for Ansible
# configure gcp compute engine to same region as the project

# ssh into the newly created vms
gcloud compute ssh <USERNAME>@web-server-1
# set up the ssh-key pair

# install modules to VMs
ansible-playbook manage-instances -i inventory

# setup firewall rules
ansible-playbook configure-networking -i inventory

# we can run all playbooks from one main one instead of one by one
ansible-playbook main.yml -i inventory


