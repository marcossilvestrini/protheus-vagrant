#!/bin/bash
cd /etc/init.d

echo '[status Lock Server]'
./totvslockserver status
sleep 5

echo '[status License Server]'
./totvslicense status
sleep 5

echo '[status DBAccess Server]'
./totvsdbaccess status
sleep 5

echo '[status Broker Server]'
#./etc/init.d/totvslicense status

echo '[status Slave01]'
./totvslave01 status

echo '[status Slave02]'
./totvslave02 status

echo '[status Soap]'
./totvssoap status

echo '[status Rest]'
./totvsrest status
