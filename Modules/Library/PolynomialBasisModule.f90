MODULE PolynomialBasisModule

  USE KindModule, ONLY: &
    DP, &
    One

  IMPLICIT NONE
  PRIVATE

  PUBLIC :: InitializePolynomialBasis
  PUBLIC :: FinalizePolynomialBasis

CONTAINS


  SUBROUTINE InitializePolynomialBasis( nNodes )

    INTEGER, INTENT(in) :: nNodes

  END SUBROUTINE InitializePolynomialBasis


  SUBROUTINE FinalizePolynomialBasis
  END SUBROUTINE FinalizePolynomialBasis


  ! --- PRIVATE ---


  REAL(DP) FUNCTION Lagrange( eta, etaG, i )

    REAL(DP), INTENT(in) :: eta, etaG(:)
    INTEGER , INTENT(in) :: i

    Lagrange = One

    RETURN
  END FUNCTION Lagrange

END MODULE PolynomialBasisModule
