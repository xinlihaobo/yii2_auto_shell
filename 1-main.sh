#!/usr/bin/bash

#######################################################################
# 主配置脚本，调用其它各子功能脚本
#
#
# 子功能脚本如下：
# 1. main.sh主功能脚本
# 2. yii2框架及相关生成(2-yii2.sh)
# 3. 生成api模块
# 4. 生成文件上传目录
# 5. 配置AdminLte3后台
# 6. 将create_user.sh脚本复制到本项目中，并执行adminuser数据表的复制
# 7. 生成完整的项目
# 8. 配置项目域名
#######################################################################

echo -e "[========================= 自动化框架搭建开始...... ==========================]\n";


## 第1步： 安装yii2最新版框架
echo -e ">第1步： 安装yii2最新版框架"
./2-yii2.sh $1		# 执行2-yii2.sh脚本
echo -e ">第1步： 安装yii2最新版框架完成！！！"
echo ">-----------------------------------------------------------------------------------------------<";
echo -e '\n\n';

cd $1




## 第2步： 生成api模块
echo -e ">第2步： 生成api模块"
../3-create_api.sh		# 执行3-create_api.sh脚本，生成api模块
echo -e ">第2步： 生成api模块完成！！！"
echo ">-----------------------------------------------------------------------------------------------";
echo -e '\n\n';


## 第3步： 生成上传文件目录
echo -e ">第3步： 生成文件上传目录"
../4-upload_dir.sh		# 执行4-upload_dir.sh脚本，生成upload目录
echo -e ">第3步： 生成文件上传目录完成！！！"
echo ">-----------------------------------------------------------------------------------------------<";
echo -e '\n\n';



## 第4步： 配置AdminLte3后台
echo -e ">第4步： 配置AdminLte3后台"
../5-adminlte3_conf.sh $1
echo -e ">第4步： 配置AdminLte3后台完成！！！"
echo ">-----------------------------------------------------------------------------------------------<";
echo -e '\n\n';


## 第5步： 生成create_user脚本
echo -e ">第5步： 生成create_user脚本"
../6-create_user.sh
echo -e "> 第5步： 生成create_user脚本完成！！！"
echo ">-----------------------------------------------------------------------------------------------<";
echo -e '\n\n';


## 第6步： 生成完整的项目,并将其移到/usr/share/nginx/html目录中
echo -e ">第6步： 生成完整的项目,并将其移到/usr/share/nginx/html目录中"
../7-get_project.sh $1
echo -e ">第6步： 生成完整的项目完成！！！"
echo ">-----------------------------------------------------------------------------------------------<";
echo -e '\n\n';




echo -e "[========================= 自动化已经全部完成！！！！ ==========================]\n";



