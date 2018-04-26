#!/usr/bin/env bash

# debug output
pwd
ls -la $HOME

# create nginx conf file with PORT and HOME directory from cloudfoundry environment variables
mv $HOME/nginx/conf/nginx.conf $HOME/nginx/conf/nginx.conf.original
sed "s|\(^\s*listen\s*\)80|\1$PORT|" $HOME/nginx/conf/nginx.conf.original > $HOME/nginx/conf/nginx.conf
sed -i "s|\(^\s*root\s*\)html|\1$HOME/public|" $HOME/nginx/conf/nginx.conf

# debug output
#cat $HOME/nginx/conf/nginx.conf

echo "Start nginx web server: "
# start nginx web server
$HOME/nginx/bin/nginx -c $HOME/nginx/conf/nginx.conf -p $HOME/nginx

cat /home/vcap/app/nginx/logs/error.log
ls -la $HOME/public
#echo "Nginx Started" + $HOME/nginx/bin/nginx -c $HOME/nginx/conf/nginx.conf -p $HOME/nginx
