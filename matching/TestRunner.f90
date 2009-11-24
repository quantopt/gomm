    
        ! TestRunner.f90 - runs fUnit test suites
        !
        ! funit generated this file on Mon Dec 24 17:57:51 -0500 2007.
    
        program TestRunner
          
  use utils_fun
    
          implicit none
    
          integer :: numTests, numAsserts, numAssertsTested, numFailures
    
          
          print *, ""
          print *, "utils test suite:"
          call test_utils &
            ( numTests, numAsserts, numAssertsTested, numFailures )
          print *, "Passed", numAssertsTested, "of", numAsserts, &
                   "possible asserts comprising",                &
                   numTests-numFailures, "of", numTests, "tests."
          
          print *, ""
    
        end program TestRunner
        
