#!/bin/bash

#[root@sandbox bin]# ifconfig
#enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
#        inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255
#        inet6 fe80::a00:27ff:fe39:183c  prefixlen 64  scopeid 0x20<link>
#        ether 08:00:27:39:18:3c  txqueuelen 1000  (Ethernet)
#        RX packets 38120  bytes 2678286 (2.5 MiB)
#        RX errors 0  dropped 0  overruns 0  frame 0
#        TX packets 56487  bytes 4191700 (3.9 MiB)
#        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

#[root@sandbox bin]# route -n
#Kernel IP routing table
#Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
#0.0.0.0         10.0.2.2        0.0.0.0         UG    1024   0        0 enp0s3
#10.0.2.0        0.0.0.0         255.255.255.0   U     0      0        0 enp0s3


# Find the primary interface and IP then set /etc/hosts
IFACE0=$(route -n | fgrep " 0.0.0.0 " | tail -n1 | awk '{print $NF}')
echo $IFACE0 >> /var/log/sandbox_startup.log
IFACE0_IP=$(facter --json | egrep "ipaddress_$IFACE0" | cut -d\: -f2 | sed 's/\,//g' | sed 's/\"//g'| tr -d ' ')
echo $IFACE0_IP >> /var/log/sandbox_startup.log

echo "127.0.0.1 localhost.localdomain localhost" > /etc/hosts
echo "$IFACE0_IP sandbox.odp.org" >> /etc/hosts


# Restart all the services
for SVC in $(ls /etc/init.d/hadoop*); do
        echo $SVC
        SVCNAME=$(basename $SVC)
        echo $SVCNAME
        service $SVCNAME restart 2>&1 | tee -a /var/log/sandbox_startup.log
done

