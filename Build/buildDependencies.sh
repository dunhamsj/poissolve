#!/bin/bash

DIR=modules

DEPFILE=Makefile_Dependencies_${DIR}
rm -f ${DEPFILE}

# *.f90 and *.F90 files

for file in *90
  do
    echo "${file}.o: " | sed 's/$/\\/' >> ${DEPFILE}
    cat ${file} | grep --colour=never ^"  USE " \
      | cut -c 7- | cut -d, -f1 > dependenciesList
    while read p
      do echo "  $p.o " | sed 's/$/\\/' >> ${DEPFILE}
      done < dependenciesList
    rm -f dependenciesList
    echo "  ${file}" >> ${DEPFILE}
    echo "" >> ${DEPFILE}
  done
sed '$d' < ${DEPFILE} > tmpDEPFILE
mv tmpDEPFILE ${DEPFILE}
