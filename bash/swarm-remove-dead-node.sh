#!/bin/bash
#  Removes dead nodes form the swarm - as VMSS will leave some dead VM replica

#  You can also use this code during worker script extensions are executed:
# For example:
# sudo sshpass -p $userPassword ssh -o StrictHostKeyChecking=no $sshHostName 'docker node rm -f $(docker node ls --format "{{.ID}} {{.Status}}" | grep -i "down"  | awk "{print \$1}")'

echo "Removing dead workers..."

docker node rm -f $(docker node ls --format "{{.ID}} {{.Status}}" | grep -i 'down'  | awk "{print \$1}")

echo "Removing dead workers...completed"
