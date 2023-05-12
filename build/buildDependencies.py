#!/usr/bin/env python3

"""
Build Makefile_Dependencies* files for source code
"""

import os

def getDeps_file( file ):

    deps = []

    with open( file, 'r' ) as f2:

        for line in f2:

            if (  'IMPLICIT NONE' in line \
               or 'implicit none' in line ): break

            if ( 'USE ' in line ):
                stripped = line.split( 'USE' )[1][1:].split( ',' )[0] + '.o'
                deps.append( stripped )

            if ( 'use ' in line ):
                stripped = line.split( 'use' )[1][1:].split( ',' )[0] + '.o'
                deps.append( stripped )

    return deps

def getDeps( VPATH ):

    f90 = {}

    for iPath in range( len( VPATH ) ):

        nwd = VPATH[iPath]

        files = os.listdir( nwd )

        for iFile in range( len( files ) ):

            if files[iFile][-3:] == 'f90':

                f90[files[iFile]] = getDeps_file( nwd + '/' + files[iFile] )
    return f90

VPATH = os.getenv( 'VPATH' ).split( ' ' )
#VPATH \
#  = [ '/Users/dunhamsj/Work/Codes/poissolve/applications/testInitialization', \
#      '/Users/dunhamsj/Work/Codes/poissolve/modules/Initialization', \
#      '/Users/dunhamsj/Work/Codes/poissolve/modules/Library' ]

f90 = getDeps( VPATH )

keys   = list( f90.keys() )
values = list( f90.values() )

POISSOLVE_ROOT = os.getenv( 'POISSOLVE_ROOT' )

owd = os.getcwd()
#owd = POISSOLVE_ROOT + '/applications/testInitialization'

objFiles = []

for iPath in range( len( VPATH ) ):

    nwd = VPATH[iPath]

    for iKey in range( len( keys ) ):

        oldSrc = '{:}/{:}'.format( nwd, keys[iKey] )

        if not os.path.isfile( oldSrc ): continue

        newSrc = '{:}/src/{:}'.format( owd, keys[iKey] )

        os.system( 'cp {:} {:}'.format( oldSrc, newSrc ) )

        objFiles.append( '{:}'.format( keys[iKey].replace( '.f90', '.o' ) ) )

        if len( values[iKey] ) > 0:

            for iValue in range( len( values[iKey] ) ):

                objFiles.append( values[iKey][iValue] )

# Sort dictionary by dependencies

ind = [ i for i in range( len( keys ) ) ]

for iKey in range( len( keys ) ):

    for jKey in range( len( keys ) ):

        if iKey == jKey: continue

        for iValue in range( len( values[iKey] ) ):

            if values[iKey][iValue][:-2] == keys[jKey][:-4]:

                a, b = ind.index(iKey), ind.index(jKey)

                ind[b], ind[a] = ind[a], ind[b]

                break

f90 = {}

for iKey in range( len( keys ) ):

    f90[keys[ind[iKey]]] = values[ind[iKey]]

keys   = list( f90.keys() )
values = list( f90.values() )

# Generate Makefile_Poissolve_ObjectFiles

with open( POISSOLVE_ROOT \
             + '/build/Makefile_Poissolve_ObjectFiles', 'w' ) as f:

    f.write( 'POISSOLVE_OBJ = \\\n' )

    for iKey in range( len( keys ) ):

        if iKey < len( keys ) - 1:

            f.write( '  {:}{:} \\\n' \
                     .format( owd + '/obj/', \
                              keys[iKey].replace( '.f90', '.o' ) ) )

        else:

            f.write( '  {:}{:} \n' \
                     .format( owd + '/obj/', \
                              keys[iKey].replace( '.f90', '.o' ) ) )

# Generate Makefile_Poissolve_Dependencies

with open( POISSOLVE_ROOT \
             + '/build/Makefile_Poissolve_Dependencies', 'w' ) as f:
    for iKey in range( len( keys ) ):

        f.write( '{:}: \\\n'.format( keys[iKey].replace( '.f90', '.o' ) ) )

        for iValue in range( len( values[iKey] ) ):

            f.write( '  {:} \\\n'.format( values[iKey][iValue] ) )

        f.write( '  {:}\n'.format( keys[iKey] ) )

        if iKey < len( keys ) - 1: f.write( '\n' )

# Create list of object files and source files

with open( owd + '/obj/objFiles', 'w' ) as f:

    for iKey in range( len( keys ) ):

        f.write( keys[iKey].replace( '.f90','.o' ) + '\n' )

with open( owd + '/src/srcFiles', 'w' ) as f:

    for iKey in range( len( keys ) ):

        f.write( keys[iKey] + '\n' )
