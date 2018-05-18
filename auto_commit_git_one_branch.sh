#!/bin/bash
#适用于只有一个分支的情况，直接开发，没有自己的本地分支

#配置区域

#远程仓库名，修改成你的远程服务器分支
remote_branch='log'
#项目的路径，修改成你的项目路径
programe_pwd='/home/estorUI'

#配置区域结束



#
#
#
#代码区域

echo "拉取远程分支..."
check_conflict=`cd $programe_pwd && git pull origin $remote_branch | grep -n 'error' ; echo $?`

#如果有冲突
if [ "$check_conflict"x == "0"x ];then
	echo "有冲突，终止整个提交，请解决冲突后再次运行次脚本!"
#没有冲突
else
	echo "添加本地代码并提交到本地仓库..."
	check_commit_conflict=`cd $programe_pwd && git add . && git commit -m "$(date +'%Y-%m-%d_%H:%M:%S')" | grep -n "error" ; echo $?`
	#检查提交时有无冲突
	if [ "$checkout_commit_conflict"x == "0"x ];then
		echo "有冲突，终止整个提交，请解决冲突后再次运行次脚本!"
	else
		echo "提交本地代码成功!"
	fi

	echo "提交到远程仓库，更新服务器代码..."
	cd $programe_pwd && git push origin $remote_branch
	echo "更新完成!"
fi

#代码区域结束
