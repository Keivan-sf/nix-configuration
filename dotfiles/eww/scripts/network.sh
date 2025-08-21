#!/bin/bash

name=$(nmcli c | awk 'FNR == 2{for(i=1;i<=NF-3;i++) printf "%s ",$i; print ""}' || true)
disconnected=$(nmcli g | grep -oE "disconnected")

is_connected=1

if [ $disconnected ] ; then
    is_connected=0
    name=""
else
    is_connected = 1
fi



if [[ "$1" == "--is-connected" ]]; then
    echo $is_connected	
elif [[ "$1" == "--name" ]]; then
	echo $name
fi
