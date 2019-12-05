#!/bin/bash
oldIp=`cat oldIp.txt 2> temp.txt`
if [ -z "$oldIp" ]
then
	oldIp='0.0.0.0'
fi
wget https://mon-ip.io/ 2> temp.txt
rm temp.txt
sed -n 's/.*\([0-9][0-9]\{1,2\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\).*/\1/p' index.html > ip.txt
newIp=`cat ip.txt`
rm ip.txt
rm index.html
if [ $newIp != $oldIp ]
then
	date -u +"%Y-%m-%dT%H:%M:%S" >> log.txt
	echo "	IP =$newIp" >> log.txt
	echo "Subject: ip= $newIp" | sendmail ramzy.chbl@gmail.com
fi
echo "$newIp" > oldIp.txt

