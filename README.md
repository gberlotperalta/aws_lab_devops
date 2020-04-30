# AWS LAB DEVOPS
How to create infra, provision and run a ci/cd pipeline in aws

## FIRST STEP
1) Clone this repository
2) goto folder aws_lab_devops
3) run the follwing command: vagrant up
4) once script is done, run: vagrant ssh awsdevops
5) once logged in: configure your aws client by running: aws configure

## SECOND STEP
1) Clone this repository again in linux box.
2) Need to specify the Key Pair in file /terraform/app_name/prod if you want to connect to it.  
4) First create and pem in aws console and later download locally.  
5) copy the file to linux machine  

sudo bash
cd /
cd /aws_devops  
cp G1B4.pem /home/vagrant  
cd /home/vagrant
chmod 400 G1B4.pem

6) Test connectivity by ussing ssh type:  
ssh -i "G1B4.pem" ubuntu@ec2-34-207-172-223.compute-1.amazonaws.com

7) run the following command
cd /home/vagrant/aws_lab_devops
ansible-playbook -i aws_hosts.yml playbook-test.yml 

8) 

Falta crear un IAM para flowlogsrole y hacer que la vpc tengo flowlogrole por defecto

https://medium.com/chrisjerry/architect-using-terraform-dd1ae7da98f4
https://jee-appy.blogspot.com/2018/07/create-aws-infrastructure-with-terraform.html
https://medium.com/@brad.simonin/create-an-aws-vpc-and-subnet-using-terraform-d3bddcbbcb6


https://jee-appy.blogspot.com/2018/07/create-aws-infrastructure-with-terraform.html
