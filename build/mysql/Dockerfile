# imagem default
FROM ubuntu:16.04
MAINTAINER Evandro Couto "vandocouto@gmail.com"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install iputils-ping rsyslog vim ifstat net-tools curl wget apt-utils tzdata telnet mariadb-server mytop -y && \
    rm /etc/localtime && \
    ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

WORKDIR /

COPY conf/mysql/start.sh            /
COPY conf/mysql/my.cnf              /etc/mysql/
COPY conf/mysql/pdns.sql            /


