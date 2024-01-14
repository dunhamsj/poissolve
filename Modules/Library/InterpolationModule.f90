MODULE InterpolationModule

  USE KindModule, ONLY: &
    DP, &
    One

  IMPLICIT NONE
  PRIVATE

  PUBLIC :: Interpolate_Linear

CONTAINS


  SUBROUTINE Interpolate_Linear( xI, xP, fI, fP )

    REAL(DP), INTENT(in)  :: xI(:,:,:,:), xP(:,:,:,:), fI(:,:,:)
    REAL(DP), INTENT(out) :: fP(:,:,:)

    INTEGER :: iX1, iX2, iX3, iX_B(3), iX_E(3), iDimX

    REAL(DP) :: xI_L(3), xI_H(3), fI_L(3), fI_H(3)

    iX_B = LBOUND( fP )
    iX_E = UBOUND( fP )

    ! --- Loop over poissolve mesh ---

    DO iX3 = iX_B(3), iX_E(3)
    DO iX2 = iX_B(2), iX_E(2)
    DO iX1 = iX_B(1), iX_E(1)

      DO iDimX = 1, 1

        CALL Locate( iDimX, xP(:,iX1,iX2,iX3), xI, xI_L, xI_H, fI_L, fI_H )

        fP(iX1,iX2,iX3) &
          = ( fI_H(iDimX) - fI_L(iDimX) ) / ( xI_H(iDimX) - xI_L(iDimX) ) &
              * ( xP(iDimX,iX1,iX2,iX3) - xI_L(iDimX) ) + fI_L(iDimX)

      END DO


    END DO
    END DO
    END DO

  END SUBROUTINE Interpolate_Linear


  SUBROUTINE Locate( iDimX, xP, xI, xI_L, xI_H, fI_L, fI_H )

    INTEGER , INTENT(in)  :: iDimX
    REAL(DP), INTENT(in)  :: xP(3), xI(:,:,:,:)
    REAL(DP), INTENT(out) :: xI_L(3), xI_H(3), fI_L(3), fI_H(3)

    INTEGER :: iX1, iX2, iX3, iX_B(3), iX_E(3)

    iX_B = LBOUND( xI(iDimX,:,:,:) )
    iX_E = UBOUND( xI(iDimX,:,:,:) )

    ! --- Loop over input mesh ---

    DO iX3 = iX_B(3), iX_E(3)
    DO iX2 = iX_B(2), iX_E(2)
    DO iX1 = iX_B(1), iX_E(1)

      xI_L = 1
      xI_H = 1
      fI_L = 1.0_DP
      fI_H = 2.0_DP

    END DO
    END DO
    END DO

  END SUBROUTINE Locate


END MODULE InterpolationModule
