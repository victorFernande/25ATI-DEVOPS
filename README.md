![fiap logo](/img/fiap_logo.jpg)

# 25ATI-DEVOPS

## 1. Criar 2 VMs chefclient e chefserver
Setup Inicial, utilizando VMware, instalei 2 VMs de Ubuntu Server 18
Uma chamei de chefclient e outra chefserver

![SetupVM](/img/setupVM.jpg)


Na VM chefclient instalamos o `Docker`, e o `openssh` nas VMs **chefclient** e na **chefserver**.
Por padrão o SSH é atribuído a porta 22, acessamos esse setup inicial por essa porta e vamos criar um arquivo alteraSSH.sh

    touch alteraSSH.sh

e preenche-lo com:

    #!/bin/bash
    read -r -p "Voce tem certeza que quer trocar a porta SSH? [Y/N]" response
    if [[ $response == "y" || $response == "Y" ]]
    then
        sed -i 's/#Port 22/Port 2269/g' /etc/ssh/sshd_config
        echo "SSH Trocada para: 2269."
        sshPort=$( grep "Port" /etc/ssh/sshd_config | head -n 1 )
        echo "Confirmando porta:  $sshPort"
        read -p "Press [Enter] para Continuar ..."
        /etc/init.d/ssh restart
    else
        sshPort=$(grep "Port" /etc/ssh/sshd_config  | head -n 1 )
        echo "Porta Mantida em:  $sshPort"
    fi


e o Executaremos com:

    chmod 700 ./alteraSSH.sh
    sudo ./alteraSSH.sh 
    
Após isso, sua sessão ainda estara fechada na porta 22, para testar é necessário sair da sessão, se tentar conectar a porta **22** a conexão será recusada, então mudando a porta para **2269** a conexão funcionará.    

Após isso na VM **chefclient** executaremos o seguinte comando

    wget https://omnitruck.chef.io/install.sh
    chmod 700 ./install.sh
    sudo ./install.sh


