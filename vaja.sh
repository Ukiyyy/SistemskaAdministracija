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
dodajanje() {
for arg in "$@"; do
  shift
  case "$arg" in
    "-ime") set -- "$@" "-i" ;;
    "-priimek") set -- "$@" "-p" ;;
    "-naslov")   set -- "$@" "-n" ;;
    "-posta") set -- "$@" "-o" ;;
    "-kraj") set -- "$@" "-k" ;;
    "-tel")   set -- "$@" "-t" ;;
    *)        set -- "$@" "$arg"
  esac
done
    local OPTIND
    while getopts :i:p:n:o:k:t: flag
do
    case "${flag}" in
        i) ime=${OPTARG};;
        p) priimek=${OPTARG};;
        n) naslov=${OPTARG};;
        o) posta=${OPTARG};;
        k) kraj=${OPTARG};;
        t) tel=${OPTARG};;
    esac
done
shift $((OPTIND-1))

id=$(( $RANDOM % 1000 + 101)) #racunanje id stevilke za vsakega, ki je dodan v imenik
echo -n "$id" >> imenik_26285.dat #zapisem id v datoteko
#v naslednjih if stavkih preverjam ce sem poleg zastavice podav vrednost in ce nisem se zapise
#v datoteko PRAZNO drugace pa se spremenljivki nastavi tista vrednost, ki jo vnesemo v terminal
        if [[ $ime == "daj" || -z $ime ]]
        then
            echo -n ";;PRAZNO;;" >> imenik_26285.dat
        else
            echo -n ";;$ime;;" >> imenik_26285.dat
        fi

        if [[ $priimek == "daj" || -z $priimek ]]
        then
            echo -n "PRAZNO" >> imenik_26285.dat
        else
           echo -n "$priimek" >> imenik_26285.dat
        fi
        
        if [[ $naslov == "daj" || -z $naslov ]]
        then
            echo -n ";;PRAZNO;;" >> imenik_26285.dat
        else
            echo -n ";;$naslov;;" >> imenik_26285.dat
        fi
        
        if [[ $posta == "daj" || -z $posta ]]
        then
            echo -n "PRAZNO" >> imenik_26285.dat
        else
            echo -n "$posta" >> imenik_26285.dat
        fi
        
        if [[ $kraj == "daj" || -z $kraj ]]
        then
            echo -n ";;PRAZNO;;" >> imenik_26285.dat
        else
            echo -n ";;$kraj;;" >> imenik_26285.dat
        fi
        
        if [[ $tel == "daj" || -z $tel ]]
        then
            echo -n "PRAZNO" >> imenik_26285.dat
        else
            echo -n "$tel" >> imenik_26285.dat
        fi
echo "" >> imenik_26285.dat
#echo "$id $ime $priimek $naslov $posta $kraj $tel" >> imenik_26285.dat
}