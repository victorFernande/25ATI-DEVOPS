qaFile = []
qaFile << "<VirtualHost *:80>"
qaFile << "    ServerName qa.25ati.com"
qaFile << "    ServerAdmin webmaster@25ati.com"
qaFile << "    DocumentRoot /var/www/html/qa.25ati.com"
qaFile << "    LogLevel warn"
qaFile << "</VirtualHost>"
out_file = File.new("/etc/apache2/sites-available/qa.conf", "w")
out_file.puts(qaFile)
out_file.close

prodFile = []
prodFile << "<VirtualHost *:80>"
prodFile << "    ServerName prod.25ati.com"
prodFile << "    ServerAdmin webmaster@25ati.com"
prodFile << "    DocumentRoot /var/www/html/prod.25ati.com"
prodFile << "    LogLevel warn"
prodFile << "</VirtualHost>"
out_file = File.new("/etc/apache2/sites-available/prod.conf", "w")
out_file.puts(prodFile)
out_file.close

devFile = []
devFile << "<VirtualHost *:80>"
devFile << "    ServerName dev.25ati.com"
devFile << "    ServerAdmin webmaster@25ati.com"
devFile << "    DocumentRoot /var/www/html/dev.25ati.com"
devFile << "    LogLevel warn"
devFile << "</VirtualHost>"
out_file = File.new("/etc/apache2/sites-available/dev.conf", "w")
out_file.puts(devFile)
out_file.close

Dir.mkdir('/var/www/html/qa.25ati.com') unless Dir.exist?('/var/www/html/qa.25ati.com')
Dir.mkdir('/var/www/html/prod.25ati.com') unless Dir.exist?('/var/www/html/prod.25ati.com')
Dir.mkdir('/var/www/html/dev.25ati.com') unless Dir.exist?('/var/www/html/dev.25ati.com')

qahtml = []
qahtml << "	<html>"
qahtml << "		<head>"
qahtml << "			<title>QA Site</title>"
qahtml << "		</head>	"
qahtml << "			<body style=\"background-color:#DAF7A6;\">" 
qahtml << "			<h1>QA Site</h1>"
qahtml << "			RM330586 - Daniel Asato</br>"
qahtml << "			RM330459 - Danielle Silveira</br>"
qahtml << "			RM330460 - Danilo Albuquerque Maciel</br>"
qahtml << "			RM330461 - Tiago Rios Sartorato</br>"
qahtml << "			RM331513 - Victor Fernandes </br>"
qahtml << "		</body>"
qahtml << "	</html>"

out_file = File.new("/var/www/html/qa.25ati.com/index.html", "w")
out_file.puts(qahtml)
out_file.close

prodhtml = []
prodhtml << "	<html>"
prodhtml << "		<head>"
prodhtml << "			<title>Prod Site</title>"
prodhtml << "		</head>	"
prodhtml << "			<body style=\"background-color:#DAF7A6;\">" 
prodhtml << "			<h1>Prod Site</h1>"
prodhtml << "			RM330586 - Daniel Asato</br>"
prodhtml << "			RM330459 - Danielle Silveira</br>"
prodhtml << "			RM330460 - Danilo Albuquerque Maciel</br>"
prodhtml << "			RM330461 - Tiago Rios Sartorato</br>"
prodhtml << "			RM331513 - Victor Fernandes </br>"
prodhtml << "		</body>"
prodhtml << "	</html>"

out_file = File.new("/var/www/html/prod.25ati.com/index.html", "w")
out_file.puts(prodhtml)
out_file.close

devhtml = []
devhtml << "	<html>"
devhtml << "		<head>"
devhtml << "			<title>dev Site</title>"
devhtml << "		</head>	"
devhtml << "			<body style=\"background-color:#D6EAF8;\">" 
devhtml << "			<h1>dev Site</h1>"
devhtml << "			RM330586 - Daniel Asato</br>"
devhtml << "			RM330459 - Danielle Silveira</br>"
devhtml << "			RM330460 - Danilo Albuquerque Maciel</br>"
devhtml << "			RM330461 - Tiago Rios Sartorato</br>"
devhtml << "			RM331513 - Victor Fernandes </br>"
devhtml << "		</body>"
devhtml << "	</html>"

out_file = File.new("/var/www/html/dev.25ati.com/index.html", "w")
out_file.puts(devhtml)
out_file.close

system("a2ensite qa.conf")
system("a2ensite dev.conf")
system("a2ensite prod.conf")

system("service apache2 restart")