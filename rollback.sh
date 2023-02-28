#!/bin/bash

#############################################################################
# 功能：
#
# 1. 删除数据库操作
# 2. 删除域名操作
# 2. 删除nginx配置操作
#
##############################################################################

echo -e "\n\n[========== 删除数据库和nginx配置文件操作 ==========]\n"

echo -e "[1]. 删除数据库操作！"
echo -e "[2]. 删除域名操作！(todo......)"
echo -e "[3]. 删除nginx配置文件操作！"
echo -e "[4]. 删除website目录！\n\n"

read -p ">>请输入要操作的序号(按'e'退出！): " selects


while [ "$selects" != 'e' ];
do
	case "$selects" in 
		1)  
			echo -e "\n\n====== ...... 正在执行删除数据库操作 ...... ======"
			dbname=''
			username=''
			password=''

			read -p ">> 请输入MySQL登录名(root): " username
			read -p ">> 请输入MySQL登录密码: " password

			# 列出所有数据库
			mysql -h 127.0.0.1 -u$username -p$password -e \
			"SHOW DATABASES;"

			read -p ">> 请输入要删除的数据库名称: " dbname
			echo -e "要删除的数据库为: $dbname"

			mysql -h 127.0.0.1 -u$username -p$password -e \
			"USE $dbname; 
			DROP DATABASE $dbname;"
			
			echo -e "\n>>>>>>>>>>>>>> 数据库$dbname删除完成！ <<<<<<<<<<<<<<\n"
			;;   
		2)  
			echo -e "2. 删除域名操作！"
			;;
		3)
			echo -e "\n\n====== ...... 正在执行删除nginx配置文件操作 ...... ======"
			echo -e "删除/etc/nginx/conf.d中的配置文件\n"

			cd /etc/nginx/conf.d 
			ls -la 

			echo -e "\n"

			read -p ">> 请输入要删除的配置文件: " conf
			sudo rm -rf $conf
			echo -e "\n>>>>>>>>>>>>>> nginx配置文件$conf删除完成！ <<<<<<<<<<<<<<\n"
			ls -la 
			;;
		4)
			echo -e "\n\n====== ...... 正在删除/usr/share/nginx/html中的website目录 ...... ======"
			cd /usr/share/nginx/html
			ls -l

			echo -e "\n"

			read -p ">> 请输入要删除的目录: " website
			sudo rm -rf $website

			echo -e "\n>>>>>>>>>>>>>> $website删除完成！ <<<<<<<<<<<<<<\n"
			ls -l
			;;
		*)
			;;
	esac

	echo -e "\n\n[========== 删除数据库和nginx配置文件操作 ==========]\n"
	echo -e "[1]. 删除数据库操作！"
	echo -e "[2]. 删除域名操作！(todo......)"
	echo -e "[3]. 删除nginx配置文件操作！"
	echo -e "[4]. 删除website目录！\n\n"

	read -p ">>请输入要操作的序号(按'e'退出！): " selects
done


