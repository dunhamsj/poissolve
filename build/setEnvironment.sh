#!/bin/bash

export POISSOLVE_MACHINE=$1

if   [[ ${POISSOLVE_MACHINE} == dunhamsj ]]; then

    echo ""
    echo "  INFO: Setting poissolve environment for" ${POISSOLVE_MACHINE}
    echo ""
    export POISSOLVE_ROOT=/Users/dunhamsj/Work/Codes/poissolve

elif [[ ${POISSOLVE_MACHINE} == kkadoogan ]]; then

    echo ""
    echo "  INFO: Setting poissolve environment for" ${POISSOLVE_MACHINE}
    echo ""
    export POISSOLVE_ROOT=/home/kkadoogan/Work/Codes/poissolve
    export CC=mpicc
    export FC=mpif90

else

    echo ""
    echo "  ERROR: Unknown machine:" ${POISSOLVE_MACHINE}
    echo ""

fi
