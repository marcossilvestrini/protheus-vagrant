#!/bin/bash
cd /etc/init.d

echo '[Start Lock Server]'
./totvslockserver start
sleep 5

echo '[Start License Server]'
./totvslicense start
sleep 2

echo '[Start DBAccess Server]'
./totvsdbaccess start
sleep 2

#echo '[Start Broker Server]'

echo '[Start Slave01]'
./totvslave01 start

# echo '[Start Slave02]'
# ./totvslave02 start

# echo '[Start Soap]'
# ./totvssoap start

# echo '[Start Rest]'
# ./totvsrest start
