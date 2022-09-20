ifconfig  # ip address for SSHing

# master node - ansible controller
# worker node 1 - ansible target

# change name of the vm machine 
sudo nano /etc/hostname

# change name address of vm machine (should have same name as above)
sudo nano /etc/hosts

# we need to install ansible on master node
sudo yum install ansible

ansible --version

# show all the modules
ansible-doc -l

# ansible-playbook <playbook file name>
ansible-playbook playbook.yml
ansible-playbook playbook-pingtest.yaml -i inventory.txt  

# execute ansible commands without playbook file

# ansible <hosts> -a <command>
ansible all -a "/sbin/reboot"

# ansible <hosts> -m <module>
ansible target1 -m ping
ansible all -m ping -i inventory.txt

# role generation inside ansible with ansible-galaxy, this will generate the folder structure, so we won't have to create the folders manually
# run this command inside "roles" folder:
# ansible-galaxy init <role-name>
ansible-galaxy init mysql_db
ansible-galaxy init flask_web

# search through ansible-galaxy for specific role
# ansible-galaxy search <role-name>
ansible-galaxy mongo-db



# How to Encrypt Ansible file with Vault
# File
inventory.txt
# How to encrypt
ansible-vault encrypt inventory.txt  # will encrypt the file

# How to use the inventory with playbook
Ansible-playbook playbook.yml -i inventory.txt -ask-vault-pass # enter the given password when encrypting the file to execute playbook

# do the same but will some python file that will return the password
ansible-playbook playbook.yml -i inventory.txt -vault-password-file ~./vault_pass.py

# view the encrypted file
ansible-vault view inventory.txt

# getting data from dynamic inventory file (for example python script)
ansible-playbook playbook.yml -i inventory.py
# in case of arguments for the python file
ansible-playbook playbook.yml -i inventory --list
# or
ansible-playbook playbook.yml -i inventory.py --host web

# by default all ansible built-in modules are located in /usr/lib/python2.7/dist-packages/modules