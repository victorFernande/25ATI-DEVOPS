#!/bin/bash


sudo mkdir -p /var/www/qa.25ati.com
sudo mkdir -p /var/www/prod.25ati.com
sudo mkdir -p /var/www/dev.25ati.com



################################################################### 


echo "
<html>
	<head>
	<title>QA Site</title>
	</head>
	<body style="background-color:#DAF7A6;">
		<h1>QA Site</h1>
			RM330586 - Daniel Asato
			RM330459 - Danielle Silveira
			RM330460 - Danilo Albuquerque Maciel
			RM330461 - Tiago Rios Sartorato
			RM331513 - Victor Fernandes 
	</body>
</html>
" > /var/www/qa.25ati.com/index.html

echo "
<html>
	<head>
	<title>DEV Site</title>
	</head>
	<body style="background-color:##D6EAF8;">
		<h1>DEV Site</h1>
			RM330586 - Daniel Asato
			RM330459 - Danielle Silveira
			RM330460 - Danilo Albuquerque Maciel
			RM330461 - Tiago Rios Sartorato
			RM331513 - Victor Fernandes 
	</body>
</html>
" > /var/www/dev.25ati.com/index.html

echo "
<html>
	<head>
	<title>PROD Site</title>
	</head>
	<body style="background-color:##FDEBD0;">
		<h1>PROD Site</h1>
			RM330586 - Daniel Asato
			RM330459 - Danielle Silveira
			RM330460 - Danilo Albuquerque Maciel
			RM330461 - Tiago Rios Sartorato
			RM331513 - Victor Fernandes 
	</body>
</html>
" > /var/www/prod.25ati.com/index.html


##################################################################

echo "" > /etc/apache2/sites-enabled/000-default.conf


echo "
<VirtualHost *:80>
    DocumentRoot /www/qa.25ati.com
    ServerName qa.25ati.com
    <Directory "/www/qa.25ati.com">
        Require all granted
    </Directory>
</VirtualHost>

" >> /etc/apache2/sites-enabled/000-default.conf



echo "
<VirtualHost *:80>
    DocumentRoot /www/dev.25ati.com
    ServerName dev.25ati.com
    <Directory "/www/dev.25ati.com">
        Require all granted
    </Directory>
</VirtualHost>

" >> /etc/apache2/sites-enabled/000-default.conf


echo "
<VirtualHost *:80>
    DocumentRoot /www/prod.25ati.com
    ServerName prod.25ati.com
    <Directory "/www/prod.25ati.com">
        Require all granted
    </Directory>
</VirtualHost>

" >> /etc/apache2/sites-enabled/000-default.conf

service apache2 restart

