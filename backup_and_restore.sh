# Author : Gazeka74 <gazeka74@gmail.com>

WHEREAMI=$(pwd)

WHOAMI=$(whoami)

DESCRIPTOR="
$0 : a small script to backup and restore dotfiles"

USAGE="
Usage :
	$0 [options]
Options :
	-h, --help      This help menu
	-r, --restore   Restore the dotfiles to the correct location
	-b, --backup    Backup the dotfiles and git add/commit/push"

function print_usage {
	printf "$DESCRIPTOR \n$USAGE"
}

while true; do
	if [ -z "$1" ]; then
		print_usage ; exit 1
	fi
	
	case "$1" in
	-h|--help)
        	print_usage ; exit 0 ;;
	-b|--backup)
		echo backup; exit 0;;
	-r|--restore)
		echo restore; exit 0;;
	*)	
		printf "INVALID_PARAMETER\n$USAGE"; exit 1;;

	esac
done

