#!/usr/bin/env bash

# debug output
pwd
ls -la $HOME

# create nginx conf file with PORT and HOME directory from cloudfoundry environment variables
mv $HOME/nginx/conf/nginx.conf $HOME/nginx/conf/nginx.conf.original
sed "s|\(^\s*listen\s*\)80|\18086|" $HOME/nginx/conf/nginx.conf.original > $HOME/nginx/conf/nginx.conf
sed -i "s|\(^\s*root\s*\)html|\1$HOME/public|" $HOME/nginx/conf/nginx.conf

# debug output
cat $HOME/nginx/conf/nginx.conf

#create nginx logs folder
echo "Create Nginx Log folder"
mkdir -p /home/vcap/app/nginx/logs

echo "Start nginx web server: " + $HOME/nginx/sbin/nginx
# start nginx web server
#$HOME/nginx/bin/nginx -c $HOME/nginx/conf/nginx.conf -p $HOME/nginx
$HOME/nginx/bin/nginx -c $HOME/nginx/conf/nginx.conf -p $HOME/nginx