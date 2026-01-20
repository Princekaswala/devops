#!/bin/bash
#set -e 
#set -x
aws_setup(){
echo "Checking AWS is installed or not .................................."
if  command -v aws &> /dev/null; then
        echo "Aws is Installed"
	ec2instance_config
else
        echo "Aws is not Installed Installing AWS CLI"
	sudo apt update
        echo "Installing AWS CLI into system"
        sudo apt install zip -y
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
	rm -r awscliv2.zip
	rm -r aws
        aws --version
	ec2instance_config
fi
}
aws_creation(){

    INSTANCE_ID=$(aws ec2 run-instances \
        --region "$REGION" \
        --image-id "$AMI_ID" \
        --instance-type "$INSTANCE_TYPE" \
        --key-name "$key_pair" \
        --security-group-ids "$SG_ID" \
        --subnet-id "$SUBNET_ID" \
	--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
        --query 'Instances[0].InstanceId' \
        --output text)

if [ -n "$INSTANCE_ID" ] || [ "$INSTANCE_ID" != "None" ]; then
	echo "Success! Instance ID: $INSTANCE_ID"
	display_ec2info
else
	echo "Error: Instance creation failed."
        exit 1
fi


}
ec2instance_config(){
read -p "Do you you want to Create an EC2 instance or Delete: " user_inp
if [[ $user_inp == "Create" ]] || [[ $user_inp == "create" ]]; then
	read -p "Enter your instance name: " INSTANCE_NAME
	REGION="us-east-1"
	AMI_ID=$(aws ec2 describe-images \
	  --owners 099720109477 \
	  --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" \
	  --query 'sort_by(Images,&CreationDate)[-1].ImageId' \
	  --output text)
	INSTANCE_TYPE="t2.micro"
	read -p "Enter the Key Pair value: " key_pair
	SG_ID=$(aws ec2 describe-security-groups \
	    --filters "Name=group-name,Values=default" \
	    --query "SecurityGroups[0].GroupId" \
	    --output text)

	echo "$SG_ID"
	SUBNET_ID=$(aws ec2 describe-subnets \
	    --filters "Name=default-for-az,Values=true" "Name=availability-zone,Values=us-east-1a" \
	    --query "Subnets[0].SubnetId" \
	    --output text)
	aws_creation
elif [[ $user_inp == "delete" ]] || [[ $user_inp == "Delete" ]]; then
	ec2_deletion
else
	echo "Wrong input given"
	exit 1
fi
}
ec2_deletion(){
	read -p "Enter the instance id to Terminate: " termination
	aws ec2  terminate-instances --instance-ids $termination
}


display_ec2info(){
echo "EC2 instance is being configured ......................."
sleep 10
priv_ip=$(aws ec2   describe-instances \
	--instance-ids $INSTANCE_ID \
	--query "Reservations[*].Instances[*].{Instance:PrivateIpAddress}" \
	--output text )
echo "The Private ip address is $priv_ip "
publ_ip=$(aws ec2 describe-instances \
	--instance-ids $INSTANCE_ID \
	--query "Reservations[*].Instances[*].{Instance:PublicIpAddress}" \
	--output text ) 
echo "The Public  ip address is $publ_ip "
exit 1
}

aws_setup
