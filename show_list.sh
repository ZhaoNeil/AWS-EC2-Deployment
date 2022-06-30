echo "Start!"
echo "node_id,node_name,ip_local,ip_public,port,extra_info"
for i in {1..3}
do
	private=$(cut ./private_ips.txt -f $i)
	private_ip=${private//./-}
	public=$(cut ./public_ips.txt -f $i)
	let j=${i}-1
	echo "$j|ip-$private_ip|$private|$public|22|user=ubuntu|designations=mon,mgr,osd,mds|device_path=/dev/nvme1n1|job=storage"
done
for i in {4..6}
do
	private=$(cut ./private_ips.txt -f $i)
	private_ip=${private//./-}
	public=$(cut ./public_ips.txt -f $i)
	let j=${i}-1
	echo "$j|ip-$private_ip|$private|$public|22|user=ubuntu|job=client"
done
