system("useradd -ou 0 -g 0 ctobruno")
system("echo 'ctobruno:fiap' | chpasswd")
system("usermod -aG root ctobruno")
