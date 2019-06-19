ssh -i C:\Users\cmconnelly\Desktop\NCSU\id_rsa ec2-user@18.191.244.70 "$d=Get-Date -UFormat %Y-%m-%d;mkdir /var/lib/HPCCSystems/mydropzone/Athlete360/$d"

$d=Get-Date -UFormat %Y-%m-%d

scp -i C:\Users\cmconnelly\Desktop\NCSU\id_rsa C:\Users\cmconnelly\Desktop\Athlete360data\*.csv ec2-user@18.191.244.70:/var/lib/HPCCSystems/mydropzone/Athlete360/$d