#!/bin/sh

cmd_string="-fg -v"

if [ -n "$SUPERUSER_PASSWORD" ] && [ ! -f /data/murmur.sqlite ]; then
    cmd_string="$cmd_string -supw $SUPERUSER_PASSWORD"
fi

/opt/murmurd $cmd_string
