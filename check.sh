#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage()
{
	cat << EOF # remove the space between << and EOF, this is due to web plugin issue
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-f] -p param_value arg1 [arg2...]

Script description here.

Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
-f, --flag      Some flag description
-p, --param     Some param description
EOF

	exit
}

cleanup()
{
	trap - SIGINT SIGTERM ERR EXIT

	# Script cleanup here
}

setup_colors()
{
 	if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
   		NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
	else
		NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
	fi
}

print_status()
{
	echo >&2 -e "${YELLOW}[!]${NOFORMAT} ${1-}"
}

print_success()
{
	echo >&2 -e "${GREEN}[+]${NOFORMAT} ${1-}"
}

die()
{
	local msg=$1
	local code=${2-1} # Default exit status 1
	echo >&2 -e "${RED}[-]${NOFORMAT} ${1-}"
	exit "$code"
}

parse_params()
{
	# Default values of variables set from params
	flag=0
	param=''

	while :; do
		case "${1-}" in
			-h | --help) usage ;;
			-v | --verbose) set -x ;;
			--no-color) NO_COLOR=1 ;;
			-f | --flag) flag=1 ;; # example flag
			-p | --param) # example named parameter
				param="${2-}"
				shift
				;;
			-?*) die "Unknown option: $1" ;;
			*) break ;;
		esac

		shift
	done

	args=("$@")

	# check required params and arguments
	[[ -z "${param-}" ]] && die "Missing required parameter: param"
	[[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

	return 0
}

check()
{
	echo "[!] Checking ..."
	for i in $(ls); do
		if [ -d "$i" ]; then
			cd $i
			echo "$i es un direcotorio"
			cd ..
			continue
		fi

		echo "$i es un archivo"
	done
}

main()
{
	# parse_params "$@"
	setup_colors

	print_status "Probando esta funcion"
	print_success "Buenas buenas"
	die "Error al mimir"

	# Iterate throught JSON file using jq
	jq -c '.[]' files.json | while read item; do
		src=$(jq -r '.src' <<< "$item")
		dst=$(jq -r '.dst' <<< "$item")
		is_recursive=$(jq -r '.recursive' <<< "$item")
		echo $is_recursive
		# cat "$HOME/$src"
		# cat $dst
		if [ -d "$HOME/$src" ]; then
			echo "[!] Es un directorio."
		else
			diff "$HOME/$src" "$PWD/$dst" >/dev/null && echo "[+] $src"
		fi
	done
	
	# msg "${RED}Read parameters:${NOFORMAT}"
	# msg "- flag: ${flag}"
	# msg "- param: ${param}"
	# msg "- arguments: ${args[*]-}"
}

main "$@"

