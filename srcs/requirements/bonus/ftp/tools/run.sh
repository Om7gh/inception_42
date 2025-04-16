#!/bin/bash
# Get container IP
IP=$(hostname -i)
# Replace in config
sed -i "s/pasv_address=.*/pasv_address=$IP/" /etc/vsftpd.conf
# Start vsftpd
exec vsftpd /etc/vsftpd.conf
