#!/bin/bash

cp /etc/resolv.conf /etc/resolv.conf.copy 
sed "s/nameserver/nameserver $DNS_ADDR\nnameserver/1" /etc/resolv.conf.copy > /etc/resolv.conf 
cat /etc/resolv.conf
