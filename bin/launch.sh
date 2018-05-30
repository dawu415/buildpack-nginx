#!/usr/bin/env bash

# debug output
pwd
ls -la $HOME/app/public

# create nginx conf file with PORT and HOME directory from cloudfoundry environment variables
#mv $HOME/public/nginx.conf $HOME/nginx/public/nginx.conf.original
sed -i "s|\(^\s*listen\s*\)8080|\1$PORT|" $HOME/app/public/sites-available/default
sed -i "s|\(^\s*root\s*\)html|\1$HOME/public|" $HOME/app/public/sites-available/default

# debug output
#cat $HOME/nginx/conf/nginx.conf

echo "Start nginx web server: "
# start nginx web server
#$HOME/nginx/bin/nginx -t -c $HOME/nginx/conf/nginx.conf -p $HOME/nginx
$HOME/nginx/bin/nginx -t -c $HOME/app/public/nginx.conf -p $HOME/nginx
$HOME/nginx/bin/nginx -c $HOME/app/public/nginx.conf -p $HOME/nginx

ls -la $HOME/app/public
#echo "Nginx Started" + $HOcd,ME/nginx/bin/nginx -c $HOME/nginx/conf/nginx.conf -p $HOME/nginx
