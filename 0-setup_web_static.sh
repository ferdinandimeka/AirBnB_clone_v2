#!/usr/bin/env bash
# setup server for deployment web_static
apt-get upgrade -y
apt-get update
apt-get -y install nginx
ufw allow 'Nginx HTTP'
mkdir -p /data/web_static/{releases/test, shared}
echo "<html>
    <head>
    </head>
    <body>
        Holberton School
    </body>
</html>" > /data/web_static/releases/test/index.html
ln -fs /data/web_static/releases/test /data/web_static/current
chown -R ubuntu:ubuntu /data
sed -i '/listen 80 default_server/ a\\tlocation /hbnb_static/{\n alias /data/web_static/current;\n\t\}\n' /etc/nginx/sites-available/default
service nginx restart
exit (0)
