MODULE UtilitiesModule

  USE KindModule, ONLY: &
    DP, &
    One

  IMPLICIT NONE
  PRIVATE

  PUBLIC :: GracefulExit_poissolve

CONTAINS


  SUBROUTINE GracefulExit_poissolve

    STOP 'GracefulExit_poissolve'

  END SUBROUTINE GracefulExit_poissolve

END MODULE UtilitiesModule
