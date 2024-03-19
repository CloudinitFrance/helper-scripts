#! /bin/bash
# Generate random password for all kind of usage :)

# Some colors
export TERM=xterm
BOLD=$(tput bold)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)

function generate_random_password() {
	PASSWORD_FILE_KEY_NAME=$1
	PASSWORD_LENGTH=$2

	echo -e "${BOLD}${GREEN}Generate a new random password${RESET}"
	# Generate random password
	export LC_CTYPE=C
	RANDOM_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${PASSWORD_LENGTH} | head -n 1)

	# Store the password inside your secret file
	echo -n $RANDOM_PASSWORD > $PASSWORD_FILE_KEY_NAME

}

# Script entry point
# Check args
if (( $# != 2 )); then
	echo -e "${BOLD}${RED}Illegal number of parameters "
	echo -e "Please provide a secret file name where to store the generated password and a password length${RESET}"
	exit 1
fi

generate_random_password $1 $2
