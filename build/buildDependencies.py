#!/usr/bin/env python3

"""
Build Makefile_Dependencies* files for source code
"""

# TODO: Read in VPATH from environment

import os

POISSOLVE_ROOT = os.getenv( 'POISSOLVE_ROOT' )
VPATH = os.getenv( 'VPATH' ).split( ' ' )

def getDeps( file ):
    deps = []
    with open( file, 'r' ) as f2:
        for line in f2:
            if 'IMPLICIT NONE' in line: break
            if '  USE' in line: deps.append( line[6:].split( ',' )[0] + '.o' )
    return deps

owd = os.getcwd()

objFiles = []
srcFiles = []

for iPath in range( len( VPATH ) ):

    nwd = VPATH[iPath]

    os.chdir( nwd )

    files = os.listdir( nwd )

    f90 = {}
    for iFile in range( len( files ) ):
        if files[iFile][-3:] == 'f90':
            deps = getDeps( nwd + '/' + files[iFile] )
            f90[files[iFile]] = deps
            srcFiles.append( files[iFile] )

    keys   = list( f90.keys() )
    values = list( f90.values() )

    makefile = 'Makefile_Dependencies_{:}' \
               .format( VPATH[iPath].split( '/' )[-1] )

    os.system( 'rm -f {:}'.format( makefile ) )

    if makefile[-1] == '.': continue

    with open( makefile, 'w' ) as f:
        for i in range( len( keys ) ):
            f.write( '{:}.o: \\\n'.format( keys[i][:-4] ) )
            if len( values[i] ) > 0:
                for j in range( len( values[i] ) ):
                    f.write( '\t{:} \\\n'.format( values[i][j] ) )
            f.write( '\t{:}\n'.format( keys[i] ) )
            if not i == len( keys ) - 1:
                f.write( '\n' )

    for i in range( len( keys ) ):
        os.system( 'cp {:} {:}/src/{:}'.format( keys[i], owd, keys[i] ) )
        objFiles.append( '{:}.o'.format( keys[i][:-4] ) )
        if len( values[i] ) > 0:
            objFiles.append( values[i][j] )

unique = []
[ unique.append(x) for x in objFiles if x not in unique ]
with open( owd + '/obj/objFiles', 'w' ) as f:
    for i in range( len( unique ) ):
        f.write( unique[i] + '\n' )
with open( owd + '/src/srcFiles', 'w' ) as f:
    for i in range( len( srcFiles ) ):
        f.write( srcFiles[i] + '\n' )
