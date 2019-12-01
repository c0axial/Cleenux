#!/bin/sh

Progrm='cleenux'

Err(){
	printf "ERROR: %s\n" "$2" 1>&2
	[ $1 -gt 0 ] && exit $1
}

if ! [ ${UID:-`id -u`} -eq 0 ]; then
	Err 1 'Root permissions required for system-wide changes.'
fi

Exec(){
	Red='\033[1;31m'
	Green='\033[1;32m'
	Reset='\033[0m'

	MSG=$1
	shift

	printf "%s... " "$MSG"

	$@ 1> /dev/null 2>&1

	if [ $? -gt 0 ]; then
		printf " $Red[ERR]$Reset\n"
	else
		printf " $Green[OK]$Reset\n"
	fi

	unset Red Green Reset MSG
}

if [ -f $Progrm -a -r $Progrm ]; then
	if [ -f "/usr/bin/$Progrm" ]; then
		printf "File '/usr/bin/$Progrm' already exists.\n"
		printf "Overwrite? [Y/N] "
		read YNAnswer
		case $YNAnswer in
			[Yy]|[Yy][Ee][Ss])
				;;
			[Nn]|[Nn][Oo])
				printf "Nothing done -- quitting."
				exit 0 ;;
			*)
				Err 1 'Invalid response -- quitting.' ;;
		esac
	fi

	Exec "[1/3] Installing to '/usr/bin/cleenux'" cp "$Progrm" /usr/bin/
	Exec "[2/3] Setting correct file modes" chmod 755 "/usr/bin/$Progrm"
	Exec "[3/3] Correcting ownership" chown 0:0 "/usr/bin/$Progrm"
	printf "Done!\n"
else
	Err 1 'File '$Progrm' missing or inaccessible.'
fi

