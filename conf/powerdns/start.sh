#!/bin/bash

# pdns-sql.conf
#sed -r -i "s/gmysql-host=.*/gmysql-host=${MYSQL_HOST}/g"           /etc/powerdns/pdns.d/pdns-sql.conf
sed -r -i "s/gmysql-user=.*/gmysql-user=${MYSQL_USER}/g"            /etc/powerdns/pdns.d/pdns-sql.conf
sed -r -i "s/gmysql-password=.*/gmysql-password=${MYSQL_PASS}/g"    /etc/powerdns/pdns.d/pdns-sql.conf
sed -r -i "s/gmysql-dbname=.*/gmysql-dbname=${MYSQL_DB}/g"          /etc/powerdns/pdns.d/pdns-sql.conf
# config.inc.php
sed -r -i "s/MYSQL_USER/${MYSQL_USER}/g"        /var/www/html/poweradmin-2.1.7/inc/config.inc.php
sed -r -i "s/MYSQL_PASS/${MYSQL_PASS}/g"        /var/www/html/poweradmin-2.1.7/inc/config.inc.php
sed -r -i "s/MYSQL_DB/${MYSQL_DB}/g"            /var/www/html/poweradmin-2.1.7/inc/config.inc.php
# sleep 30s
sleep 30
# start service
service rsyslog start && service pdns start && service apache2 start && tail -f /var/log/syslog
#exec /usr/sbin/apachectl -DFOREGROUND
