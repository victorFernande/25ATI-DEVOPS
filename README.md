![fiap logo](/img/fiap_logo.jpg)

# 25ATI-DEVOPS

## 1. Criar 2 VMs chefclient e chefserver
Setup Inicial, utilizando VMware, instalei 2 VMs de Ubuntu Server 16
Uma chamamos de **chefclient** e outra **chefserver**

![SetupVM](/img/setupVM.jpg)

Ao subir o setup, foi atribuido via DHCP, um IP para cada VM

**10.0.0.12 - Chef Server**

**10.0.0.13 - Chef Client**

## 2. Alterar a porta SSH dos servidores 

### 2.1 SSH Server

Instalamos  o `openssh` nas VMs **chefclient** e na **chefserver**.

    apt-get install openssh-server

Por padrão o SSH é atribuído a porta 22, acessaremos a Server pelo ip **10.0.0.12** porta **22**

![putty22](/img/putty22.jpg)

acessamos esse setup inicial por essa porta e vamos criar um arquivo **alteraSSH.sh**

    touch alteraSSH.sh
    
O editor que iremos utilizar é o nano, para acessá-lo executamos 

    nano alteraSSH.sh

e preenche-lo com:

    #!/bin/bash
    read -r -p "Voce tem certeza que quer trocar a porta SSH? [Y/N]" response
    if [[ $response == "y" || $response == "Y" ]]
    then
        sed -i 's/Port 22/Port 2269/g' /etc/ssh/sshd_config 
        echo "SSH Trocada para: 2269."
        sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
        sshPort=$( grep "Port" /etc/ssh/sshd_config | head -n 1 )
        echo "Confirmando porta:  $sshPort"
        read -p "Press [Enter] para Continuar ..."
        /etc/init.d/ssh restart
    else
        sshPort=$(grep "Port" /etc/ssh/sshd_config  | head -n 1 )
        echo "Porta Mantida em:  $sshPort"
    fi

para salvar **Ctrl+O** e para sair **Ctrl+X**

e o Executaremos com:

    chmod 700 ./alteraSSH.sh
    sudo ./alteraSSH.sh 
    
Após isso, sua sessão ainda estara fechada na porta 22, para testar é necessário sair da sessão, se tentar conectar a porta **22** a conexão será recusada,

![putty22error](/img/putty22error.jpg)

então mudando a porta para **2269** a conexão funcionará.

![putty2269](/img/putty2269.jpg)

### 2.2 SSH Client
Agora precisaremos fazer a configuração do **SSH**  tambem na **chefclient**, para adiantar o processo, executaremos o seguinte comando:

    wget https://raw.githubusercontent.com/victorFernande/25ATI-DEVOPS/master/alteraSSH.sh
    chmod 700 ./alteraSSH.sh
    sudo ./alteraSSH.sh    


## 3. Instalação do ChefClient
Após isso na VM **chefclient** executaremos o seguinte comando

    wget https://omnitruck.chef.io/install.sh
    chmod 700 ./install.sh
    sudo ./install.sh


## 4. Instalação do ChefServer
Agora faremos o donwload na VM **chefserver** o pacote do chef server

    wget https://packages.chef.io/files/stable/chef-server/12.17.33/ubuntu/16.04/chef-server-core_12.17.33-1_amd64.deb

Após o download execute esse comando para efetuar a instalação

    sudo dpkg -i chef-server-core_12.17.33-1_amd64.deb
    
Para gerar os certificados do **Chefserver** é necessário o comando abaixo para atrelar ao IP do servidor 

    echo api_fqdn "\""$(ifconfig ens33 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')"\"" | \
    sudo tee --append /etc/opscode/chef-server.rb > /dev/null

E em seguida execute execute o seguinte comando para configurar o servidor:
    
    sudo chef-server-ctl reconfigure
    
![ChefServerReconfigure](/img/ChefServerReconfigure.jpg)

Este processo deverá demorar alguns minutos.

Ao final, A saida do Comando é algo parecido com isso:    
    
    Chef Client finished, 495/1084 resources updated in 04 minutes 46 seconds
    Chef Server Reconfigured!
    

### 4.1 Instalação de Modulos Adicionais 
O primeiro módulo que iremos instalar é a interface web do servidor, **para garantir a instalação execute uma linha por vez**:
    
    sudo chef-server-ctl install chef-manage
    
    sudo chef-server-ctl reconfigure   
    
    sudo chef-manage-ctl reconfigure

E em Seguida o Módulo de Relatorios **uma linha por vez**: 
    
    sudo chef-server-ctl install opscode-reporting
    
    sudo chef-server-ctl reconfigure
    
    sudo opscode-reporting-ctl reconfigure
    
    
Após isso será possivel acessar via web o console do **Chef Server**

![ChefLogin](/img/ChefLogin.jpg)   

Precisamos tambem Criar um Usuario para Administrar o **Chef Server**
    
    sudo chef-server-ctl user-create victorfernande Victor Fernandes victor.ribeirofernandes@gmail.com '123456' --filename ~/victorF.pem

Após essa criação do usuário, é necessário criar uma Organização 

![ChefOrg](/img/ChefOrg.jpg)

Vamos Chamá-la de **fiap2019** nos 2 campos, Full name e Short Name

### 4.2 Instalação do Chef Development Kit

É um pacote, que possui todas as ferramentas necessárias para trabalhar com o Chef.

Primeiro temos que baixar o pacote do chef DK
    
    wget https://packages.chef.io/files/stable/chefdk/2.4.17/ubuntu/16.04/chefdk_2.4.17-1_amd64.deb 
    
Após o Download executaremos o seguinte comando.
    
    sudo dpkg -i chefdk_2.4.17-1_amd64.deb
    
Ele irá instalar o pacote na nossa VM Chef Server, O output do comando deverá ser semelhante a isso.    

    chefserver@chefserver:~$ sudo dpkg -i chefdk_2.4.17-1_amd64.deb
    Selecting previously unselected package chefdk.
    (Reading database ... 217668 files and directories currently installed.)
    Preparing to unpack chefdk_2.4.17-1_amd64.deb ...
    Unpacking chefdk (2.4.17-1) ...
    Setting up chefdk (2.4.17-1) ...
    Thank you for installing Chef Development Kit!
    chefserver@chefserver:~$


Depois disso, precisamos instalar a linguagem de programação Ruby, na qual o chef à utiliza para a criação de **cookbooks, para aplicar nas maquinas Client do Chef**
    
    sudo apt-get update
    sudo apt-get install -y ruby

![ChefStarter](/img/ChefStarter.jpg)

e depois em `proceed` 

depois disso instale o `FileZilla Client` em Seu Computador

    https://filezilla-project.org/download.php?type=client

Após isso conecte no **Servidor do Chef** usando os campos com o protocolo **SFTP(SSH File Transfer Protocol)**. O SFTP é preferível ao FTP, devido aos seus recursos de segurança. e A capacidade de se transferir aquivos via SSH 

    Host: Endereço IP do Chef server
    Username: chefserver
    Password: fiap
    Port: 2269
   
![Filezilla](/img/Filezilla.jpg)

Após isso, clicamos 2 vezes no arquivo chef-starter.zip que acabamos de baixar e ele é enviado ao servidor.

Então descompactamos o arquivo com 

    unzip chef-starter.zip
    
Depois disso, uma pasta será criada e a acessamos com 
    
    cd chef-repo/
    
Precisamos instalar alguns certificados no servidor, por isso utilizaremos uma ferramenta do Chef chamada **Knife** 

    knife ssl fetch
    
O output do comando será semelhante à:

    WARNING: Certificates from 10.0.0.12 will be fetched and placed in your trusted_cert
    directory (/home/chefserver/chef-repo/.chef/trusted_certs).

    Knife has no means to verify these are the correct certificates. You should
    verify the authenticity of these certificates after downloading.

    Adding certificate for 10_0_0_12 in /home/chefserver/chef-repo/.chef/trusted_certs/10_0_0_12.crt
    
    
## 5 Criando User Privilegiado

### 5.1 Server Chef

criando usuario ctobruno com o mesmo privilegio de root
   
    sudo useradd -ou 0 -g 0 ctobruno

Setando senha ao usuário **ctobruno** -> **fiap**
    
    sudo passwd ctobruno

Adicionando ao grupo root 

    sudo usermod -aG root ctobruno    
    
### 5.2 Server client

criando usuario ctobruno com o mesmo privilegio de root
   
    sudo useradd -ou 0 -g 0 ctobruno

Setando senha ao usuário **ctobruno** -> **fiap**
    
    sudo passwd ctobruno

Adicionando ao grupo root 

    sudo usermod -aG root ctobruno    
    
Após isso, **Na VM ChefServer** force o sincronismo do chef client com o chef server utilzando o bootstrap do knife
 
    knife bootstrap 10.0.0.13:2269 -x ctobruno -P fiap -N Client

![bootstrapSync](/img/bootstrapSync.jpg)

então na interface Web do Chef (10.0.0.12) aparecerá o **chefclient !!!!**

![clientSync](/img/clientSync.jpg)

## 6 Criando Cookbook's 

### 6.1 Instalando Apache 

Acessaremos o **chefserver** e acessaremos o diretorio `chef-repo` e executaremos o seguinte comando 

     chef generate cookbook cookbooks/InstalaApache
     
Depois, para acessar nossa receita, executaremos:

    cd cookbooks/InstalaApache

e Vamos alterar o arquivo com o **nano cookbooks/InstalaApache/recipes/default.rb** 


    package 'apache2' do
        action :install
    end

    service 'apache2' do
        action [:enable,:start]
        supports :reload => true
    end

para salvar **Ctrl+O** e para sair **Ctrl+X**

Depois Faremos upload com esse comando 
    
    knife upload cookbooks/InstalaApache
    
Precisamos alterar o Runlist para Selecionar a receita a ser executada pelo cliente 

![recipe](/img/recipe.jpg)

![task](/img/task.jpg)

Na maquina **chefClient** rodamos o seguinte comando, que num cenário real, ficaria habilitado no cron do servidor Client para que por exemplo de 5 em 5 minutos, a maquina cliente buscaria receitas novas para serem executadas.

    chef-client
    
Ao fazer isso, a maquina client rodará a tarefa a ser executada e o Apache será instalado. acessando o ip do client voce verá que o apache esta instalado.

![apache](/img/apache.jpg)

## 6.2 Configurando o Apache

Agora precisamos configurar o apache. Acessaremos o **chefserver** e acessaremos o diretorio `chef-repo` e executaremos o seguinte comando 

     chef generate cookbook cookbooks/configApache
     
Depois, para acessar nossa receita, executaremos:

    cd cookbooks/configApache

e Vamos alterar o arquivo com o **nano cookbooks/configApache/recipes/default.rb**


    require 'open-uri'

    File.open("/tmp/configApache.sh", "wb") do |saved_file|
            open("https://raw.githubusercontent.com/victorFernande/25ATI-DEVOPS/master/configApache.sh", "rb") do |read_$
            saved_file.write(read_file.read)
        end
    end

    File.chmod(0777, "/tmp/configApache.sh")

    bash "configApache.sh" do
        code "source /tmp/configApache.sh"
    end

para salvar **Ctrl+O** e para sair **Ctrl+X**

Essa receita baixa um codigo shell script desse git, aplica permissão e o executa, configurando o apache e criando virtualhosts e tambem criando as paginas html. 

Depois Faremos upload com esse comando 

    knife upload cookbooks/configApache
    
Precisamos alterar o Runlist para Selecionar a receita a ser executada pelo cliente.

![task1](/img/task1.jpg)

Voltamos a maquina **ChefClient** e executamos o codigo de configuração e criação das paginas no apache.

    sudo chef-client
    
 ao terminar, o apache estará configurado, e acessivel pelos sites
 
    qa.25ati.com
    dev.25ati.com
    prod.25ati.com
    
 ![SetupVM](/img/setupVM.jpg)
 
 
Para testar se as configurações estão corretas, usarei o windows da maquina host para acessar esses sites, mas primeiro é necessario alterar o arquivo de hosts da maquina, então 
 
 ![notepadAdmin](/img/notepadAdmin.jpg)
 
 e abrir o arquivo de hosts localizado em :
 
    C:\Windows\System32\drivers\etc\hosts
 
 
e adicionar as seguintes linhas 

    10.0.0.13		qa.25ati.com
    10.0.0.13		dev.25ati.com
    10.0.0.13		prod.25ati.com

Após isso, ao acessar os sites no navegador:

![qa](/img/qa.jpg)
![dev](/img/dev.jpg)
![prod](/img/prod.jpg)


Fim !



