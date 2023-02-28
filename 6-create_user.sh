#!/usr/bin/bash

#############################################################################
# 功能：
#
# 将create_user.sh脚本复制到本项目中，并执行adminuser数据表的复制
#
##############################################################################

echo "将create_user.sh脚本复制到本项目中"

cp -rf ../step1_init.sh ./1_step_init.sh
cp -rf ../step2_migrate.sh ./2_step_migrate.sh
cp -rf ../step3_create_user.sh  ./3_step_create_user.sh

# cp -rf ../composer.json.aliyun  ./composer.json


echo "将get_doc.sh脚本复制到本项目中"

cp -rf ../other/get_doc.sh   ./