! utils_fun.f90 - a unit test suite for utils.f90
!
! funit generated this file from utils.fun
! at Mon Dec 24 17:57:51 -0500 2007

module utils_fun

 use utils

 implicit none

 logical :: noAssertFailed

 public :: test_utils

 private

 integer :: numTests          = 0
 integer :: numAsserts        = 0
 integer :: numAssertsTested  = 0
 integer :: numFailures       = 0

 contains

 subroutine eq

  ! IsTrue assertion
  numAsserts = numAsserts + 1
  if (noAssertFailed) then
    if (.not.(eq(0.0, 0.0)) then
      print *, " *IsTrue failed* in test eq &
              &[utils.fun:2]"
      print *, "  ", "eq(0.0, 0.0 is not true"
      print *, ""
      noAssertFailed = .false.
      numFailures    = numFailures + 1
    else
      numAssertsTested = numAssertsTested + 1
    endif
  endif
  ! IsTrue assertion
  numAsserts = numAsserts + 1
  if (noAssertFailed) then
    if (.not.(eq(0, 0.9))) then
      print *, " *IsTrue failed* in test eq &
              &[utils.fun:3]"
      print *, "  ", "eq(0, 0.9) is not true"
      print *, ""
      noAssertFailed = .false.
      numFailures    = numFailures + 1
    else
      numAssertsTested = numAssertsTested + 1
    endif
  endif
  ! IsTrue assertion
  numAsserts = numAsserts + 1
  if (noAssertFailed) then
    if (.not.(eq(0,4,5))) then
      print *, " *IsTrue failed* in test eq &
              &[utils.fun:4]"
      print *, "  ", "eq(0,4,5) is not true"
      print *, ""
      noAssertFailed = .false.
      numFailures    = numFailures + 1
    else
      numAssertsTested = numAssertsTested + 1
    endif
  endif

  numTests = numTests + 1

 end subroutine eq


 subroutine Setup
  noAssertFailed = .true.
 end subroutine Setup


 subroutine Teardown
 end subroutine Teardown


 subroutine test_utils( nTests, nAsserts, nAssertsTested, nFailures )

  integer :: nTests
  integer :: nAsserts
  integer :: nAssertsTested
  integer :: nFailures

  continue

  call Setup
  call eq
  call Teardown

  nTests          = numTests
  nAsserts        = numAsserts
  nAssertsTested  = numAssertsTested
  nFailures       = numFailures

 end subroutine test_utils

end module utils_fun
