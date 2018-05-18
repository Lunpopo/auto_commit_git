#!/bin/bash
#个人版，适用于有自己的本地分支

#配置区域

#本地分支，修改成你的本地分支
local_branch='xieyuexing'
#远程仓库名，修改成你的远程服务器分支
remote_branch='log_new'
#项目的路径，修改成你的项目路径
programe_pwd='/home/nidaye/erdaye/estorUI'

#配置区域结束



#
#
#
#代码区域
current_branch=`cd $programe_pwd && git branch | grep '*' | awk '{if(NR==1){print $2}}'`
echo "当前分支为$current_branch"

if [ $current_branch == $local_branch ];then
	echo "当前的branch和配置的本地仓库名相等"
	cd $programe_pwd && git add . && git commit -m "$(date +'%Y-%m-%d_%H:%M:%S')"

	echo "切换到远程分支..."
	cd $programe_pwd && git checkout $remote_branch
	echo "切换成功!"

	echo "拉取远程分支..."
	cd $programe_pwd && git pull origin $remote_branch
	echo "拉取成功!"

	echo "本地仓库合并远程仓库，检查有无冲突..."
	check_conflict=`cd $programe_pwd && git checkout $local_branch && git merge $remote_branch | grep -n 'error' ; echo $?`

	#如果有冲突
	if [ "$check_conflict"x == "0"x ];then
		echo "有冲突，终止整个提交，请解决冲突后再次运行次脚本!"
	#没有冲突
	else
		echo "无冲突，远程仓库开始合并本地仓库..."
		cd $programe_pwd && git checkout $remote_branch && git merge $local_branch 
		echo "合并成功!"

		echo "提交到远程仓库，更新服务器代码..."
		cd $programe_pwd && git push origin $remote_branch
		echo "更新完成!"
	fi
else
	echo "当前的branch和配置的本地仓库名不相等"
	echo "正在切换到$local_branch分支 ..."
	cd $programe_pwd && git checkout $local_branch
	echo "切换成功!"

	#重新走一遍上面的程序
	cd $programe_pwd && git add . && git commit -m "$(date +'%Y-%m-%d_%H:%M:%S')"

	echo "切换到远程分支..."
	cd $programe_pwd && git checkout $remote_branch
	echo "切换成功!"

	echo "拉取远程分支..."
	cd $programe_pwd && git pull origin $remote_branch
	echo "拉取成功!"

	echo "本地仓库合并远程仓库，检查有无冲突..."
	check_conflict=`cd $programe_pwd && git checkout $local_branch && git merge $remote_branch | grep -n 'error' ; echo $?`

	if [ "$check_conflict"x == "0"x ];then
		echo "有冲突，终止整个提交，请解决冲突后再次运行次脚本!"
	else
		echo "无冲突，远程仓库开始合并本地仓库..."
		cd $programe_pwd && git checkout $remote_branch && git merge $local_branch 
		echo "合并成功!"

		echo "提交到远程仓库，更新服务器代码..."
		cd $programe_pwd && git push origin $remote_branch
		echo "更新完成!"
	fi
fi
