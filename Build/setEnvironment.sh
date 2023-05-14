#!/bin/bash

export POISSOLVE_MACHINE=$1

if   [[ ${POISSOLVE_MACHINE} == dunhamsj ]]; then

    echo ""
    echo "  INFO: Setting poissolve environment for" ${POISSOLVE_MACHINE}
    echo ""
    export CC=mpicc
    export FC=mpif90
    export FFLAGS="-g \
-O0 \
-fcheck=bounds \
-fbacktrace \
-Wuninitialized \
-Wunused \
-ffpe-trap=invalid,zero,overflow,underflow \
-ffpe-summary=invalid,zero,overflow,underflow \
-fallow-argument-mismatch -finit-real=snan -ftrapv"

elif [[ ${POISSOLVE_MACHINE} == kkadoogan ]]; then

    echo ""
    echo "  INFO: Setting poissolve environment for" ${POISSOLVE_MACHINE}
    echo ""
    export CC=mpicc
    export FC=mpif90
    export FFLAGS="-g \
-O0 \
-fcheck=bounds \
-fbacktrace \
-Wuninitialized \
-Wunused \
-ffpe-trap=invalid,zero,overflow,underflow \
-ffpe-summary=invalid,zero,overflow,underflow \
-fallow-argument-mismatch -finit-real=snan -ftrapv"

else

    echo ""
    echo "  ERROR: Unknown machine:" ${POISSOLVE_MACHINE}
    echo ""

fi
