#!/bin/bash
# Author : Gazeka74 <gazeka74@gmail.com>

############
# Variables
############

DESCRIPTOR="
$0 : a small script to backup and restore dotfiles"

USAGE="
Usage :
	$0 [options]
Options :
	-h , --help	This help menu
	-b , --backup	Backup the dotfiles 
	-r , --restore	Restore the dotfiles to the correct location
	-c=, --config=	Specify a configuration file to indicate what to save
	-g , --git	In case of a backup, indicate to add . -commit -push
	-m=, --message=	Used with -g, specify a particular message for the git commit
			Used alone, this option has no effect"

DEFAULTS=true
CONFIG_FILE=false
BACKUP=false
RESTORE=false
GIT=false
MESSAGE="AUTO COMMIT : $(date)"


############
# Functions
############

function print_usage {
	printf "$DESCRIPTOR \n$USAGE";
}

function add_commit_push {
	git add .
	git commit -m "$MESSAGE"
	git push origin master
}
############
# Main loop
############

# At least one argument is required
if [ $# -eq 0 ]; then
	printf "Invalid number of parameters \n";
	printf "append \"-h\" to get more information";	
	exit 1 ;
fi

#FIXME replace echo with function
for i in "$@"
do
	case $i in 
	-h|--help)
		print_usage ; exit 0 ;;
	-b|--backup)
		echo --backup;
		BACKUP=true;;
	-r|--restore)
		echo --restore;
		RESTORE=true;;
	-c=*|--config_file=*)
		echo --config_file; 
		DEFAULTS=false; 
		CONFIG_FILES="${i#*=}";
		echo $CONFIG_FILES;;
	-g|--git)
		echo --git;
		GIT=true;;
	-m=*|--message=*)
		echo --message;
		MESSAGE="${i#*=}";;

	*)
		printf "\nINVALID_PARAMETER\n$USAGE"; exit 1;;
esac
done

# Check if we want to perform both backup and restore or none of them,
# as this is illogical and should not be done
if [ $BACKUP == $RESTORE ]
then
	printf "\nINVALID_PARAMETER\nSpecify one operation to perform (backup or restore)"; 
	exit 1;
fi

add_commit_push
echo -- all done !
