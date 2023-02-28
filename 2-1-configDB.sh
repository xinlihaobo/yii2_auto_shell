#!/bin/bash
#############################################################################
# 功能：
#
# 1. 配置数据库: 登录并创建数据库；
#
# 2. 设置main-local.php配置文件，添加数据库信息；
#
##############################################################################

## step1: 设置MySQL登录信息
dbname='';
username='root';
password='zengfa2004';


echo "数据库名称为： $1";
dbname=$1;
echo -e "dbname: " $1;


## step2: 登录MySQL，进行新建数据操作
mysql -h 127.0.0.1 -u$username -p$password -e \
"CREATE DATABASE IF NOT EXISTS $dbname CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"

echo "$dbname数据库创建成功!";


## step3: 配置main-local.php文件
cat << EOF >> main-local.php
<?php

return [
    'components' => [
        'db' => [
            'class' => 'yii\db\Connection',
            'dsn' => 'mysql:host=localhost;dbname=$dbname',
            'username' => '$username',
            'password' => '$password',
            'charset' => 'utf8',
        ],
        'mailer' => [
            'class' => 'yii\swiftmailer\Mailer',
            'viewPath' => '@common/mail',
            // send all mails to a file by default. You have to set
            // 'useFileTransport' to false and configure a transport
            // for the mailer to send real emails.
            'useFileTransport' => true,
        ],
    ],
];
EOF

echo "main-local.php配置文件生成成功！";


