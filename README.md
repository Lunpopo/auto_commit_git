## auto_commit_git
```
This script can auto commit change to git server, if need enter password, just follow hints enter pass
```

## auto_commit_git.sh
```
this bash script is appropriate for that has own local repositories
because it can chckout your current branch and auto switch branch that codding to configuration item

Edit aotu_commit_git.sh file, and 
follow configuration item, example:

#local branch, modify this default item to your local branch name
local_branch='lunpopo'                  => modify to local_branch='your_local_branch_name'
#remote branch name, modify this default item to your remote branch name
remote_branch='log_new'                 => modify to remote_branch='your_remote_branch_name'
#program dir, modify this default item to your program dir
program_pwd='/home/popo_program'        => modify to project_pwd='your_program_dir'
```

## auto_commit_git_one_branch.sh
```
this bash script is appropriate for that only one branch, such as master branch

Edit auto_commit_git.sh
fllow configuration item, example:

#remote branch name, modify this default item to your remote branch naem
remote_branch='log'                     => modify to remote_branch='your_remote_branch_name'
#project path, modify this default item to your program path
project_pwd='/home/popo_program'        => modify to project_pwd='your_project_path'
```
