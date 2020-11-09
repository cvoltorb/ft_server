#!/bin/bash

service mysql start
service php7.3-fpm start
service nginx start

echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
echo "CREATE USER 'cvoltorb'@'localhost' IDENTIFIED BY 'cvoltorb'"| mysql -u root --skip-password
echo "GRANT ALL ON *.* TO 'cvoltorb'@'localhost' IDENTIFIED BY 'cvoltorb' WITH GRANT OPTION;"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password

bash
