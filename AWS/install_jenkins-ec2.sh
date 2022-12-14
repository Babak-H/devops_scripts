# Step 1 : Connect to your Linux machine
# SetUp JAVA PATH
# Set up Custom TCP port: 8080 in AWS Security Groups

# Step 2: Update Packages
   sudo yum update

# Step 3 : Check Java is installed. If not install java  
   java -version
   sudo yum install java-1.8.0

#    To check and select one out of multiple java versions available
   sudo /usr/sbin/alternatives --config java

# Step 4 : Download latest Jenkins code package
   sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Step 5 : Import a key file from Jenkins-CI to enable installation from the package
   sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# Step 6 : Install Jenkins
   sudo yum install jenkins

# Step 7 : Start jenkins
   sudo service jenkins start

# Step 8 : Access Jenkins server using the public DNS of your ec2 on port 8080
#    http://{ec2-public-dns}:8080
#    example : http://3.89.79.74:8080/

# Note : Here you might have to allow port 8080 in your security group settings for INBOUND traffic
                     

# To start jenkins on a diff port
# Update port number in /etc/sysconfig/jenkins


# To fetch initial admin password for jenkins:
    sudo su -
    cd /var/lib/jenkins/secrets/
    cat initialAdminPassword

# To stop Jenkins
    sudo service jenkins stop

# To uninstall Jenkins
    sudo service jenkins stop
    sudo yum remove jenkins
    sudo rm -r /var/lib/jenkins