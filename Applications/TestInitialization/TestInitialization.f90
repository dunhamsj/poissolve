PROGRAM TestInitialization

  USE KindModule, ONLY: &
    DP
  USE InitializationModule, ONLY: &
    InitializePoissolve

  IMPLICIT NONE

  INTEGER :: iX_B0(3), iX_E0(3)
  REAL(DP), ALLOCATABLE :: f(:,:,:,:)

  INTEGER :: nMF = 13

  iX_B0 = [ 1, 1, 1 ]
  iX_E0 = [ 10, 1, 1 ]

  ALLOCATE( f(iX_B0(1):iX_E0(1),iX_B0(2):iX_E0(2),iX_B0(3):iX_E0(3),1:nMF) )

  CALL InitializePoissolve( iX_B0, iX_E0, f )

  DEALLOCATE( f )

END PROGRAM TestInitialization
