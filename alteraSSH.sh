#!/bin/bash
read -r -p "Voce tem certeza que quer trocar a porta SSH? [Y/N]" response
if [[ $response == "y" || $response == "Y" ]]
then
  sed -i 's/Port 22/Port 2269/g' /etc/ssh/sshd_config
  echo "SSH Trocada para: 2269."
  sshPort=$( grep "Port" /etc/ssh/sshd_config | head -n 1 )
  echo "Confirmando porta:  $sshPort"
  read -p "Press [Enter] para Continuar ..."
  /etc/init.d/ssh restart
else
  sshPort=$(grep "Port" /etc/ssh/sshd_config  | head -n 1 )
  echo "Porta Mantida em:  $sshPort"
fi
