#!/bin/bash
cd /etc/init.d

echo '[status Lock Server]'
./totvslockserver status

echo '[status License Server]'
./totvslicense status

echo '[status DBAccess Server]'
./totvsdbaccess status

# echo '[status Broker Server]'
# ./etc/init.d/totvslicense status

echo '[status Slave01]'
./totvslave01 status

# echo '[status Slave02]'
# ./totvslave02 status

# echo '[status Soap]'
# ./totvssoap status

# echo '[status Rest]'
# ./totvsrest status
