#!/bin/bash
file=imenik_26285.dat
i=0
if ! [ -f "$file" ]; then #file not exists
    touch imenik_26285.dat
fi 
if [ -z $1 ];then
	echo "-dodaj | dodajanje novega kontakta"
	echo "-brisi | izbrisi kontakt"
	echo "-isci | poisci kontakt"
	echo "-uredi | uredi kontakt"
fi
