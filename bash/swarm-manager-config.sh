#!/bin/bash
#  Configures the Swarm cluster in to the given machine .
#  Assuming we will have following arguments passed while executing this bash script
#  1. (Integer) The Index of the VM. 0 will be treated as primary manager vm - where the docker swarm init will be executed
#  2. (string)  The IP address of the primary VM - in Azure this is the private NAT address for the VM (typically 10.0.0.5 for example)
#  3. (string)  The IP address of the current machine (the NAT address)
#  4. (string)  The user name
#  5. (string)  The password  - The password will be replaced later with SSH - for now we are using this

a=$1
b=''
nodeNumber=$a$b
primaryManagerIP=$2
currentManagerIP=$3
userName=$4
userPassword=$5
sshHostName=$userName@$primaryManagerIP

sudo echo "Primary manager IP: $primaryManagerIP"
sudo echo "Current manager IP: $currentManagerIP"
sudo echo "Current VM Index: $nodeNumber"
sudo echo "User: $userName"
sudo echo "Password: $userPassword"
sudo echo "The SSH target is: $sshHostName"

if [ "$nodeNumber" = "0" ]; then
     echo "Initializing (swarm init) the primary swarm manager..."
     sudo docker swarm init
else
     echo "Joining to the swarm as secondary manager..."
     sudo apt-get -qq install sshpass -y
     mynicetoken=$(sudo sshpass -p $userPassword ssh -o StrictHostKeyChecking=no $sshHostName 'sudo docker swarm join-token -q manager')

     while [ -z "$mynicetoken" ]; do
        echo "The token was empty, we will sleep 10 seconds..."
        sleep 10
        mynicetoken=$(sudo sshpass -p $userPassword ssh -o StrictHostKeyChecking=no $sshHostName 'sudo docker swarm join-token -q manager')
     done

     echo "Our Join token: $mynicetoken"
     sudo docker swarm join --token $mynicetoken $primaryManagerIP:2377

     echo "Current node joined as manager..."
fi
                                                                                                                                                      
                                                                                                                                                                   
