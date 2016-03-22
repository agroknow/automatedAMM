#!/bin/bash

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

curl "http://agris.fao.org/agris-search/searchIndex.do?query=%22$( rawurlencode "${URL}" )%22&startIndexSearch=0" | grep "search.do?recordID=${SET}" > tmp

#<h3><a target="_blank" href="search.do?recordID=AL2015111623">

#echo http://url/q?=$( rawurlencode "${URL}" )
#grep "search.do?recordID=${SET}" > tmp
