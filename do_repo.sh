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
	for git_dir in ${git_dir_array[@]}
	do
		cur_dir=`pwd`
		cd ${git_dir}
		echo -e "\033[47;30m${cur_dir}/${git_dir}  \033[0m"
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
	echo "
	  Use Like: ./do_repo.sh parm
	  parm [status, pull, size, backup]"
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

process_args $@



