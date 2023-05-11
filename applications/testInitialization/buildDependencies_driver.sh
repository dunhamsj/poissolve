#!/bin/bash

PROGRAMNAME=testInitialization
echo "${PROGRAMNAME}: " | sed 's/$/\\/' > build
echo $"\t\$(poissolve) " | sed 's/$/\\/' >> build
cat ${PROGRAMNAME}.f90 \
  | grep --colour=never ^"  USE" | cut -c 7- | cut -d, -f1 > dependenciesList
while read p
do echo $"\t$p.o " | sed 's/$/\\/' >> build
done < dependenciesList
echo $"\t${PROGRAMNAME}.o" >> build
echo $"\t\$(FLINKER) \$(FLAGS) -o ${PROGRAMNAME}_${POISSOLVE_MACHINE} " \
  | sed 's/$/\\/' >> build
echo $"\t\$(poissolve) " | sed 's/$/\\/' >> build
cat ${PROGRAMNAME}.f90 \
  | grep --colour=never ^"  USE" | cut -c 7- | cut -d, -f1 > dependenciesList
while read p
do echo $"\t$p.o " | sed 's/$/\\/' >> build
done < dependenciesList
rm -f dependenciesList
echo $"\t\$(LIBRARIES)" >> build
