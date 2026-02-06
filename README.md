#  Terraform – Private EC2 Deployment with Strapi, ALB, NAT Gateway (AWS)

##  Project Overview

This project demonstrates how to design and deploy a **production-like AWS infrastructure** using **Terraform** to run a web application (**Strapi**) on a **private EC2 instance**. The application is securely exposed to the internet using an **Application Load Balancer (ALB)** placed in **public subnets**, while outbound internet access for the private EC2 is enabled via a **NAT Gateway**.

The infrastructure follows cloud best practices:
- Network isolation using **VPC**
- Separation of concerns using **public and private subnets**
- Secure inbound access using **Security Groups**
- Automated provisioning using **Terraform (Infrastructure as Code)**
- Automated instance bootstrapping using **EC2 user_data**
- Optional Bastion Host for secure SSH access to private instances

This setup closely mirrors real-world cloud architecture used in production environments.

---

##  Architecture

Internet
|
[ Application Load Balancer (Public Subnets) ]
|
NAT Gateway (Public Subnet)
|
Private EC2 Instance (Strapi App)


### Components Used:
- **AWS VPC** – Isolated virtual network  
- **Public Subnets (2 AZs)** – For ALB and NAT Gateway  
- **Private Subnet** – For EC2 running Strapi  
- **Internet Gateway** – Allows public subnets to access the internet  
- **NAT Gateway** – Allows private EC2 to access the internet for updates and package installs  
- **Application Load Balancer (ALB)** – Public entry point to the application  
- **Security Groups** – Firewall rules for ALB, EC2, and Bastion  
- **Bastion Host (Optional)** – SSH access to private EC2  
- **Terraform** – Infrastructure provisioning  
- **Strapi (Node.js)** – Backend application  

---

##  Networking Design Explained

### 🔹 VPC
A dedicated VPC is created with a CIDR range to isolate all resources. This ensures that the application runs in a secure and private network environment.

### 🔹 Public Subnets
Two public subnets are created in different Availability Zones (AZs). These host:
- Application Load Balancer  
- NAT Gateway  

Public subnets have a route to the **Internet Gateway**, allowing inbound and outbound internet access.

### 🔹 Private Subnet
The EC2 instance hosting the Strapi application runs inside a private subnet:
- No public IP address  
- Not directly accessible from the internet  
- Inbound traffic only allowed from ALB  
- Outbound internet access via NAT Gateway  

This design significantly improves security.

---

##  Load Balancer (ALB)

The **Application Load Balancer** is deployed in the public subnets and acts as the single public endpoint for users. All incoming HTTP traffic is routed to the private EC2 instance running Strapi on port **1337**.

Benefits:
- No direct exposure of EC2 to the internet  
- Scalable entry point  
- Health checks ensure traffic is only routed to healthy instances  

---

##  NAT Gateway

Since the EC2 instance is private, it cannot directly access the internet. The **NAT Gateway** enables outbound internet access so the instance can:
- Install system updates  
- Install Node.js dependencies  
- Download Strapi packages  

Inbound traffic from the internet is still blocked, preserving security.

---

##  Security Groups

- **ALB Security Group**
  - Allows HTTP (port 80) from anywhere
- **EC2 Security Group**
  - Allows application traffic (port 1337) only from ALB
  - Allows SSH access only from Bastion Host
- **Bastion Security Group**
  - Allows SSH (port 22) from trusted IPs

This enforces the principle of **least privilege**.

---

##  EC2 Bootstrapping (user_data)

The EC2 instance is automatically configured on first boot using **user_data**:
- Installs Node.js
- Creates a Strapi project
- Builds the admin panel
- Starts Strapi in the background

This enables **zero-touch deployment** of the application.

---

##  Project Structure

.
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── main.tf
├── subnet.tf
├── alb.tf
├── security.tf
├── ec2.tf
├── outputs.tf
└── user_data.sh


---

##  How to Deploy

###  Initialize Terraform
```bash
terraform init
```
 Validate Configuration
 ```bash
terraform validate
```
Plan Deployment
```bash
terraform plan
```
Apply Infrastructure
```bash
terraform apply
```
 Accessing the Application
After deployment, Terraform outputs the ALB DNS name:
```bash
http://<alb_dns_name>
```
This URL can be used to access the Strapi application publicly.

