PROGRAM TestInitialization

  USE KindModule, ONLY: &
    DP
  USE MemoryProfilingModule, ONLY: &
    WriteMemoryUsage
  USE InitializationModule, ONLY: &
    InitializePoissolve, &
    FinalizePoissolve

  IMPLICIT NONE

  INTEGER, PARAMETER :: nX(3)      = [ 10, 1, 1 ]
  INTEGER, PARAMETER :: nNodesX(3) = [ 3, 1, 1 ]

  REAL(DP), ALLOCATABLE :: X1_C(:)
  REAL(DP), ALLOCATABLE :: X2_C(:)
  REAL(DP), ALLOCATABLE :: X3_C(:)
  REAL(DP), ALLOCATABLE :: dX1 (:)
  REAL(DP), ALLOCATABLE :: dX2 (:)
  REAL(DP), ALLOCATABLE :: dX3 (:)

  REAL(DP), ALLOCATABLE :: f(:,:,:,:)

  INTEGER :: nDOFX

  INTEGER        :: ounit = 100
  CHARACTER(128) :: Label, FileName
  INTEGER        :: iCycle = 420
  REAL(DP)       :: Time = 4.60_DP
  LOGICAL, PARAMETER :: WriteMemory = .TRUE.

  ALLOCATE( X1_C(nX(1)) )
  ALLOCATE( X2_C(nX(2)) )
  ALLOCATE( X3_C(nX(3)) )
  ALLOCATE( dX1 (nX(1)) )
  ALLOCATE( dX2 (nX(2)) )
  ALLOCATE( dX3 (nX(3)) )

  nDOFX = PRODUCT( nNodesX )

  ALLOCATE( f(nDOFX,nX(1),nX(2),nX(3)) )

  FileName = 'memUsage.dat'

  OPEN ( ounit, FILE = TRIM( FileName ) )
  WRITE(ounit,'(A)') 'Label, rss, whm'
  CLOSE( ounit )

  Label = 'BEFORE INITIALIZE'
  CALL WriteMemoryUsage &
         ( ounit, TRIM( Label ), iCycle, Time, &
           WriteMemory_Option = WriteMemory, &
           FileName_Option = TRIM( FileName ) )

  CALL InitializePoissolve &
         ( X1_C, X2_C, X3_C, dX1, dX2, dX3, f )

  Label = 'AFTER INITIALIZE'
  CALL WriteMemoryUsage &
         ( ounit, TRIM( Label ), iCycle, Time, &
           WriteMemory_Option = WriteMemory, &
           FileName_Option = TRIM( FileName ) )

  DEALLOCATE( f    )
  DEALLOCATE( dX3  )
  DEALLOCATE( dX2  )
  DEALLOCATE( dX1  )
  DEALLOCATE( X3_C )
  DEALLOCATE( X2_C )
  DEALLOCATE( X1_C )

  Label = 'BEFORE FINALIZE'
  CALL WriteMemoryUsage &
         ( ounit, TRIM( Label ), iCycle, Time, &
           WriteMemory_Option = WriteMemory, &
           FileName_Option = TRIM( FileName ) )

  CALL FinalizePoissolve

  Label = 'AFTER FINALIZE'
  CALL WriteMemoryUsage &
         ( ounit, TRIM( Label ), iCycle, Time, &
           WriteMemory_Option = WriteMemory, &
           FileName_Option = TRIM( FileName ) )

END PROGRAM TestInitialization
