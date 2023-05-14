#!/bin/bash

PROGRAMNAME=TestInitialization
echo "${PROGRAMNAME}: " | sed 's/$/\\/' > build
cat ${PROGRAMNAME}.f90 \
  | grep --colour=never ^"  USE" | cut -c 7- | cut -d, -f1 > dependenciesList
while read p
do echo $"\t$p.o " | sed 's/$/\\/' >> build
done < dependenciesList
