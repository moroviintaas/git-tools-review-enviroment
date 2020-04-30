#!/bin/sh
#client run

SCRIPTS_DIR=/data/scripts
DIR=/home/user
USERNAME=`cat $DIR/data/userinfo | grep username | cut -d: -f 2`

${SCRIPTS_DIR}/set_dns.sh

adduser --group sshusers
adduser --home /home/user/data  --shell /bin/bash $USERNAME &&
    adduser $USERNAME sshusers &&
    echo "$USERNAME:*" | chpasswd 2> /dev/null &&   
    logger -p info -t git Added user $USERNAME &&
	chown $USERNAME:$USERNAME -R /home/user

#chown root:sshusers /usr/bin

echo "ENV=/home/user/data/.shrc" > /home/user/data/.profile
echo "eval $(ssh-agent)" > /home/user/data/.shrc
echo "ssh-add /home/user/.ssh/ssh_client_ecdsa_key" >> /home/user/data/.shrc
echo "echo .shrc" >> /home/user/data/.shrc
echo "echo .profile" >> /home/user/data/.profile
echo "export ENV" >> /home/user/data/.profile

#echo $DNS_ADDR
#/home/user/scripts/set_dns.sh
su - $USERNAME -c ${SCRIPTS_DIR}/set_client.sh

/bin/sh -i

