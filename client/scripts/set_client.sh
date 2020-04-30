#!/bin/sh

gen_key(){
	if [ -f "/home/user/data/.ssh/ssh_client_$1_key" ]
	then
		echo "Key $1 already exists, skippig."
	else
		echo "Generating key $1:"
		ssh-keygen -q -N '' -t $1 -f /home/user/data/.ssh/ssh_client_$1_key
		cat /home/user/data/.ssh/ssh_client_$1_key.pub
			
		echo "Key $1 generated now"
	fi
	cp /home/user/data/.ssh/ssh_client_$1_key.pub /home/user/pubkeys/ssh_client_$1_key.pub
}

mkdir -p /home/user/data/.ssh
echo "Checking for keys..."
for t in rsa ecdsa ed25519; do
	gen_key $t
done
echo "Checking for keys completed."


echo "Adding keys to ssh-agent"
eval $(ssh-agent)
for k in $(ls /home/user/data/.ssh | grep -v .pub); do
	ssh-add /home/user/data/.ssh/$k
done
ssh-add -l


