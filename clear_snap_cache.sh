#!/bin/bash
sudo -i
echo "Clearing Snap Cache"
cd /var/lib/snapd/cache 
rm ./*

