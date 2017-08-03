# imagem default
FROM ubuntu:16.04
MAINTAINER Evandro Couto "vandocouto@gmail.com"

RUN apt-get update

COPY conf/powerdns/pdns.list                /etc/apt/sources.list.d/
COPY conf/powerdns/pdns                     /etc/apt/preferences.d/

RUN apt-get install -y curl sudo && curl https://repo.powerdns.com/FD380FBB-pub.asc | sudo apt-key add -

RUN apt-get clean && apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install iputils-ping apache2-bin apache2 gettext libapache2-mod-php7.0 php7.0 php7.0-common php7.0-curl php7.0-dev php7.0-gd php-pear php7.0-imap php7.0-mysql php7.0-xmlrpc php7.0-mcrypt \
    dnsutils rsyslog pdns-server pdns-backend-mysql vim ifstat net-tools curl wget apt-utils telnet tzdata mariadb-client -y && \
    rm /etc/localtime && \
    ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    rm /etc/powerdns/pdns.d/* && \
    wget http://downloads.sourceforge.net/project/poweradmin/poweradmin-2.1.7.tgz -P /opt && \
    rm /var/www/html/* && \
    tar -xvf /opt/poweradmin-2.1.7.tgz -C /var/www/html/ && \
    a2dissite 000-default.conf && \
    pear install DB && \
    pear install pear/MDB2#mysql && \
    a2enmod rewrite && \
    a2enmod authz_host && \
    a2enmod alias

WORKDIR /

COPY conf/powerdns/start.sh            /
COPY conf/powerdns/pdns-sql.conf       /etc/powerdns/pdns.d/
COPY conf/powerdns/.htaccess           /var/www/html/poweradmin-2.1.7/
COPY conf/powerdns/config.inc.php      /var/www/html/poweradmin-2.1.7/inc/config.inc.php
COPY conf/powerdns/powerdns.conf       /etc/apache2/sites-available/


RUN a2ensite powerdns.conf && \
    mv /var/www/html/poweradmin-2.1.7/install/ /var/www/html/poweradmin-2.1.7/install-old
