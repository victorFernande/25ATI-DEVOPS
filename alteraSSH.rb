system("sed -i 's/Port 22/Port 2269/g' /etc/ssh/sshd_config ")
system("sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config ")
system("sshPort=$( grep \"Port\" /etc/ssh/sshd_config | head -n 1 )")
system("echo \"Confirmando porta:  $sshPort\" ")
system("/etc/init.d/ssh restart ")