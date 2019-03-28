#!/bin/bash

sudo touch /etc/apache2/sites-available/qa.conf
sudo touch /etc/apache2/sites-available/dev.conf
sudo touch /etc/apache2/sites-available/prod.conf


sudo mkdir -p /var/www/html/qa.25ati.com
sudo mkdir -p /var/www/html/prod.25ati.com
sudo mkdir -p /var/www/html/dev.25ati.com

################################################################### 

sudo echo "
<VirtualHost *:80>
    ServerName qa.25ati.com
    ServerAdmin webmaster@25ati.com
    DocumentRoot /var/www/html/qa.25ati.com
    LogLevel warn
</VirtualHost>
" > /etc/apache2/sites-available/qa.conf


sudo echo "
<VirtualHost *:80>
    ServerName dev.25ati.com
    ServerAdmin webmaster@25ati.com
    DocumentRoot /var/www/html/dev.25ati.com
    LogLevel warn
</VirtualHost>
" > /etc/apache2/sites-available/dev.conf


sudo echo "
<VirtualHost *:80>
    ServerName prod.25ati.com
    ServerAdmin webmaster@25ati.com
    DocumentRoot /var/www/html/prod.25ati.com
    LogLevel warn
</VirtualHost>
" > /etc/apache2/sites-available/prod.conf




sudo echo "
<html>
	<head>
		<title>QA Site</title>
	</head>	" > /var/www/html/qa.25ati.com/index.html
		echo "<body style=\"background-color:#DAF7A6;\"> " >> /var/www/html/qa.25ati.com/index.html
		echo "<h1>QA Site</h1>
		RM330586 - Daniel Asato</br>
		RM330459 - Danielle Silveira</br>
		RM330460 - Danilo Albuquerque Maciel</br>
		RM330461 - Tiago Rios Sartorato</br>
		RM331513 - Victor Fernandes </br>
	</body>
</html>
" >> /var/www/html/qa.25ati.com/index.html

echo "
<html>
	<head>
	<title>DEV Site</title>
	</head> 	" > /var/www/html/dev.25ati.com/index.html
	echo "<body style=\"background-color:##D6EAF8;\"> " >> /var/www/html/dev.25ati.com/index.html
	echo "	<h1>DEV Site</h1>
		RM330586 - Daniel Asato</br>
		RM330459 - Danielle Silveira</br>
		RM330460 - Danilo Albuquerque Maciel</br>
		RM330461 - Tiago Rios Sartorato</br>
		RM331513 - Victor Fernandes </br>
	</body>
</html>
" > /var/www/html/dev.25ati.com/index.html

echo "
<html>
	<head>
	<title>PROD Site</title>
	</head> " > /var/www/html/prod.25ati.com/index.html
	echo "<body style=\"background-color:##FDEBD0;\">  " >> /var/www/html/prod.25ati.com/index.html
	echo "	<h1>PROD Site</h1>
		RM330586 - Daniel Asato</br>
		RM330459 - Danielle Silveira</br>
		RM330460 - Danilo Albuquerque Maciel</br>
		RM330461 - Tiago Rios Sartorato</br>
		RM331513 - Victor Fernandes </br>
	</body>
</html>
" > /var/www/html/prod.25ati.com/index.html


a2ensite qa.conf
a2ensite dev.conf
a2ensite prod.conf

service apache2 restart

