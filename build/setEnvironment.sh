#!/bin/bash

export POISSOLVE_MACHINE=$1

if   [[ ${POISSOLVE_MACHINE} == dunhamsj ]]; then

    echo ""
    echo "  INFO: Setting poissolve environment for" ${POISSOLVE_MACHINE}
    echo ""
    export CC=mpicc
    export FC=mpif90
    export FFLAGS=-g

elif [[ ${POISSOLVE_MACHINE} == kkadoogan ]]; then

    echo ""
    echo "  INFO: Setting poissolve environment for" ${POISSOLVE_MACHINE}
    echo ""
    export CC=mpicc
    export FC=mpif90
    export FFLAGS=-g

else

    echo ""
    echo "  ERROR: Unknown machine:" ${POISSOLVE_MACHINE}
    echo ""

fi
