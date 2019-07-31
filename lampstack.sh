#!/bin/bash
sudo add-apt-repository ppa:ondrej/php
sudo apt-get install apache2 mysql-server libapache2-mod-auth-mysql php-mysql mysql-server php libapache2-mod-php php-curl php-gd php-mbstring php-mcrypt php-xml php-xmlrpc
sudo apt-get install mysql-server libapache2-mod-auth-mysql php5-mysql
sudo mysql_install_db
sudo /usr/bin/mysql_secure_installation
mysql -u root -p -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';FLUSH PRIVILEGES;"
sudo systemctl restart apache2
sudo systemctl enable apache2
sudo sed -e 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf > /etc/apache2/apache2.conf
sudo a2enmod rewrite
sudo apache2ctl configtest
sudo systemctl restart apache2
cd /tmp
curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
touch /tmp/wordpress/.htaccess
chmod 660 /tmp/wordpress/.htaccess
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
mkdir -p /tmp/wordpress/wp-content/upgrade
sudo cp -a /tmp/wordpress/. /var/www/html
sudo useradd site
sudo passwd site 
sudo usermod -aG sudo site
sudo chown -R site:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod g+s {} \;
sudo chmod g+w /var/www/html/wp-content
sudo chmod -R g+w /var/www/html/wp-content/themes
sudo chmod -R g+w /var/www/html/wp-content/plugins
sudo sed -e 's/database_name_here/wordpress/g' /var/www/html/wp-config.php > /var/www/html/wp-config.php
sudo sed -e 's/username_here/wordpressuser/g' /var/www/html/wp-config.php >/var/www/html/wp-config.php
sudo sed -e 's/password_here/password/g' /var/www/html/wp-config.php >/var/www/html/wp-config.php
sudo echo "define('FS_METHOD', 'direct');" >> /var/www/html/wp-config.php
