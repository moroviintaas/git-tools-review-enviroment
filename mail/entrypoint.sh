#!/bin/bash

#SMTP run
CFGD=/home/configs
CONFIG_DIR=/data/var/configs
ETC_DATA_DIR=/data/etc
SPOOL_DIR=/data/var/spool
#$CFDG/deploy.sh


#addusers

register_users() {
    for line in $(cat $CONFIG_DIR/users); do
        NEW_USER=$(echo $line | cut -f1 -d:)
        NEW_PASSWORD=$(echo $line | cut -f2 -d:)
        adduser --disabled-password --gecos "" --shell /bin/bash --home /home/$NEW_USER $NEW_USER
        echo "$NEW_USER:$NEW_PASSWORD" | chpasswd 
    done
}

#zpisana dane

create_etc_directories(){
    if [ ! -d ${ETC_DATA_DIR}/postfix ]; then
        mv /etc/postfix ${ETC_DATA_DIR}/postfix
    fi

    #cp ${CONFIG_DIR}/postfix/main.cf /etc/postfix/main.cf #${ETC_DATA_DIR}/postfix/main.cf
    
    rm -rf /etc/postfix
    ln -sf ${ETC_DATA_DIR}/postfix /etc/postfix

    rm -f ${ETC_DATA_DIR}/postfix/main.cf
    ln -sf ${CONFIG_DIR}/postfix/main.cf ${ETC_DATA_DIR}/postfix/main.cf
    chmod -R 0775 ${ETC_DATA_DIR}/postfix



    if [ ! -d ${ETC_DATA_DIR}/dovecot ]; then
        mv /etc/dovecot ${ETC_DATA_DIR}/dovecot
    fi
    rm -rf /etc/dovecot
    ln -sf ${ETC_DATA_DIR}/dovecot /etc/dovecot

    rm -rf ${ETC_DATA_DIR}/dovecot/conf.d
    ln -sf ${CONFIG_DIR}/dovecot/conf.d ${ETC_DATA_DIR}/dovecot/conf.d

    rm -f ${ETC_DATA_DIR}/dovecot/dovecot.conf
    ln -sf ${CONFIG_DIR}/dovecot/dovecot.conf ${ETC_DATA_DIR}/dovecot/dovecot.conf

    #cp -rf ${CONFIG_DIR}/dovecot/conf.d /etc/dovecot/
    #cp ${CONFIG_DIR}/dovecot/dovecot.conf /etc/dovecot/dovecot.conf

    chmod -R 0775 ${ETC_DATA_DIR}/dovecot
}

create_spool_directory() {
    if [ ! -d ${SPOOL_DIR}/postfix ]; then
        mv /var/spool/postfix ${SPOOL_DIR}/postfix
    fi
    rm -rf /var/spool/postfix
    ln -sf ${SPOOL_DIR}/postfix /var/spool/postfix
    chmod -R 0775 ${SPOOL_DIR}/postfix
}


global_configs() {
    rm /etc/resolv.conf
    rm /etc/host.conf
    ln -sf ${CONFIG_DIR}/resolv.conf /etc/resolv.conf
    ln -sf ${CONFIG_DIR}/host.conf /etc/host.conf
}


#konfiguracje
register_users
create_spool_directory
create_etc_directories
global_configs
#newaliases

postfix check


service postfix start
service dovecot start

/bin/bash -i
#      #- ./storage/mail/etc/userpass:/data/etc/userpass
