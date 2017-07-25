# Docker swarm mode cluster on Azure

### What's in it?

This resource manager template will provision the following resources:

- A virtual network
- An availability set
- 3 virtual machines with the AV set created above. (the numbers, names can be parameterized as per your needs)
- A load balancer (with public port that round-robins to the 3 VMs on port 80. And allows inbound NAT to the 3 machine via port 5000, 5001 and 5002 to ssh port 22).
- Configures 3 VMs as docker swarm mode manager.
- A Virtual machine scale set (VMSS) in the same VNET.
- 3 Nodes that are joined as worker into the above swarm.
- Load balancer for VMSS (that allows inbound NATs starts from range 50000 to ssh port 22 on VMSS)

Hope you find it ineteresting!

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMoimHossain%2Fdocker-swarm-on-azure%2Fmaster%2Fswarm-managers%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FMoimHossain%2Fdocker-swarm-on-azure%2Fmaster%2Fswarm-managers%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>


### Powershell deployment

I have a handy powershell script into the repo (`Go.ps1`) too, which can be used to automate the entire cluster deployment - i.e. can be launched via a automated workflow process (CI/CD for example).

