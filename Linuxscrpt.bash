#!/bin/bash
echo "Script uitvoeren..?" ja/nee
read input
if [ "$input" == "nee" ];
then
echo "Sluit de console";
sudo kill terminal
fi;

if [ "$input" == "ja" ];
then
echo "Installatie begint.."

echo "Apache2 en de benodigde assets worden gedownload.."

sudo apt-get install apache2 apache2-doc libexpat1 ssl-cert

echo "Nu wordt MySql client en de benodigde assets worden gedownload.."

sudo apt-get install mysql-server mysql-client

echo "Nu wordt PhP en de benodigde assets worden gedownload.."

sudo apt-get install php php-common libapache2-mod-php php-curl php-gd php-gettext php-imagick php-intl php-mbstring php-mysql php-pear php-pspell php-recode php-xml php-zip

echo "Status van service Apache2 wordt gecheckt.."

sudo service apache2 restart
fi;

echo "Wil je ook Nextcloud installeren?.." ja/nee
read input
if [ "$input" == "nee" ];
then
echo "Sluit de console";
fi;

if [ "$input" == "ja" ];
then
echo "Nextcloud wordt geinstalleerd.."

sudo cd /tmp

sudo wget https://download.nextcloud.com/server/release/nextcloud-16.0.1.zip

sudo unzip nextcloud-16.0.1.zip

sudo mv nextcloud /var/www/html

sudo cd /var/www/html

sudo chown -R www-data:www-data nextcloud

sudo chmod -R 755 nextcloud
fi;

echo "Wil je Fail2Ban installeren?.." ja/nee
read input
if [ "$input" == "nee" ];
then echo "Sluit de console"
fi;

if [ "$input" == "ja" ];
then
echo "Fail2Ban wordt nu geinstalleerd.."

sudo apt-get install fail2ban
fi;

echo "Wil je Fail2Ban nu configuren of later" nu/later
read input
if [ "$input" == "later" ];
fi;

if [ "$input" == "nu" ];
then
sudo nano /etc/fail2ban/jail.conf
fi;

echo "Wil je CertBot intalleren en direct een Certificaat genereren?.." ja/nee
read input
if [ "$input" == "nee" ];
then echo "Sluit de console"
fi;

if [ "$input" == "ja" ];
then
sudo snap install --classic certbot
sudo sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot certonly --apache
sudo certbot renew --dry-run
echo "CertBot is gedownload en ingesteld.."
fi;

echo "Wil je nu de bijpassende Firewall configuratie laden?.." ja/nee
if [ "$input" == "nee" ];
then echo "Sluit de console"
fi;

if [ "$input" == "ja" ];
then
echo "De configuratie wordt geladen.."
sudo iptables -A INPUT -s 172.67.70.5 -j DROP
sudo iptables -A INPUT -s 104.18.156.3 -j DROP
sudo iptables -A INPUT -s 66.254.114.79 -j DROP
sudo iptables -A INPUT -s 66.254.114.41 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 1900 -j DROP
#Port 1900 is van UPNP en dat poort open laten staan kan gevaarlijk zijn
fi;

#Wordt de aanpassing verwerkt in github?

#Je linux machine zou maar corrupt raken
