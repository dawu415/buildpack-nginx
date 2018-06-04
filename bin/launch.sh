#!/usr/bin/env bash

# create nginx conf file with PORT and HOME directory from cloudfoundry environment variables
sed -i "s|\(^\s*listen\s*\)8080|\1$PORT|" $HOME/public/sites-available/default.conf
sed -i "s|\(^\s*root\s*\)html|\1$HOME/public|" $HOME/public/sites-available/default.conf

echo "Start nginx web server: "
# start nginx web server

# Test the configuration and output any results
$HOME/nginx/bin/nginx -t -c $HOME/public/nginx.conf -p $HOME/nginx

# Now run the nginx server with the set configuation
$HOME/nginx/bin/nginx -c $HOME/public/nginx.conf -p $HOME/nginx
