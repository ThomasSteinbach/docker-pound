#!/bin/bash

if [[ ! -f /etc/letsencrypt/live/"$DOMAIN"/privkey.pem ]] || [[ ! -f /etc/letsencrypt/live/"$DOMAIN"/fullchain.pem ]]; then
  echo "Missing certificates privkey.pem and fullchain.pem under cat /etc/letsencrypt/live/\"$DOMAIN\"/"
  exit 1
fi

cat /etc/letsencrypt/live/"$DOMAIN"/privkey.pem /etc/letsencrypt/live/"$DOMAIN"/fullchain.pem > /etc/pound/certs/"$DOMAIN".pem
chmod 644 /etc/pound/certs/*
chown www-data:www-data /etc/pound/certs/*

exec pound
