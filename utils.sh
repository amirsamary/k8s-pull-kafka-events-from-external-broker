#using part of the util script in ICMDurable

RED="\033[1;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
WHITE="\033[1;37m"
RESET="\033[0m"

function exit_if_empty {
    if [ -z "$1" ];
    then
        printf "\n\n${PURPLE}Exiting.${RESET}"
        exit 0
    fi
}

function exit_if_error {

	if [ $? -ne 0 ];
	then
		if [ "$1" != "" ];
		then
			printf "\n\n${RED}"
			echo "ERROR: $1"
			printf "\n\n${RESET}"
		fi
		exit 1
	fi
}

function exit_with_error {
	printf "\n\n${RED}Exiting: $1.${RESET}\n\n"
	exit 0
}

function msg {
	printf "\n${BLUE}$1${RESET}"
}

function option {
	printf "\n${WHITE}$1 - ${BLUE}$2${RESET}"
}

function trace {
	printf "\n\n${CYAN}$1${RESET}\n"
}

function warn {
	printf "\n\n${YELLOW}$1${RESET}\n\n"
}

function normalize_path_for_platform
{
    if [ ! -z $(uname | grep MINGW64) ];
    then 
        # Need to fix it for K3D running on windows when using git-bash or cygwin
        FORWARD_SLASH='\/'
        BACK_SLASH='\\'
        BAD_C_COLON='\\C\\'
        GOOD_C_COLON='C:\\'

        TMP=$(echo $1 | awk "{gsub(/$FORWARD_SLASH/,\"$BACK_SLASH\"); print}")
        export NORMALIZED_PATH=$(echo $TMP | awk "{gsub(/$BAD_C_COLON/,\"$GOOD_C_COLON\"); print}")
    else
        # On *NIX we don't change anything
        export NORMALIZED_PATH=$1
    fi
}