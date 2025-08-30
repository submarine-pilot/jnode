#!/bin/bash -e

if [ ! -d "/data/config" ]; then
    mkdir -p "/data/config"
    cp -f /app/docs/config/* "/data/config/"
fi
[ -d "/data/db" ] || mkdir -p "/data/db"
[ -d "/data/files" ] || mkdir -p "/data/files"
[ -d "/data/inbound/troubleshooting" ] || mkdir -p "/data/inbound/troubleshooting"
[ -d "/data/log/old" ] || mkdir -p "/data/log/old"
if [ ! -d "/data/nodelist" ]; then
    mkdir -p "/data/nodelist"
    cp -f /app/docs/nodelist/* "/data/nodelist/"
fi
[ -d "/data/point" ] || mkdir -p "/data/point"
[ -d "/data/tmp" ] || mkdir -p "/data/tmp"
[ -d "/data/www" ] || mkdir -p "/data/www"

java -Xms128m -Xmx512m -server \
    -Djava.awt.headless=true \
    -Dfile.encoding=UTF-8 \
    -Djava.net.preferIPv6Addresses=false \
    -cp "/app/lib/*" \
    jnode.main.Main "/data/config/jnode.conf"
