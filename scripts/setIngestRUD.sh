#!/bin/bash

SET=RUD
FORMAT=AGRIS
OAITARGET="http://agris.fao.org/oai"
OAIFORMAT="agrisap"

ROOT=/home/agris
HARVESTER=../harvestOnDates.jar
JAVA=/usr/bin/java
OUTPUTDIR=/home/agris/pm/automatedAMM/data/2_2016/${SET}

mkdir ${OUTPUTDIR}
mkdir ${OUTPUTDIR}/log

FROM=$1
UNTIL=$2

${JAVA} -jar ${HARVESTER} ${OAITARGET} ${OUTPUTDIR}/ ${OAIFORMAT}  ${UNTIL} ${FROM} ${SET} > ${OUTPUTDIR}/log/output.log.txt

echo "RUD done"
