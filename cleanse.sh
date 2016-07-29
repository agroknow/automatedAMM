#!/bin/bash


#for all in AL1 BR2 BR3 BRF CO0 ES1 GE0 IN1 IN4 QV0 RU1 RU2 RU3 RUA RUC RUD RUE RUH RUK RUP RUX SK0 UA0
for all in AL1 BR2 BR3 BRF CO0 CN3 ES1 GE0 GE1 ID0 IN1 IN4 QC2 QV0 R10 R13 RU0 RU1 RU2 RU3 RUA RUC RUD RUE RUG RUH RUK RUP RUX RUZ SK0 UA0
do
	rm -r /home/agris/pm/automatedAMM/data/2_2016/${all}/toreindex/OUTPUT
	rm /home/agris/pm/automatedAMM/data/2_2016/${all}/*.xml
	rm /home/agris/pm/automatedAMM/data/2_2016/${all}/toreindex/*.xml*
	rm /home/agris/pm/automatedAMM/data/2_2016/${all}/*.xml*
done
