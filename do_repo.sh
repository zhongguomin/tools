#!/bin/bash

:<<EOF
==========================================================
一	功能
	支持如下两个命令：
	./do_repo status
		cd git_project
		git status
	./do_repo pull
		cd git_project
		git pull

二	实现
1	获取当前目录下的文件夹
	并判断该文件夹下是否有 .git 文件夹
	如果有，存入一个目录数组
2	获取输入参数，对目录数组中的文件夹，执行其命令

==========================================================
EOF


declare -a git_dir_array
declare -a support_param_array

support_param_array=("status" "pull" "size" "backup")


function find_git_dir()
{
	local num=0
	unset git_dir_array

	# for f in `ls -l | grep ^d | awk '{print $9}'`
	for f in `ls -d */`
	do
		if [ -d $f/.git ]; then
			git_dir_array[$num]=$f
			let num+=1
		fi
	done
}

function do_git_cmd()
{
	echo "=================================================="
	echo "You Have ${#git_dir_array[@]} Projects"
	echo "=================================================="

	for git_dir in ${git_dir_array[@]}
	do
		cur_dir=`pwd`
		cd ${git_dir}
		echo -e "\033[40;33m${cur_dir}/${git_dir}\033[0m"
		git $1
		echo ""
		cd ${cur_dir}
	done
}

function get_dir_size()
{
	du -sh *
}

function do_backup()
{
	# date_time=`date '+%Y-%m-%d-%H-%M-%S'`
	date_time=`date '+%Y-%m-%d'`

	for git_dir in ${git_dir_array[@]}
	do
		backup_name="${git_dir:0:(${#git_dir}-1)}.${date_time}.tar.gz"
		echo "tar -czf ${backup_name} ${git_dir} ..."
		tar -czf ${backup_name} ${git_dir}
	done
}

function print_help()
{
	echo "Input Error ..!!"
	echo "Use Like: ./do_repo.sh parameter "
	echo "  parameter: "

	for param in ${support_param_array[@]}
	do
		echo "    ${param}"
	done
}

function process_args()
{
	if [ $# != 1 ]; then
		print_help
		return
	fi

	case $1 in
		"status" | "pull")
			find_git_dir
			do_git_cmd $1;;
		"size")
			get_dir_size;;
		"backup")
			find_git_dir
			do_backup;;
		*)
			print_help;;
	esac
}

function has_new_version()
{
	# diff do_repo.sh tools/do_repo.sh 
}

complete -W "${support_param_array[*]}" do_repo.sh

process_args $@



