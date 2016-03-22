#!/bin/bash 

# This is not really transforming a script in multthread
# its just spawning multiple sequencial processes in background.
# Spawn multiple configurable nohup threads of a script running in background.
#

##COLORS

BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PINK="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
NORMAL="\033[0;39m"
OFF="\033[0m"

##UTILS

echo_msg(){

case ${2-normal} in
        info)
            echo -e "${BLUE}$1${OFF}"
            ;;
	good)
	    echo -e "${GREEN}$1${OFF}"
	    ;;
        warning)
	    echo -e "${YELLOW}$1${OFF}"           
           ;;
        error)
           echo -e "${RED}$1${OFF}"
	   ;;
	*)
	echo -e "${NORMAL}$1${OFF}"
	;;
esac

}


#CONFIG HERE
max_bg_jobs=2
bashscript=${1-'default.sh'}
items=`ls`


check_no_jobs(){

no_bg_jobs=$(jobs | wc -l)

while [ $max_bg_jobs -lt $no_bg_jobs ] ; 
 do
   echo_msg "Max number of process running $no_bg_jobs, Waiting for the next available process..." warning
   sleep 5
   no_bg_jobs=$(jobs | wc -l)
 done;
}

run_for_each(){
for i in $items;
 do  
  nohup ./$bashscript $i 2> /dev/null &
  check_no_jobs
 done;
}

no_files=`ls|wc -l`
echo_msg "Starting Process $no_files Files" info
run_for_each


