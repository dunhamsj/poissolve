#!/usr/bin/env python3

"""
Build Makefile_Dependencies* files for source code
"""

import os

POISSOLVE_ROOT = os.getenv( 'POISSOLVE_ROOT' )
VPATH          = os.getenv( 'VPATH' ).split( ' ' )
#VPATH = [ '/Users/dunhamsj/Work/Codes/poissolve/applications/testInitialization', \
#          '/Users/dunhamsj/Work/Codes/poissolve/modules/Initialization', \
#          '/Users/dunhamsj/Work/Codes/poissolve/modules/Library' ]

def getDeps( file ):
    deps = []
    with open( file, 'r' ) as f2:
        for line in f2:
            if 'IMPLICIT NONE' in line: break
            if '  USE ' in line:
                deps.append( line[6:].split( ',' )[0] + '.o' )
    return deps

owd = os.getcwd()
#owd = POISSOLVE_ROOT + '/applications/testInitialization'

objFiles = []
srcFiles = []

f90 = {}
for iPath in range( len( VPATH ) ):

    nwd = VPATH[iPath]

    files = os.listdir( nwd )

    for iFile in range( len( files ) ):
        if files[iFile][-3:] == 'f90':
            deps = getDeps( nwd + '/' + files[iFile] )
            f90[files[iFile]] = deps
            srcFiles.append( files[iFile] )

keys   = list( f90.keys() )
values = list( f90.values() )

for iPath in range( len( VPATH ) ):

    nwd = VPATH[iPath]

    for iKey in range( len( keys ) ):
        oldSrc = '{:}/{:}'.format( nwd, keys[iKey] )
        if not os.path.isfile( oldSrc ): continue
        newSrc = '{:}/src/{:}'.format( owd, keys[iKey] )
        os.system( 'cp {:} {:}'.format( oldSrc, newSrc ) )
        objFiles.append( '{:}.o'.format( keys[iKey][:-4] ) )
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

with open( owd + '/obj/objFiles', 'w' ) as f:
    for iKey in range( len( keys ) ):
        f.write( keys[iKey].replace( '.f90','.o' ) + '\n' )
with open( owd + '/src/srcFiles', 'w' ) as f:
    for iKey in range( len( keys ) ):
        f.write( keys[iKey] + '\n' )
