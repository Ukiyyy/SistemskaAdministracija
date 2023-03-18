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
brisanje() {
for arg in "$@"; do
  shift
  case "$arg" in
  	"-id") set -- "$@" "-i" ;;
    *)        set -- "$@" "$arg"
  esac
done
    local OPTIND
    while getopts :i: flag
do
    case "${flag}" in
        i) id=${OPTARG};;
    esac
done
shift $((OPTIND-1))

grep -w $id $file #izpisem vrstico ki jo zelimo brisati preko ID stevilke
read -p "Potrdite brisanje z 'y': " inp #input da potrdimo brisanje
grep -w $id $file | while read -r line ; do #poisce tisto vrstico
	#i=$[ $i +1 ]
if [ $inp == "y" ] ;then
	echo "`sed  /"$line"/d  imenik_26285.dat`" > imenik_26285.dat #ce je input 'y' izbrisemo
fi
done
}
iskanje() {
	for arg in "$@"; do
  shift
  case "$arg" in
  	"-ime") set -- "$@" "-a" ;;
    "-priimek") set -- "$@" "-p" ;;
    "-naslov")   set -- "$@" "-n" ;;
    "-posta") set -- "$@" "-o" ;;
    "-kraj") set -- "$@" "-k" ;;
    "-tel")   set -- "$@" "-t" ;;
    *)        set -- "$@" "$arg"
  esac
done
    local OPTIND
    while getopts :a:p:n:o:k:t: flag
do
    case "${flag}" in
        a) ime=${OPTARG};;
        p) priimek=${OPTARG};;
        n) naslov=${OPTARG};;
        o) posta=${OPTARG};;
        k) kraj=${OPTARG};;
        t) tel=${OPTARG};;
    esac
done
shift $((OPTIND-1))
#iskanje uporabnika, ki ga zelimo najti 
grep -E "*$ime.*$priimek.*$naslov.*$posta.*$kraj.*$tel|$ime.$priimek.$naslov.$posta.$kraj.$tel" imenik_26285.dat
}
urejanje() {
for arg in "$@"; do
  shift
  case "$arg" in
    "-id") set -- "$@" "-a" ;;
    "-ime") set -- "$@" "-j" ;;
    "-priimek") set -- "$@" "-p" ;;
    "-naslov")   set -- "$@" "-n" ;;
    "-posta") set -- "$@" "-o" ;;
    "-kraj") set -- "$@" "-k" ;;
    "-tel")   set -- "$@" "-t" ;;
    *)        set -- "$@" "$arg"
  esac
done
    local OPTIND
    while getopts :a:j:p:n:o:k:t: flag
do
    case "${flag}" in
        a) id=${OPTARG};;
        j) ime=${OPTARG};;
        p) priimek=${OPTARG};;
        n) naslov=${OPTARG};;
        o) posta=${OPTARG};;
        k) kraj=${OPTARG};;
        t) tel=${OPTARG};;
    esac
done
shift $((OPTIND-1))

grep -w $id $file #najprej izpisemo vrstico ki jo zelimo urejati
read -p "Potrdite urejanje z 'y': " inp #potrjevanje z 'y'
#ce smo vnesli 'y' vsak if preveri za svojo zastavico ce je prazna torej ce smo vnesli vrenost
#poleg zastavice in ce nismo se izpise da bo ostalo nespremenjeno ce pa smo vnesli vrednost
#pa se bo nastavila vrednost, ki smo jo zeleli
if [ $inp == "y" ] ;then
    if [[ $ime == "daj" || -z $ime ]]
    then
      	echo "Ime bo nespremenjeno"
    else
    	im="$(grep -w $id imenik_26285.dat | sed -e "s/;;/ /g" | awk '{print $2}')" #poiscemo tisto besedo ki jo zelimo spremeniti in odstranimo znake -- ter jo shranimo v vrednost
    	sed -i "/$id/ s/$im/$ime/" imenik_26285.dat #v tisti vrsti, kjer je ta id kot smo dolocili najdemo besedo katere smo shranili vrednost in ji dolocimo novo vrednost
    fi
    if [[ $priimek == "daj" || -z $priimek ]]
    then
      	echo "Priimek bo nespremenjen"
    else
  		two="$(grep -w $id imenik_26285.dat | sed -e "s/;;/ /g" | awk '{print $3}')"
  		sed -i "/$id/ s/$two/$priimek/" imenik_26285.dat
    fi
    if [[ $naslov == "daj" || -z $naslov ]]
    then
      	echo "Naslov bo nespremenjen"
    else
  		three="$(grep -w $id imenik_26285.dat | sed -e "s/;;/ /g" | awk '{print $4}')"
  		sed -i "/$id/ s/$three/$naslov/" imenik_26285.dat
    fi
    if [[ $posta == "daj" || -z $posta ]]
    then
      	echo "Posta bo nespremenjen"
    else
  		four="$(grep -w $id imenik_26285.dat | sed -e "s/;;/ /g" | awk '{print $5}')"
  		sed -i "/$id/ s/$four/$posta/" imenik_26285.dat
    fi
    if [[ $kraj == "daj" || -z $kraj ]]
    then
      	echo "Kraj bo nespremenjen"
    else
  		five="$(grep -w $id imenik_26285.dat | sed -e "s/;;/ /g" | awk '{print $6}')"
  		sed -i "/$id/ s/$five/$kraj/" imenik_26285.dat
    fi
    if [[ $tel == "daj" || -z $tel ]]
    then
      	echo "Telefon bo nespremenjen"
    else
      	six="$(grep -w $id imenik_26285.dat | sed -e "s/;;/ /g" | awk '{print $7}')"
  		sed -i "/$id/ s/$six/$tel/" imenik_26285.dat
    fi
fi
}
c=0
for v in "$@"
do
  if [[ $v == *"-dodaj"* || $v == *"-isci"* || $v == *"-uredi"* || $v == *"-brisi"* ]]
  then
    c=$((c+1))
  fi
done


#ce je podana vec kot 1 osnovna zastavica se program zakljuci in izpise opozorilo
if [[ c -eq 2 || c -gt 2 ]]
then
echo "Skripta se je zaklucila. Prevec osnovnih zastavic"
exit 0
fi

#glede na izbrano zastavico se izvede dolocena funkcija
if [[ $1 == *"-dodaj"* ]] ;then
  dodajanje "$@"
elif [[ $1 == *"-isci"* ]] ;then
	iskanje "$@"
elif [[ $1 == *"-uredi"* ]] ;then
	urejanje "$@"
elif [[ $1 == *"-brisi"* ]] ;then
	brisanje "$@"
fi