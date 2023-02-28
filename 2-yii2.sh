#!/usr/bin/bash

#############################################################################
# 功能：
#
# 1、下载yii2最新框架、配置相关插件、初始化yii2、生成配置文件main-local.php、添加.htaccess
# 2、进入新框架目录
# 3、初始化项目，执行./init_auto(项目自生成yii修改几行代码，让它不交互，自操作)
# 4、将脚本生成的main-local.php文件复制到./common/config/main-local.php
# 5、添加.htaccess
#
##############################################################################


## step1: 安装yii2最新版框架
echo ">>step1: 安装yii2最新版框架，项目名称为$1"

composer create-project --prefer-dist yiisoft/yii2-app-advanced $1



echo ">>step1: 安装yii2最新版框架操作完成！";
echo "--------------------------------------------";
echo -e '\n';


echo ">>step2: 为项目$1安装相关插件";

## 注意: 进入了新生成的框架目录，注意路径切换
cd $1

composer require kartik-v/yii2-widget-datetimepicker "*"
composer require kartik-v/yii2-widget-datepicker "@dev"
composer require "hail812/yii2-adminlte3=~1.1"
composer require kartik-v/yii2-markdown "dev-master"
composer require "rmrevin/yii2-fontawesome:~3.5"
composer require --prefer-dist yiisoft/yii2-imagine

composer update

echo ">>step2: 安装相关插件操作完成！";
echo "--------------------------------------------";
echo -e '\n';


echo ">>step3: 初始化yii2";
cp ../other/init_auto ./
./init_auto
rm -rf init_auto

echo ">>step3: 初始化yii2操作完成！";
echo "--------------------------------------------";
echo -e '\n';


echo ">>step4: 生成配置文件main-local.php，并复制到./common/config/main-local.php";
dbname=$1;
../2-1-configDB.sh $dbname
mv ./main-local.php ./common/config/main-local.php

# ./yii migrate todo.................................................

echo ">>step4: 操作完成！";
echo "--------------------------------------------";
echo -e '\n';


echo ">>step5: 添加.htaccess"
cp -rf ../other/htaccess/.gitignore ./
cp -rf ../other/htaccess/.htaccess ./frontend/web
cp -rf ../other/htaccess/.htaccess ./backend/web

echo ">>step5: 添加.htaccess操作完成！";
echo "--------------------------------------------";
echo -e '\n';

### 当前路径还在本项目中
