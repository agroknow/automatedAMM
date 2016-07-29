#!/bin/bash

urlencode() {
    local data
    if [[ $# != 1 ]]; then
        echo "Usage: $0 string-to-urlencode"
        return 1
    fi
    data="$(curl -s -o /dev/null -w %{url_effective} --get --data-urlencode "$1" "")"
    if [[ $? != 3 ]]; then
        echo "Unexpected error" 1>&2
        return 2
    fi
    echo "${data##/?}"
    return 0
}

url_encode() {
 [ $# -lt 1 ] && { return; }

 encodedurl="$1";

 # make sure hexdump exists, if not, just give back the url
 [ ! -x "/usr/bin/hexdump" ] && { return; }

 encodedurl=`
   echo $encodedurl | hexdump -v -e '1/1 "%02x\t"' -e '1/1 "%_c\n"' |
   LANG=C awk '
     $1 == "20"                    { printf("%s",   "+"); next } # space becomes plus
     $1 ~  /0[adAD]/               {                      next } # strip newlines
     $2 ~  /^[a-zA-Z0-9.*()\/-]$/  { printf("%s",   $2);  next } # pass through what we can
                                   { printf("%%%s", $1)        } # take hex value of everything else
   '`
}

rawurlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER) 
  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}

URL=$1
SET=$2

curl "http://agris.fao.org/agris-search/searchIndex.do?query=%22$( rawurlencode "${URL}" )%22&startIndexSearch=0" | grep "search.do?recordID=${SET}" > tmp2


#curl --data-urlencode "$1\"&startIndexSearch=0" "http://agris.fao.org/agris-search/searchIndex.do?query=%22"

#value="http://www.google.com"
#encoded=$(php -r "echo rawurlencode('$value');")

#echo ${encoded}

#echo "http://agris.fao.org/agris-search/searchIndex.do?query=%22$( url_encode "${URL}" )%22&startIndexSearch=0"
echo "http://agris.fao.org/agris-search/searchIndex.do?query=%22${urlbeta}%22&startIndexSearch=0"

after="$(echo -e "$URL" | od -An -tx1 | tr ' ' % | xargs printf "%s")"
echo "$after"


echo "http://agris.fao.org/agris-search/searchIndex.do?query=%22$"${URL}"%22&startIndexSearch=0"

wc -l tmp2 > tmp3
sed -i 's/ tmp2//g' tmp3

lines="$(cat tmp3)"
#exit

if [ "$lines" = 2 ]; then
	echo ${URL} >> titles.duplicate
	exit
else
	echo '' > tmp3
fi

curl "http://agris.fao.org/agris-search/searchIndex.do?query=%22${after}%22&startIndexSearch=0" | grep "search.do?recordID=${SET}" > tmp2
wc -l tmp2 > tmp3
sed -i 's/ tmp2//g' tmp3

lines="$(cat tmp3)"
if [ "$lines" = 2 ]; then
        echo ${URL} >> titles.duplicate
else
        echo '' > tmp3
fi

#<h3><a target="_blank" href="search.do?recordID=AL2015111623">

#echo http://url/q?=$( rawurlencode "${URL}" )
#grep "search.do?recordID=${SET}" > tmp
