# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cvoltorb <cvoltorb@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/08 17:35:25 by cvoltorb          #+#    #+#              #
#    Updated: 2020/11/10 02:17:23 by cvoltorb         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get -y install vim nginx openssl mariadb-server wget
RUN apt-get -y install php-fpm php-mysql php-mbstring php-zip php-gd

RUN mkdir /var/www/cvoltorb
RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/ssl.key -out /etc/nginx/ssl/ssl.pem -subj "/C=RU/ST=Moscow/L=Moscow/O=School 21/OU=cvoltorb/CN=cvoltorb.com" ;
WORKDIR /var/www/cvoltorb/
COPY srcs/ .

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
RUN tar -xf phpMyAdmin-5.0.4-all-languages.tar.gz && rm -f phpMyAdmin-5.0.4-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.4-all-languages phpmyadmin
RUN mv config.inc.php ./phpmyadmin/

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -f latest.tar.gz

RUN mv nginx.conf /etc/nginx/sites-available/default
RUN chown -R www-data:www-data *
RUN chmod -R 755 /var/www/*
RUN chmod +x *.sh
EXPOSE 80 443
CMD bash init.sh
