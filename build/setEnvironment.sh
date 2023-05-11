#!/bin/bash

export POISSOLVE_MACHINE=$1

if [[ ${POISSOLVE_MACHINE} == dunhamsj ]]; then

    echo ""
    echo "  INFO: Setting poissolve environment for" ${POISSOLVE_MACHINE}
    echo ""
    export POISSOLVE_ROOT=/Users/dunhamsj/Work/Codes/poissolve

else

    echo ""
    echo "  ERROR: Unknown machine:" ${POISSOLVE_MACHINE}
    echo ""

fi
