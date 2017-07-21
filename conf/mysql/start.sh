#!/bin/bash


service rsyslog start && service mysql start

# MySQL
echo "select User from mysql.user where User='powerdns'"  | mysql | grep -i powerdns
if [ $? -ne 0 ]; then
    mysql -e "GRANT ALL PRIVILEGES on powerdns.* TO ${MYSQL_USER}@'%' IDENTIFIED BY '${MYSQL_PASS}'"
    mysql -e "GRANT ALL PRIVILEGES on *.* TO replica@'%' IDENTIFIED BY '${MYSQL_PASS_REP}'"
    POSITION=$( echo "show master status\G" | mysql | grep -i Position | cut -d ":" -f 2 | cut -c2-)
    BINLOG=$( echo "show master status\G" | mysql | grep -i File | cut -d ":" -f 2 | cut -c2-)
    mysql -e "change master to master_host='${MYSQL_IPINST}',master_user='replica',master_password='${MYSQL_PASS_REP}',master_log_file='${BINLOG}',master_log_pos=${POSITION}"
    mysql -e "start slave"
    mysql -e "flush privileges"
fi

tail -f /var/log/syslog