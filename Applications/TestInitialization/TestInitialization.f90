PROGRAM TestInitialization

  USE KindModule, ONLY: &
    DP
  USE MemoryProfilingModule, ONLY: &
    WriteMemoryUsage
  USE InitializationModule, ONLY: &
    InitializePoissolve, &
    FinalizePoissolve

  IMPLICIT NONE

  INTEGER, PARAMETER :: nNodesX(3) = [ 132, 119, 12 ]

  LOGICAL , ALLOCATABLE :: IsD(:,:,:)
  LOGICAL , ALLOCATABLE :: IsN(:,:,:)

  REAL(DP), ALLOCATABLE :: xI(:,:,:)
  REAL(DP), ALLOCATABLE :: xO(:,:,:)
  REAL(DP), ALLOCATABLE :: bD(:,:,:)
  REAL(DP), ALLOCATABLE :: bN(:,:,:)
  REAL(DP), ALLOCATABLE :: f (:,:,:)

  INTEGER        :: ounit = 100
  CHARACTER(128) :: Label, FileName
  INTEGER        :: iCycle = 420
  REAL(DP)       :: Time = 4.60_DP
  LOGICAL, PARAMETER :: WriteMemory = .TRUE.

  ALLOCATE( IsD(nNodesX(1),nNodesX(2),nNodesX(3)) )
  ALLOCATE( IsN(nNodesX(1),nNodesX(2),nNodesX(3)) )

  ALLOCATE( xI (nNodesX(1),nNodesX(2),nNodesX(3)) )
  ALLOCATE( xO (nNodesX(1),nNodesX(2),nNodesX(3)) )

  ALLOCATE( bD (nNodesX(1),nNodesX(2),nNodesX(3)) )
  ALLOCATE( bN (nNodesX(1),nNodesX(2),nNodesX(3)) )

  ALLOCATE( f  (nNodesX(1),nNodesX(2),nNodesX(3)) )

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
         ( IsD, IsN, xI, xO, bD, bN, f, InterpolationScheme = 'LINEAR' )

  Label = 'AFTER INITIALIZE'
  CALL WriteMemoryUsage &
         ( ounit, TRIM( Label ), iCycle, Time, &
           WriteMemory_Option = WriteMemory, &
           FileName_Option = TRIM( FileName ) )

  DEALLOCATE( f   )
  DEALLOCATE( bN  )
  DEALLOCATE( bD  )
  DEALLOCATE( xO  )
  DEALLOCATE( xI  )
  DEALLOCATE( IsN )
  DEALLOCATE( IsD )

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
