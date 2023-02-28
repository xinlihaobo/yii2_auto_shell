#!/usr/bin/bash

#############################################################################
# 功能：
#
# 下载yii2最新框架、配置相关插件、初始化yii2、生成配置文件main-local.php、添加.htaccess
#
##############################################################################

## 1-设置hosts域名
project=$1

echo ">>step1: 设置$1域名正在开始"

echo "127.0.0.1  www.$1.com admin.$1.com api.$1.com images.$1.com">> /etc/hosts

echo ">>step1设置域名$1设置成功！";
echo "--------------------------------------------";
echo -e '\n';


## 2-配置nginx虚拟主机
echo ">>step2: 设置$1配置nginx虚拟主机";


# echo -e "在/etc/nginx/conf.d中生成$1项目配置文件";

cd /etc/nginx/conf.d

cat << EOF >> $1.conf
#
server {
    charset utf-8;
    client_max_body_size 128M;

    listen 80; ## listen for ipv4
    #listen [::]:80 default_server ipv6only=on; ## listen for ipv6

    server_name www.$1.com;

    root        /usr/share/nginx/html/$1.com/frontend/web/;
    index       index.php index.html index.htm;

   # access_log  /usr/share/nginx/html/$1.com/frontend/runtime/logs/frontend-access.log;
   # error_log   /usr/share/nginx/html/$1.com/frontend/runtime/logs/frontend-error.log;


    location / {
        # Redirect everything that isn't a real file to index.php
        try_files \$uri \$uri/ /index.php\$is_args\$args;
    }

    # uncomment to avoid processing of calls to non-existing static files by Yii
    #location ~ \.(js|css|png|jpg|gif|swf|ico|pdf|mov|fla|zip|rar)$ {
    #    try_files \$uri =404;
    #}
    #error_page 404 /404.html;

    # deny accessing php files for the /assets directory
    location ~ ^/assets/.*\.php$ {
        deny all;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        #fastcgi_pass 127.0.0.1:9000;
        fastcgi_pass unix:/run/php/php8.0-fpm.sock;
        try_files \$uri =404;
    }

    location ~* /\. {
        deny all;
    }
}
 
server {
    charset utf-8;
    client_max_body_size 128M;

    listen 80; ## listen for ipv4
    #listen [::]:80 default_server ipv6only=on; ## listen for ipv6

    server_name admin.$1.com;
    root        /usr/share/nginx/html/$1.com/backend/web/;
    
    index       index.php index.html index.htm;

    #access_log  /usr/share/nginx/html/$1.com/frontend/runtime/logs/backend-access.log;
    #error_log   /usr/share/nginx/html/$1.com/frontend/runtime/logs/backend-error.log;

    location / {
        # Redirect everything that isn't a real file to index.php
        try_files \$uri \$uri/ /index.php\$is_args\$args;
    }

    # uncomment to avoid processing of calls to non-existing static files by Yii
    #location ~ \.(js|css|png|jpg|gif|swf|ico|pdf|mov|fla|zip|rar)$ {
    #    try_files \$uri =404;
    #}
    #error_page 404 /404.html;

    # deny accessing php files for the /assets directory
    location ~ ^/assets/.*\.php$ {
        deny all;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        #fastcgi_pass 127.0.0.1:9000;
        fastcgi_pass unix:/run/php/php8.0-fpm.sock;
        try_files \$uri =404;
    }

    location ~* /\. {
        deny all;
    }
}
#
server {
    listen 80;
    listen [::]:80;

    server_name api.$1.com;

    root /usr/share/nginx/html/$1.com/api/web;
    index index.php;

    # rewrite route
    if (!-e \$request_filename){
        rewrite ^/(.*) /index.php last;
    }

    location / {
        try_files \$uri \$uri/ /index.php\$is_args\$args; 
    }

    location ~ ^/assets/.*\.php$ {
        deny all;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        #fastcgi_pass 127.0.0.1:9000;
        fastcgi_pass unix:/run/php/php8.0-fpm.sock;
        try_files \$uri =404;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF
echo ">>step1设置$1配置nginx虚拟主机成功！";
echo "--------------------------------------------";
echo -e '\n';


systemctl stop nginx
systemctl restart nginx

echo ">>step2完成！";
echo "--------------------------------------------";
echo -e '\n';


echo -e "\n=============== ......项目$1域名配置全部完成，可以对$1项目进行访问了！...... ===============\n";
echo "http://www.$1.com"
echo -e '\n\n\n';

