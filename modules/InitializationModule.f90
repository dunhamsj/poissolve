MODULE InitializationModule

  USE KindModule, ONLY: &
    DP

  IMPLICIT NONE
  PRIVATE

  PUBLIC :: InitializePoissolve

CONTAINS


  SUBROUTINE InitializePoissolve &
    ( iX_B0, iX_E0, f )

    INTEGER , INTENT(IN) :: iX_B0(3), iX_E0(3)
    REAL(DP), INTENT(in) :: f(:,:,:,:)

  END SUBROUTINE InitializePoissolve


END MODULE InitializationModule
