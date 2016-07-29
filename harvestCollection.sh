#!/bin/bash




#SET=RUX

#for SET in AL1 BR2 BR3 BRF CO0 ES1 GE0 ID0 IN1 IN4 QC2 QV0 RU0 RU1 RU2 RU3 RUA RUC RUD RUE RUG RUH RUK RUP RUX SK0 UA0
for SET in $1
do
	FROM="1000-01-01"
	UNTIL="2016-03-15"

	cd conf/
	FROM="$(cat ${SET}.from)"
	UNTIL="$(cat ${SET}.until)"

	echo ${FROM}
	echo ${UNTIL}

	#break

	if [ -z "${FROM}" ]; then
		FROM="1000-01-01"
	fi

	if [ -z "${UNTIL}" ]; then
	        UNTIL="2016-03-15"
	fi

	NDATE=$(date +%Y-%m-%d -d "$UNTIL + 1 month")
	NUNTIL=$(date +%Y-%m-%d -d "$UNTIL + 1 day")
	#echo ${NDATE}
	#exit

	cd ../scripts/
	./setIngest${SET}.sh ${FROM} ${UNTIL}
	cd ../check_inexistent
	./check.sh ${SET}
	cd ../notify

	message="Hello"

	./sendemail.sh ${SET} /home/agris/pm/automatedAMM/data/2_2016/${SET}/log/output.log.txt ${message}

	cd ../conf
	echo ${NUNTIL} > ${SET}.from
	echo ${NDATE} > ${SET}.until

	cd /home/agris/pm/automatedAMM/

	#break

	#./Input.sh /home/agris/pm/automatedAMM/data/2_2016/AL1/toreindex/ 2016 AL 1 true

done
