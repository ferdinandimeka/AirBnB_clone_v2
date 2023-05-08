Skip to content
Search or jump to…
Pull requests
Issues
Codespaces
Marketplace
Explore
 
@ferdinandimeka 
Dr-MarcusI
/
AirBnB_clone_v2
Public
Fork your own copy of Dr-MarcusI/AirBnB_clone_v2
Code
Issues
Pull requests
Actions
Projects
Security
Insights
Beta Try the new code view
AirBnB_clone_v2/0-setup_web_static.sh
@Denatkins
Denatkins AirBnB
Latest commit a7bc9dc on Jan 2
 History
 1 contributor
Executable File  38 lines (30 sloc)  880 Bytes
 

#!/usr/bin/env bash
# Sets up a web server for deployment of web_static.

apt-get update
apt-get install -y nginx

mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
echo "Holberton School" > /data/web_static/releases/test/index.html
ln -sf /data/web_static/releases/test/ /data/web_static/current

chown -R ubuntu /data/
chgrp -R ubuntu /data/

printf %s "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm;
    location /hbnb_static {
	alias /data/web_static/current;
	index index.html index.htm;
    }
    location /redirect_me {
	return 301 http://cuberule.com/;
    }
    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}" > /etc/nginx/sites-available/default

service nginx restart
Footer
© 2023 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
AirBnB_clone_v2/0-setup_web_static.sh at master · Dr-MarcusI/AirBnB_clone_v2
