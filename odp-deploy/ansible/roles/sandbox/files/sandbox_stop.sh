#!/bin/bash

# Stop all the services
for SVC in $(ls /etc/init.d/hadoop*); do
    echo $SVC
    SVCNAME=$(basename $SVC)
    echo $SVCNAME
    service $SVCNAME stop
done

