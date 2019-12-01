#!/bin/sh

Progrm='cleenux'

if [ $UID -eq 0 ]; then
	printf "ERROR: Root permissions required for system-wide changes.\n" 1>&2
	exit 1
fi

Exec(){
	printf -v MSG "%s..." "$1"
	shift

	$@

	Red='\033[1;31m'
	Green='\033[1;32m'
	Reset='\033[0m'

	if [ $? -gt 0 ]; then
		printf "$Red[ERR]$Reset \n"
	else
		printf "$Red[OK]$Reset \n"
	fi
}

if [ -f $Progrm -a -r $Progrm ]; then
	Exec "[1/3] Installing to '/usr/bin/cleenux'" cp "$Progrm" /usr/bin/
	Exec "[2/3] Setting correct file modes" chmod 755 "/usr/bin/$Progrm"
	Exec "[3/3] Correcting ownership" chown 0:0 "/usr/bin/$Progrm"
	printf "Done!\n"
else
	printf "ERROR: File '$Progrm' missing or inaccessible.\n" 1>&2
	exit 1
fi

