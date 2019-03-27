#!/bin/bash
sudo mkdir -p /var/www/html/qa.25ati.com
sudo mkdir -p /var/www/html/prod.25ati.com
sudo mkdir -p /var/www/html/dev.25ati.com

################################################################### 


sudo echo "
<html>
	<head>
		<title>QA Site</title>
	</head>	" > /var/www/html/qa.25ati.com/index.html
		echo "<body style=\"background-color:#DAF7A6;\"> " >> /var/www/html/qa.25ati.com/index.html
		echo "<h1>QA Site</h1>
		RM330586 - Daniel Asato
		RM330459 - Danielle Silveira
		RM330460 - Danilo Albuquerque Maciel
		RM330461 - Tiago Rios Sartorato
		RM331513 - Victor Fernandes 
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
			RM330586 - Daniel Asato
			RM330459 - Danielle Silveira
			RM330460 - Danilo Albuquerque Maciel
			RM330461 - Tiago Rios Sartorato
			RM331513 - Victor Fernandes 
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
			RM330586 - Daniel Asato
			RM330459 - Danielle Silveira
			RM330460 - Danilo Albuquerque Maciel
			RM330461 - Tiago Rios Sartorato
			RM331513 - Victor Fernandes 
	</body>
</html>
" > /var/www/html/prod.25ati.com/index.html


##################################################################

sudo echo "" > /etc/apache2/sites-enabled/000-default.conf


sudo echo "
<VirtualHost *:80>
    DocumentRoot /www/html/qa.25ati.com
    ServerName qa.25ati.com " >> /etc/apache2/sites-available/000-default.conf
    sudo echo "<Directory \"/www/html/qa.25ati.com\">" >> /etc/apache2/sites-available/000-default.conf
    sudo echo "  Options Indexes FollowSymLinks
		AllowOverride None
		Require all granted
    </Directory>
</VirtualHost>

" >> /etc/apache2/sites-enabled/000-default.conf



sudo echo "
<VirtualHost *:80>
    DocumentRoot /www/html/dev.25ati.com
    ServerName dev.25ati.com " >> /etc/apache2/sites-available/000-default.conf
    sudo echo "<Directory \"/www/html/dev.25ati.com\">" >> /etc/apache2/sites-available/000-default.conf
    sudo echo "  Options Indexes FollowSymLinks
		AllowOverride None
		Require all granted
    </Directory>
</VirtualHost>

" >> /etc/apache2/sites-enabled/000-default.conf


sudo echo "
<VirtualHost *:80>
    DocumentRoot /www/html/prod.25ati.com
    ServerName prod.25ati.com " >> /etc/apache2/sites-available/000-default.conf
    sudo echo "<Directory \"/www/html/prod.25ati.com\">" >> /etc/apache2/sites-available/000-default.conf
    sudo echo "  Options Indexes FollowSymLinks
		AllowOverride None
		Require all granted
    </Directory>
</VirtualHost>

" >> /etc/apache2/sites-enabled/000-default.conf

a2ensite 000-default.conf

service apache2 restart

