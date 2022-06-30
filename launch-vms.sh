#!/bin/bash
#Original Author: Jayjeet Chakraborty
#Url: https://github.com/JayjeetAtGithub/skyhook-aws/blob/master/scripts/launch-vms.sh
set -e

count=6
ami=your_ami
instance_type=c5d.4xlarge
security_group_ids=your_security_group_ids
subnet_id=your_subnet_id
key_name=your_key_name
chmod 400 "${key_name}.pem"

spawn_ec2_instances() {
    echo "[+] Launching $count ec2 instances"
    aws ec2 run-instances \
        --image-id $ami \
        --count $count \
        --instance-type $instance_type	 \
        --key-name $key_name \
        --security-group-ids $security_group_ids \
        --subnet-id $subnet_id

    sleep 30

    echo "[+] Gathering Public and Private IPs "
    echo " " > public_ips.txt
    echo " " > private_ips.txt
    aws ec2 describe-instances --output text --query "Reservations[].Instances[].NetworkInterfaces[].Association.PublicIp" > public_ips.txt
    aws ec2 describe-instances --output text --query "Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddress" > private_ips.txt
}

case "$1" in
    -s|--spawn)
    spawn_ec2_instances
    ;;
    *)
    echo "Usage: (-s|--spawn)"
    exit 0
    ;;
esac
