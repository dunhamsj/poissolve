#!/usr/bin/env python3

"""
Build Makefile_Dependencies* files for source code
"""

import os

def getDeps_fortran( file ):

    """
    Get dependencies for fortran file `file`
    """

    deps = []

    with open( file, 'r' ) as f2:

        for line in f2:

            if (  'IMPLICIT NONE' in line \
               or 'implicit none' in line ): break

            if len( line ) <= 1: continue

            line_split = line.split( ' ' )
            line_split_nospaces = [ s for s in line_split if s != '' ]

            if len( line_split_nospaces ) <= 1: continue

            if( line_split_nospaces[0] == 'MODULE' ): continue
            if( line_split_nospaces[0] == 'module' ): continue

            if line_split_nospaces[1][-1] == ',':
                if line_split_nospaces[1][-1] == '\n':
                    deps.append( line_split_nospaces[1][:-2] )
                else:
                    deps.append( line_split_nospaces[1][:-1] )
            else:
                if line_split_nospaces[1][-1] == '\n':
                    deps.append( line_split_nospaces[1][:-1]   )
                else:
                    deps.append( line_split_nospaces[1][:]   )

    return deps

def getDeps( VPATH, suffix ):

    deps = {}

    for iPath in range( len( VPATH ) ):

        vpath = VPATH[iPath]

        files = os.listdir( vpath )

        for iFile in range( len( files ) ):

            if ( files[iFile][-len(suffix):] == suffix ):

                deps[files[iFile]] \
                  = getDeps_fortran( vpath + '/' + files[iFile] )

    return deps

def makeDictionary( VPATH, suffix ):

    deps = getDeps( VPATH, suffix )

    srcs = list( deps.keys  () )
    objs = list( deps.values() )

    # Sort dictionary by dependencies: least dependencies first

    ind = [ i for i in range( len( srcs ) ) ]

    for iSrc in range( len( srcs ) ):

        for jSrc in range( len( srcs ) ):

            if iSrc == jSrc: continue

            for iObj in range( len( objs[iSrc] ) ):

                if( objs[iSrc][iObj][:-2] == srcs[jSrc][:-(len(suffix)+1)] ):

                    a, b = ind.index(iSrc), ind.index(jSrc)

                    ind[b], ind[a] = ind[a], ind[b]

                    break

    ind = [ i for i in ind[::-1] ]

    deps_new = {}

    for iSrc in range( len( srcs ) ):

        deps_new[srcs[ind[iSrc]]] = objs[ind[iSrc]]

    return deps_new

def copyFiles( deps, VPATH, nwd, suffix ):

    srcs = list( deps.keys  () )
    objs = list( deps.values() )

    for iPath in range( len( VPATH ) ):

        vpath = VPATH[iPath]

        for iSrc in range( len( srcs ) ):

            oldSrc = '{:}/{:}'.format( vpath, srcs[iSrc] )

            if not os.path.isfile( oldSrc ): continue

            newSrc = '{:}/{:}'.format( nwd, suffix + '_' + srcs[iSrc] )

            os.system( 'cp {:} {:}'.format( oldSrc, newSrc ) )

    return

def WriteMakefile_ObjectFiles( deps, objDir ):

    srcs = list( deps.keys() )

    fileName = objDir + 'Makefile_Poissolve_ObjectFiles'

    with open( fileName, 'w' ) as f:

        f.write( 'POISSOLVE_OBJ = \\\n' )

        for iSrc in range( len( srcs ) ):

            if iSrc < len( srcs ) - 1:

                f.write( '  {:} \\\n' \
                         .format( srcs[iSrc].replace( '.f90', '.o' ) ) )
            else:

                f.write( '  {:}\n' \
                         .format( srcs[iSrc].replace( '.f90', '.o' ) ) )

def WriteMakefile_Dependencies( deps, objDir ):

    srcs = list( deps.keys  () )
    objs = list( deps.values() )

    fileName = objDir + 'Makefile_Poissolve_Dependencies'

    with open( fileName, 'w' ) as f:

        for iSrc in range( len( srcs ) ):

            f.write( '{:}{:}: \\\n' \
                     .format( objDir, srcs[iSrc].replace( '.f90', '.o' ) ) )

            for iObj in range( len( objs[iSrc] ) ):

                f.write( '  {:}{:}.o \\\n'.format( objDir, objs[iSrc][iObj] ) )

            f.write( '  {:}\n'.format( srcs[iSrc] ) )

            if iSrc < len( srcs ) - 1: f.write( '\n' )

POISSOLVE_ROOT = os.getenv( 'POISSOLVE_ROOT' )

VPATH  = os.getenv( 'VPATH' ).split( ' ' )
VPATH2 = os.getenv( 'VPATH2' ).split( ' ' )
BLDDIR     = os.getenv( 'BLDDIR' )
#VPATH = [ '/home/kkadoogan/Work/Codes/poissolve/Modules/Initialization', \
#          '/home/kkadoogan/Work/Codes/poissolve/Modules/Library', \
#          '/home/kkadoogan/Work/Codes/poissolve/Applications/TestInitialization' ]

nwd = BLDDIR + '/src'

deps_f90 = makeDictionary( VPATH, 'f90' )

copyFiles( deps_f90, VPATH, nwd, 'f90' )
WriteMakefile_ObjectFiles \
  ( deps_f90, '{:}/obj/'.format( BLDDIR) )
WriteMakefile_Dependencies \
  ( deps_f90, '{:}/obj/'.format( BLDDIR) )

#deps_f902 = makeDictionary( VPATH2, 'f90' )
#
#WriteMakefile_Dependencies \
#  ( deps_f902, \
#    '{:}/Makefile_Driver'.format( BLDDIR ) )
