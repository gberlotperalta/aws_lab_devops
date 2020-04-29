# AWS LAB DEVOPS
How to create infra, provision and run a ci/cd pipeline in aws

1) Need to specify the Key Pair in file /terraform/app_name/prod if you want to connect to it.  
2) First create and pem in aws console and later download locally.  
3) copy the file to linux machine  

sudo bash
cd aws_devops  
cd /share  
cp G1B4.pem /home/vagrant  
cd /home/vagrant
chmod 400 G1B4.pem

3) To connect by ussing ssh type:  
ssh -i "G1B4.pem" ubuntu@ec2-3-83-135-104.compute-1.amazonaws.com



Falta crear un IAM para flowlogsrole y hacer que la vpc tengo flowlogrole por defecto

https://medium.com/chrisjerry/architect-using-terraform-dd1ae7da98f4
https://jee-appy.blogspot.com/2018/07/create-aws-infrastructure-with-terraform.html
https://medium.com/@brad.simonin/create-an-aws-vpc-and-subnet-using-terraform-d3bddcbbcb6

