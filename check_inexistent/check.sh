#!/bin/bash

SET=$1

cd /home/agris/pm/automatedAMM/data/2_2016/${SET}
mkdir toreindex

rm not.out

cat *.xml | grep "ARN=" > arns.out

sed -i 's/  <ags:resource ags:ARN="//g' arns.out
sed -i 's/">//g' arns.out

filename=arns.out

while read -r line
do
	#break
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

sed -i 's/\r$//g' not.out

filename=not.out
cwd=$(pwd)
rm tmp
while read -r line
do
	#line="${line//[$'\t\r\n ']}"
	#echo "grep -Ril $line /home/agris/pm/automatedAMM/data/2_2016/$SET/ | grep oai | sed -n 's/\/home\/agris\/pm\/automatedAMM\/data\/2_2016\/$SET\///p'"
	#break

	#file="$(grep -Ril $line /home/agris/pm/automatedAMM/data/2_2016/$SET/ | grep oai | sed -n 's/\/home\/agris\/pm\/automatedAMM\/data\/2_2016\/$SET\///p')"
	#echo ${file}

	#grep -Ril ${line} /home/agris/pm/automatedAMM/data/2_2016/${SET}/ | grep oai | sed -n 's/\/home\/agris\/pm\/automatedAMM\/data\/2_2016\/${SET}\///p' > tmp
	#file="$(cat tmp)"

	#file="$(grep -Ril $line /home/agris/pm/automatedAMM/data/2_2016/$SET/ | grep oai | sed -n \"s/\/home\/agris\/pm\/automatedAMM\/data\/2_2016\/$SET\///p\")"

	grep -Ril ${line} /home/agris/pm/automatedAMM/data/2_2016/$SET/ | grep oai | sed -n "s/\/home\/agris\/pm\/automatedAMM\/data\/2_2016\/$SET\///p" > tmp
	file="$(cat tmp)"
	#echo 'Executed.. :('
	#grep -Ril ${line} /home/agris/pm/automatedAMM/data/2_2016/$SET/ | grep oai

	echo ${file}
	#break

	rm tmp
	#break

        cp -b ${file} toreindex/
done < "$filename"
#rm tmp
