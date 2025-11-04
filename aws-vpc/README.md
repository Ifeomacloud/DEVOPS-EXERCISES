#  AWS VPC and EC2 Setup Guide

This guide walks you through creating a **custom VPC**, **public subnet**, **internet gateway**, **route table**, **security group**, and launching an **EC2 instance** — step by step.

---

##  Overview

You’ll perform the following:

1. Create a custom **VPC**
2. Create a **Public Subnet**
3. Attach an **Internet Gateway**
4. Configure a **Route Table**
5. Create a **Security Group**
6. Launch an **EC2 Instance**

Each step includes screenshots for visual guidance (place them in the `/screenshots` folder).

---

## **Step 1: Create a Custom VPC**

1. **Login to AWS Console:** [https://console.aws.amazon.com/vpc/](https://console.aws.amazon.com/vpc/)
2. **Navigate:** `VPC Dashboard → Your VPCs → Create VPC`
3. **Configure VPC:**
   - **Name:** `theseedfi-vpc`
   - **IPv4 CIDR block:** `10.1.0.0/16`
   - **IPv6 CIDR block:** None (enable if needed)
   - **Tenancy:** Default
4. Click **Create VPC**



5. **Enable DNS Settings:**
   - Select the VPC (`10.1.0.0/16`) → Actions → **Edit DNS resolution** → Check **Enable** → Save  
   - Actions → **Edit DNS hostnames** → Check **Enable** → Save  

> Enabling DNS ensures EC2 instances can resolve domain names and obtain public hostnames.

---

## **Step 2: Create a Public Subnet**

1. Go to: `VPC Dashboard → Subnets → Create Subnet`
2. Configure:
   - **VPC:** `theseedfi-vpc (10.1.0.0/16)`
   - **Subnet Name:** `public-subnet-1`
   - **Availability Zone:** e.g., `us-east-1a`
   - **IPv4 CIDR block:** `10.1.0.0/24`
3. Click **Create subnet**



4. **Enable Auto-Assign Public IP:**
   - Select the subnet → Actions → **Edit subnet settings**
   - Check **Enable auto-assign public IPv4 address** → Save

---

## **Step 3: Create an Internet Gateway**

1. Go to: `VPC Dashboard → Internet Gateways → Create Internet Gateway`
2. Configure:
   - **Name:** `theseedfi-igw`
3. Click **Create Internet Gateway**



4. **Attach to VPC:**
   - Select the Internet Gateway → Actions → **Attach to VPC**
   - Choose `theseedfi-vpc (10.1.0.0/16)` → **Attach Internet Gateway**

---

## **Step 4: Configure Route Table**

1. **Create Route Table:**
   - Go to `VPC Dashboard → Route Tables → Create Route Table`
   - **Name:** `public-route-table`
   - **VPC:** `theseedfi-vpc (10.1.0.0/16)` → Create

2. **Add Route to Internet Gateway:**
   - Select the route table → **Routes tab → Edit routes**
   - Add:
     - **Destination:** `0.0.0.0/0`
     - **Target:** Internet Gateway (`igw-xxxxxxxx`) → Save routes



3. **Associate with Subnet:**
   - **Subnet Associations tab → Edit subnet associations**
   - Check `public-subnet-1 (10.1.0.0/24)` → Save associations

---

## **Step 5: Create a Security Group**

1. Go to: `EC2 Dashboard → Security Groups → Create Security Group`
2. Configure:
   - **Name:** `theseedfi-web-sg`
   - **Description:** Security group for theseedfi web server
   - **VPC:** `theseedfi-vpc (10.1.0.0/16)`
3. Add **Inbound Rules:**
   | Type | Protocol | Port Range | Source |
   |-------|-----------|-------------|----------|
   | SSH | TCP | 22 | Your IP or `0.0.0.0/0` |
   | HTTP | TCP | 80 | `0.0.0.0/0` |
   | HTTPS | TCP | 443 | `0.0.0.0/0` |

4. Click **Save rules**



---

## **Step 6: Launch the EC2 Instance**

1. Go to: `EC2 Dashboard → Instances → Launch Instances`
2. **Choose AMI:**  
   - Select **Amazon Linux  / Ubuntu**

3. **Instance Type:**  
   - Choose a free-tier eligible type, e.g., `t2.micro`

4. **Key Pair:**  
   - Select an existing key pair or create a new one

5. **Network Settings:**
   - **VPC:** `theseedfi-vpc`
   - **Subnet:** `public-subnet-1`
   - **Auto-assign Public IP:** Enable
   - **Security Group:** Select `theseedfi-web-sg`

6. **Storage:**  
   - Accept default settings or customize as needed

7. **Launch Instance**


---

##  Verification Steps

After launch, verify:
1. EC2 instance shows **running** state  
2. The instance has a **public IPv4 address**  
3. You can SSH into the instance:
   ```bash
   ssh -i your-key.pem ec2-user@<Public-IP>
