#!/bin/bash
#personal edit, appropriate for that has own local branch
#个人版，适用于有自己的本地分支

#setting area
#配置区域

#local branch, modify this default item to your local branch name
#本地分支，修改成你的本地分支
local_branch='lunpopo'
#remote branch, modify this default item to your remote branch name
#远程仓库名，修改成你的远程服务器分支
remote_branch='log_new'
#project path, modify this default item to you project path
#项目的路径，修改成你的项目路径
project_pwd='/home/popo_project'

#setting end
#配置区域结束



#
#
#
#coding area
#代码区域
current_branch=`cd $project_pwd && git branch | grep '*' | awk '{if(NR==1){print $2}}'`
echo "local branch is $current_branch"
echo "当前分支为$current_branch"

if [ $current_branch == $local_branch ];then
	echo "current branch name and configuration item is equal of the local repository"
	echo "当前的branch和配置的本地仓库名相等"
	cd $project_pwd && git add . && git commit -m "$(date +'%Y-%m-%d_%H:%M:%S')"

	echo "change to remote branch..."
	echo "切换到远程分支..."
	cd $project_pwd && git checkout $remote_branch
	echo "change success!"
	echo "切换成功!"

	echo "pull remote branch..."
	echo "拉取远程分支..."
	cd $project_pwd && git pull origin $remote_branch
	echo "pull success!"
	echo "拉取成功!"

	echo "local repository merge remote repository, and checkout conflict..."
	echo "本地仓库合并远程仓库，检查有无冲突..."
	check_conflict=`cd $project_pwd && git checkout $local_branch && git merge $remote_branch | grep -n 'error' ; echo $?`

	#if has conflict
	#如果有冲突
	if [ "$check_conflict"x == "0"x ];then
		echo "has conflict, break whole commit, please fix conflict and run this script again!"
		echo "有冲突，终止整个提交，请解决冲突后再次运行次脚本!"
	#do not have conflict
	#没有冲突
	else
		echo "do not has conflict, remote repository merging local repository..."
		echo "无冲突，远程仓库开始合并本地仓库..."
		cd $project_pwd && git checkout $remote_branch && git merge $local_branch 
		echo "merge success!"
		echo "合并成功!"

		echo "commit to remote repository, update server code..."
		echo "提交到远程仓库，更新服务器代码..."
		cd $project_pwd && git push origin $remote_branch
		echo "update success!"
		echo "更新完成!"
	fi
else
	echo "current branch name different from local repository name"
	echo "当前的branch和配置的本地仓库名不相等"
	echo "switch to local branch..."
	echo "正在切换到$local_branch分支 ..."
	cd $project_pwd && git checkout $local_branch
	echo "change success!"
	echo "切换成功!"

	#重新走一遍上面的程序
	cd $project_pwd && git add . && git commit -m "$(date +'%Y-%m-%d_%H:%M:%S')"

	echo "switch to remote branch..."
	echo "切换到远程分支..."
	cd $project_pwd && git checkout $remote_branch
	echo "change success!"
	echo "切换成功!"

	echo "pull remote branch..."
	echo "拉取远程分支..."
	cd $project_pwd && git pull origin $remote_branch
	echo "pull success!"
	echo "拉取成功!"

	echo "local repository merge remote, checkout conflict..."
	echo "本地仓库合并远程仓库，检查有无冲突..."
	check_conflict=`cd $project_pwd && git checkout $local_branch && git merge $remote_branch | grep -n 'error' ; echo $?`

	if [ "$check_conflict"x == "0"x ];then
		echo "has conflict, break whole commit, please fix conflict and run this script again!"
		echo "有冲突，终止整个提交，请解决冲突后再次运行次脚本!"
	else
		echo "do not have conflict, remote repository merging local repository..."
		echo "无冲突，远程仓库开始合并本地仓库..."
		cd $project_pwd && git checkout $remote_branch && git merge $local_branch 
		echo "merge success!"
		echo "合并成功!"

		echo "commit to remote repository, update server code..."
		echo "提交到远程仓库，更新服务器代码..."
		cd $project_pwd && git push origin $remote_branch
		echo "update success!"
		echo "更新完成!"
	fi
fi
