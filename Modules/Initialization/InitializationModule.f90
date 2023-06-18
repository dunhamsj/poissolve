MODULE InitializationModule

  USE KindModule, ONLY: &
    DP
  USE UtilitiesModule, ONLY: &
    GracefulExit_poissolve
  USE PolynomialBasisModule, ONLY: &
    InitializePolynomialBasis

  IMPLICIT NONE
  PRIVATE

  PUBLIC :: InitializePoissolve
  PUBLIC :: FinalizePoissolve

  REAL(DP), PUBLIC, ALLOCATABLE :: xP(:,:,:)

CONTAINS


  SUBROUTINE InitializePoissolve &
    ( IsD, IsN, xI, xO, bD, bN, f, InterpolationScheme )

    LOGICAL , INTENT(in) :: &
      IsD(:,:,:), & ! Mesh points taking Dirichlet BC
      IsN(:,:,:)    ! Mesh points taking Neumann BC
    REAL(DP), INTENT(in) :: &
      xI(:,:,:), & ! Input mesh
      xO(:,:,:), & ! Output mesh
      bD(:,:,:), & ! Dirichlet BC
      bN(:,:,:), & ! Neumann BC
      f (:,:,:)    ! Load vector (evaluated at mesh points xI)
    CHARACTER(*), INTENT(in) :: InterpolationScheme

    INTEGER :: nNodesX(3)

    nNodesX = SHAPE( xI )

    ALLOCATE( xP(nNodesX(1),nNodesX(2),nNodesX(3)) )

    CALL InterpolateOntoPoissolveMesh( xI, xP, InterpolationScheme )

    CALL InitializePolynomialBasis( 3 )

  END SUBROUTINE InitializePoissolve


  SUBROUTINE FinalizePoissolve

    DEALLOCATE( xP )

  END SUBROUTINE FinalizePoissolve


  SUBROUTINE InterpolateOntoPoissolveMesh( xI, xP, InterpolationScheme )

    REAL(DP)    , INTENT(in)  :: xI(:,:,:)
    REAL(DP)    , INTENT(out) :: xP(:,:,:)
    CHARACTER(*), INTENT(in)  :: InterpolationScheme

    IF( TRIM( InterpolationScheme ) .EQ. 'LINEAR' )THEN

      PRINT *, 'SEE YA'

    ELSE

      CALL GracefulExit_poissolve

    END IF

  END SUBROUTINE InterpolateOntoPoissolveMesh


END MODULE InitializationModule
