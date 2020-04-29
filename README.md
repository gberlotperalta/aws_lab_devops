# AWS LAB DEVOPS
How to create infra, provision and run a ci/cd pipeline in aws

1) Need to specify the Key Pair in file /terraform/app_name/prod if you want to connect to it.  
2) First create and pem in aws console and later download locally.  
3) copy the file to linux machine  

sudo bash
cd /
cd /aws_devops  
cp G1B4.pem /home/vagrant  
cd /home/vagrant
chmod 400 G1B4.pem

3) Test connectivity by ussing ssh type:  
ssh -i "G1B4.pem" ubuntu@ec2-34-207-172-223.compute-1.amazonaws.com

4) run the following command
cd /home/vagrant/aws_lab_devops
ansible-playbook -i aws_hosts.yml playbook-test.yml 

5) 

Falta crear un IAM para flowlogsrole y hacer que la vpc tengo flowlogrole por defecto

https://medium.com/chrisjerry/architect-using-terraform-dd1ae7da98f4
https://jee-appy.blogspot.com/2018/07/create-aws-infrastructure-with-terraform.html
https://medium.com/@brad.simonin/create-an-aws-vpc-and-subnet-using-terraform-d3bddcbbcb6


https://jee-appy.blogspot.com/2018/07/create-aws-infrastructure-with-terraform.html
