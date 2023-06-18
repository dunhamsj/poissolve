MODULE InterpolationModule

  USE KindModule, ONLY: &
    DP, &
    One

  IMPLICIT NONE
  PRIVATE

  PUBLIC :: Interpolate

CONTAINS


  SUBROUTINE Interpolate( xI, xP )

    REAL(DP), INTENT(in)  :: xI(:,:,:)
    REAL(DP), INTENT(out) :: xP(:,:,:)

  END SUBROUTINE Interpolate


END MODULE InterpolationModule
