MODULE InitializationModule

  USE KindModule, ONLY: &
    DP

  IMPLICIT NONE
  PRIVATE

  PUBLIC :: InitializePoissolve
  PUBLIC :: FinalizePoissolve

CONTAINS


  SUBROUTINE InitializePoissolve &
    ( X1_C, X2_C, X3_C, dX1, dX2, dX3, f )

    REAL(DP), INTENT(in) :: &
      X1_C(:), X2_C(:), X3_C(:), dX1(:), dX2(:), dX3(:), f(:,:,:,:)

  END SUBROUTINE InitializePoissolve


  SUBROUTINE FinalizePoissolve
  END SUBROUTINE FinalizePoissolve


END MODULE InitializationModule
