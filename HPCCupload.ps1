$d=Get-Date -UFormat %Y-%m-%d
$a = [DateTime]::Today.AddDays(-30).ToString("yyyy-MM-dd")

ssh -i C:\Users\cmconnelly\Desktop\NCSU\id_rsa ec2-user@18.191.244.70 "mkdir /var/lib/HPCCSystems/mydropzone/Athlete360/$d;mv /var/lib/HPCCSystems/mydropzone/Athlete360/$a /var/lib/HPCCSystems/mydropzone/A360archive/$a"

$d=Get-Date -UFormat %Y-%m-%d
$a = [DateTime]::Today.AddDays(-30).ToString("yyyy-MM-dd")

scp -i C:\Users\cmconnelly\Desktop\NCSU\id_rsa C:\Users\cmconnelly\Desktop\Athlete360data\*.csv ec2-user@18.191.244.70:/var/lib/HPCCSystems/mydropzone/Athlete360/$d