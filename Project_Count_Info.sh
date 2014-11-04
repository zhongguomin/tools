#!/bin/bash

:<<EOF
==========================================================
1	What for
	Count project source line, files, other infomactions

2	How use
	./Project_Count_Info dirname

3	Option

4	Other same tools
	cloc
	sudo apt-get install cloc

	$ cloc .
      88 text files.
      88 unique files.                              
      22 files ignored.

	http://cloc.sourceforge.net v 1.60  T=0.24 s (332.6 files/s, 36158.0 lines/s)
	-------------------------------------------------------------------------------
	Language                     files          blank        comment           code
	-------------------------------------------------------------------------------
	Java                            36            376            396           4284
	XML                             33             99             22           2081
	C++                              5             99            100            810
	C/C++ Header                     4             21             21            130
	C                                1             17             42            108
	Bourne Shell                     1             20              0             72
	-------------------------------------------------------------------------------
	SUM:                            80            632            581           7485
	-------------------------------------------------------------------------------


5	Log


==========================================================
EOF

function count_lines()
{
	find . -type f -name "*.java" | xargs cat | grep -v ^$ | wc -l
}

function count_files()
{
	find . -type f  -name "*.java" | wc -l
}

function count_dirs()
{
	find . -type d | wc -l
}

function count_all_info()
{
	echo  "
	
	-------------------------------------------------------------------------------
	Language                     files          blank        comment           code
	-------------------------------------------------------------------------------
	Java                            36            376            396           4284
	XML                             33             99             22           2081
	C++                              5             99            100            810
	C/C++ Header                     4             21             21            130
	C                                1             17             42            108
	Bourne Shell                     1             20              0             72
	-------------------------------------------------------------------------------
	SUM:                            80            632            581           7485
	-------------------------------------------------------------------------------

	"
}

function print_help()
{
	echo "
	The Shell Script is to count project lines, files, dirs
	Use like:
		./Project_Count_Info.sh  options

	Options:
		line
		file
		dir
		all
	"
}

function process_args()
{
	if [ $# != 1 ]; then
		print_help
		return
	fi

	case $1 in
		"line")
			count_lines
		;;
		"file")
			count_files
		;;
		"dir")
			count_dirs
		;;
		"all")
			count_all_info
		;;
	esac
}

process_args $@

