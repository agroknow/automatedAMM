#!/bin/bash

SET=$1

cd /home/agris/pm/automatedAMM/data/2_2016/${SET}

cat *.xml | grep "ARN=" > arns.out

sed -i 's/  <ags:resource ags:ARN="//g' arns.out
sed -i 's/">//g' arns.out

filename=arns.out

while read -r line
do
	url="http://agris.fao.org/agris-search/search.do?recordID=$line"

        curl ${url} > tmp
        lines="$(cat tmp | grep 404 | wc -l)"

	echo ${lines}

        if [ "$lines" = 1 ]; then
                echo $line >> not.out
        else
                echo "false"
        fi

	#break

done < "$filename"

