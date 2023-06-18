MODULE MemoryProfilingModule

  USE KindModule, ONLY: &
    DP

  IMPLICIT NONE
  PRIVATE

  PUBLIC :: WriteMemoryUsage

CONTAINS


  SUBROUTINE WriteMemoryUsage &
    ( ounit, Label, iCycle, Time, WriteMemory_Option, FileName_Option )

    !-----------------------------------------------------------------------
    !
    !    Author:       O.E.B. Messer, ORNL
    !                  W.R. Hix, ORNL
    !
    !    Date:         8/12/11
    !
    !    Purpose:
    !      To determine and output the current memory usage
    !-----------------------------------------------------------------------

    !-----------------------------------------------------------------------
    !         Input Variables
    !-----------------------------------------------------------------------

    INTEGER         , INTENT(IN) :: ounit  ! Logical unit number for output
    CHARACTER(LEN=*), INTENT(IN) :: Label  ! Location label
    INTEGER         , INTENT(IN) :: iCycle ! Cycle number of simulation
    REAL(DP)        , INTENT(IN) :: Time   ! Current time of simulation
    LOGICAL         , INTENT(IN), OPTIONAL :: WriteMemory_Option
    CHARACTER(LEN=*), INTENT(IN), OPTIONAL :: FileName_Option

    !-----------------------------------------------------------------------
    !         Local Variables
    !-----------------------------------------------------------------------

    CHARACTER(LEN=80) :: Line     ! Line from file
    INTEGER(KIND=8)   :: hwm, rss ! memory sizes
    INTEGER           :: istat    ! open file flag
    INTEGER           :: iunit    ! Logical unit number for input
    LOGICAL           :: WriteMemory
    CHARACTER(LEN=80) :: FileName

    WriteMemory = .FALSE.
    IF( PRESENT( WriteMemory_Option ) ) &
      WriteMemory = WriteMemory_Option

    FileName = 'memUsage.dat'
    IF( PRESENT( FileName_Option ) ) &
      FileName = FileName_Option

    IF( WriteMemory )THEN

      !-----------------------------------------------------------------------
      !         Find current memory size and high water mark
      !-----------------------------------------------------------------------

      hwm = 0
      rss = 0

      OPEN( NEWUNIT = iunit, FILE = '/proc/self/status', &
            STATUS = 'old', IOSTAT = istat )

      DO WHILE( .TRUE. )

        READ( iunit, '(A)', IOSTAT = istat ) Line

        IF( istat .LT. 0 ) EXIT

        IF( Line(1:6) .EQ. 'VmHWM:' ) READ( Line(8:80), * ) hwm

        IF( Line(1:6) .EQ. 'VmRSS:' ) READ( Line(8:80), * ) rss

      END DO

      CLOSE( iunit )

      !-----------------------------------------------------------------------
      !         Ouput current memory size and high water mark
      !-----------------------------------------------------------------------

      IF( ounit .NE. 6 ) &
        OPEN( ounit, FILE = TRIM( FileName ), POSITION = 'APPEND' )

      WRITE( ounit, '(A25,I9.8,I9.8)' ) TRIM( Label ), rss, hwm

      IF( ounit .NE. 6 ) CLOSE( ounit )

    END IF ! WriteMemory

  END SUBROUTINE WriteMemoryUsage


END MODULE MemoryProfilingModule
