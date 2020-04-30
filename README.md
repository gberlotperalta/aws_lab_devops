# AWS LAB DEVOPS
How to create infra in AWS with terraform and provision the created ec2 instance with ansible (by using command line and ssm)

Terraform will create:  
1 vpc  
1 internet gateway  
2 subnet (1 public and 1 private )  
2 routes (1 per subnet)  
1 security group (for ssh, http and https)  
1 nacl  
1 IAM role for ssm  

## PREREQUISITES
You need to have these programs in place:
-  [Vagrant](https://www.vagrantup.com/downloads.html): download the proper package for your operating system and architecture (Click on Windows 64-bit link). 
-  [VirtualBox](https://www.virtualbox.org/wiki/Downloads): by downloading, you agree to the terms and conditions of the respective license. (Click on Windows hosts link)  
- Be sure VT-x is enabled in your Bios.

**Notes:**
- Follow default installation, by clicking on next, next, next, etc.
- After the software was installed, restart your computer. Once your system is back, open a command prompt and be sure that the following command is working: vagrant -v.


## FIRST STEP (creating ubuntu server that will be used to create the infra in aws and also to provision the software)

- Fork the repository
- Clone this repository
- goto folder aws_lab_devops
- run the follwing command: **vagrant up**
![Server was created with vagrant in virtual box](./images/image01.png)  
**FIGURE 3: You can check the progress also by opening Oracle VM Virtual Box Manager**
- once script is done, you can connect to the VM by using the following command: **vagrant ssh awsdevops**
- once logged in: configure your aws client by running: **aws configure**

## SECOND STEP
- Clone this repository again in linux box. 
- Need to specify the Key Pair in file /terraform/app_name/prod if you want to connect to it. 
- First create and pem in aws console and later download locally.  
- Copy the file to linux machine  


## CREATING INFRA

- Run the following commands.

sudo bash  
cd /aws_devops    
cp <Your_Pem_File_Name>.pem /home/vagrant  
cd /home/vagrant  
chmod 400 <Your_Pem_File_Name>.pem  

- Test connectivity by ussing ssh type:  
ssh -i "G1B4.pem" ubuntu@ec2-34-207-172-223.compute-1.amazonaws.com

- Run the following command
cd /home/vagrant/aws_lab_devops
ansible-playbook -i aws_hosts.yml playbook-test.yml 

#PROVISIONING USING AWS SSM
By default aws ssm agent is installed in ubuntu 18.04 lts. In case you find some issues you can find more details [here](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-manual-agent-install.html#agent-install-ubuntu)  
Finally, it's pending to install ansible on the EC2 instance in order to have all the the mandatory requirements. (Remember that the IAM role for SSM was created when we run the terraform scritps).
To do that run the following commands:


sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt-get install ansible -y


Ver testansible role.



Falta crear un IAM para SSM y hacer que la vpc tengo flowlogrole por defecto

https://medium.com/chrisjerry/architect-using-terraform-dd1ae7da98f4
https://jee-appy.blogspot.com/2018/07/create-aws-infrastructure-with-terraform.html
https://medium.com/@brad.simonin/create-an-aws-vpc-and-subnet-using-terraform-d3bddcbbcb6
https://jee-appy.blogspot.com/2018/07/create-aws-infrastructure-with-terraform.html
