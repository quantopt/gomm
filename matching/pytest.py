#!/usr/bin/python

import os, glob, re
from optparse import OptionParser


def get_file_list():    #FIXME:  add options to to currdir, path, or tree
    files = os.listdir('.')
    return glob.fnmatch.filter(files, '*.f90')

def generate(source_files):
    module_regexp = '^module (.*)'
    program_regexp = '^program (.*)'
    dependency_regexp = '^use (.*)'
    function_regexp = 'function (.*)'
    subroutine_regexp = 'subroutine (.*)'
    test_regexp = '^logical function test_(.*)\(\)'


    files = []

    for filename in source_files:
        print filename
        module = None
        program = None
        files.append(filename)
        dependencies = []
        subroutines = []
        functions = []
        tests = []
        for line in open(filename):
            line = line.strip()
            program_match = re.match(program_regexp,line)
            module_match = re.match(module_regexp, line)
            dependency_match = re.match(dependency_regexp, line)
            function_match = re.match(function_regexp, line)
            subroutine_match = re.match(subroutine_regexp, line)
            test_match = re.match(test_regexp, line)
            
            if module_match:
                module = module_match.group(1) 
            if program_match:
                program = program_match.group(1)
            if dependency_match:
                dependencies.append(dependency_match.group(1))
            if function_match:
                functions.append(function_match.group(1))
            if subroutine_match:
                subroutines.append(subroutine_match.group(1))
            if test_match:
                tests.append(test_match.group(1))
        if module:
            print "File: ", filename
            print "Module: ", module
            if dependencies:
                print "Dependencies: ", dependencies
            if functions:
                print "Function: ", functions
            if subroutines:
                print "Subroutine: ", subroutines
            if tests:
                print "Tests: ", tests
            print 
    return tests


def run():
    pass

def main():
    if (options.generate == True):
        sources =  get_file_list()
        cases = generate(sources)
 
    run()


if __name__ == "__main__":
    oParser = OptionParser()
    oParser.add_option('-g', "--generate", action="store_true", default="false", help="generate test runner")
    (options, args) = oParser.parse_args()

    main()

    
# if -g (generate)

# scan directory for *.f90

# for each f90
#      if is a module then
#            get module_name
#            get list of tests_ (logical function test_)


# open new fortran file
# create program
#      use modules from list


#      for each module
#           print "Testing module ....  "mod name""

#           print  " Testing funcname :


# compile program   g95  all that stuff -o test_runner

# ./test_runner


# file:
#     module/program/raw

    
