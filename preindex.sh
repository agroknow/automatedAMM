#!/bin/bash


for all in AL1 BR2 BR3 BRF CO0 ES1 GE0 IN1 IN4 QV0 RU1 RU2 RU3 RUA RUC RUD RUE RUH RUK RUP RUX SK0 UA0
do

	SET="${all:0:2}"
	SETN="${all: -1}"

	echo ${SET}${SETN}
	#continue

	YEAR=$(date +%Y)
	#YEAR=2015
	cd /home/agrotest/preIndexing

	sed -i 's/ARN="\(.*\)"/ARN=""/g' /home/agris/pm/automatedAMM/data/2_2016/${SET}${SETN}/toreindex/*.xml

	./Input.sh /home/agris/pm/automatedAMM/data/2_2016/${SET}${SETN}/toreindex/ ${YEAR} ${SET} ${SETN} true agrisap
done
