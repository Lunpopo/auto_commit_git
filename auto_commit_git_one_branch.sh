#!/bin/bash
#appropriate for only one branch, such as 'master' branch
#适用于只有一个分支的情况，直接开发，没有自己的本地分支

#configuration area
#配置区域

#remote repository name, modify to your remote branch name
#远程仓库名，修改成你的远程服务器分支
remote_branch='log'
#project path, modify to your project path
#项目的路径，修改成你的项目路径
project_pwd='/home/popo_project'

#configuration end
#配置区域结束



#
#
#
#code area
#代码区域

echo "pull remote branch..."
echo "拉取远程分支..."
check_conflict=`cd $project_pwd && git pull origin $remote_branch | grep -n 'error' ; echo $?`

#if conflict
#如果有冲突
if [ "$check_conflict"x == "0"x ];then
	echo "has conflict, break whole "
	echo "有冲突，终止整个提交，请解决冲突后再次运行次脚本!"
#没有冲突
else
	echo "add local code and commit to local repository..."
	echo "添加本地代码并提交到本地仓库..."
	check_commit_conflict=`cd $project_pwd && git add . && git commit -m "$(date +'%Y-%m-%d_%H:%M:%S')" | grep -n "error" ; echo $?`
	#checkout conflict
	#检查提交时有无冲突
	if [ "$checkout_commit_conflict"x == "0"x ];then
		echo "has conflict, break whole commit, please fix conflict and run this script again"
		echo "有冲突，终止整个提交，请解决冲突后再次运行次脚本!"
	else
		echo "commit to local code success!"
		echo "提交本地代码成功!"
	fi

	echo "commit to remote repository, update server code..."
	echo "提交到远程仓库，更新服务器代码..."
	cd $project_pwd && git push origin $remote_branch
	echo "update success!"
	echo "更新完成!"
fi

#code end
#代码区域结束
