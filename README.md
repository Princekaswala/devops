🚀 AWS EC2 Automation using Shell Scripting & AWS CLI

This project is a menu-driven shell script that automates common AWS EC2 operations using AWS CLI.
It is designed for beginners learning DevOps, AWS, and Linux shell scripting, while following real-world automation practices.

✨ Features

✅ Automatically checks if AWS CLI is installed
✅ Installs AWS CLI v2 if not present
✅ Interactive menu to Create or Delete EC2 instances
✅ Auto-fetches the latest Ubuntu AMI
✅ Automatically selects:
Default VPC
Default Subnet
Default Security Group

✅ User only needs to provide:
1. Instance name
2. Key pair name

✅ Displays Public & Private IP addresses after instance creation
✅ Allows safe EC2 termination using instance ID
✅ Fully automated using AWS CLI + Bash

🧠 How the Script Works
1️⃣ AWS CLI Check
Verifies whether AWS CLI is installed
Installs AWS CLI v2 automatically if missing
2️⃣ User Choice
The script asks:
Do you want to Create or Delete an EC2 instance?
3️⃣ Create EC2 Instance
Fetches the latest Ubuntu AMI dynamically
Uses default networking resources
Launches a t2.micro instance
Displays:
Private IP
Public IP (ready to connect)
4️⃣ Delete EC2 Instance
Prompts for instance ID
Terminates the instance safely using AWS CLI
📦 Prerequisites

Before running the script, make sure:
Linux system (Ubuntu / Debian recommended)
AWS account
IAM user with EC2 permissions
AWS credentials configured using:
aws configure

🚀 How to Use
git clone https://github.com/Princekaswala/devops.git
cd devops
chmod +x aws_cli.sh
./aws_cli.sh
Follow the on-screen instructions.

🛠 Technologies Used
Shell Scripting (Bash)
AWS CLI
AWS EC2
JMESPath
Git & GitHub
Linux

🎯 Learning Outcomes
This project helped me understand:
AWS EC2 lifecycle
AWS CLI automation
Bash functions & control flow
Error handling in shell scripts
Real-world DevOps scripting mindset

🌱 Who Is This For?
✔ DevOps beginners
✔ AWS learners
✔ Linux & Shell scripting learners
✔ Students & freshers exploring cloud automation

🤝 Contributions
Feel free to:
Fork the repository
Improve the script
Add new features
Raise issues or suggestions
Learning is better when shared 🚀

⭐ Support
If you find this useful:
Give the repo a ⭐
Share feedback
Suggest improvements
📌 Repository Link: 
🔗 https://github.com/Princekaswala/devops
