#!/usr/bin/env python3

"""
Build Makefile_Dependencies* files for source code
"""

import os

def getDeps_fortran( file ):

    """
    Get dependencies for fortran source code file `file`
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

            if line_split_nospaces[0][0] == '!': continue

            if( not ( 'USE' or 'use' ) in line_split_nospaces[0] ): continue

            if line_split_nospaces[1][-1] == ',':
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

        dirFiles = os.listdir( vpath )

        for iFile in range( len( dirFiles ) ):

            if ( dirFiles[iFile][-len(suffix):] == suffix ):

                deps[dirFiles[iFile]] \
                  = getDeps_fortran( vpath + '/' + dirFiles[iFile] )

    return deps

def PermuteIndices( srcs, objs, suffix ):

    ind = [ i for i in range( len( srcs ) ) ]

    for iSrc in range( len( srcs ) ):
       for jSrc in range( len( srcs ) ):

            if jSrc <= iSrc: continue

            ModFile_iSrc = srcs[iSrc][:-(len(suffix)+1)]
            ModFile_jSrc = srcs[jSrc][:-(len(suffix)+1)]

            if not ModFile_jSrc in objs[iSrc]:
                continue
            else:
                ind[jSrc], ind[iSrc] = ind[iSrc], ind[jSrc]

    return ind

def makeDictionary( VPATH, suffix ):

    deps = getDeps( VPATH, suffix )

    srcs = list( deps.keys  () )
    objs = list( deps.values() )

    # Sort dictionary by dependencies: least dependencies first

    ind = PermuteIndices( srcs, objs, suffix )

    deps_new = {}

    for iSrc in range( len( ind ) ):

        deps_new[srcs[ind[iSrc]]] = objs[ind[iSrc]]

    deps = deps_new
    srcs = list( deps.keys  () )
    objs = list( deps.values() )

    deps_new = {}

    for iSrc in range( len( srcs ) ):

        deps_new[srcs[iSrc]] = objs[iSrc]

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

                f.write( '  {:}{:} \\\n' \
                         .format( objDir, srcs[iSrc].replace( '.f90', '.o' ) ) )
            else:

                f.write( '  {:}{:}\n' \
                         .format( objDir, srcs[iSrc].replace( '.f90', '.o' ) ) )

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

#VPATH2 = os.getenv( 'VPATH2' ).split( ' ' )

VPATH  = os.getenv( 'VPATH' ).split( ' ' )
BLDDIR = os.getenv( 'BLDDIR' )

#VPATH  = [ POISSOLVE_ROOT + '/Modules/Library', \
#           POISSOLVE_ROOT + '/Modules/Initialization' ]
#BLDDIR = POISSOLVE_ROOT + '/Applications/TestInitialization/tmp_build_dir'

os.system( 'rm -rf {:}'.format( BLDDIR ) )
os.system( 'mkdir {:}'.format( BLDDIR ) )
os.system( 'mkdir {:}/obj'.format( BLDDIR ) )
os.system( 'mkdir {:}/src'.format( BLDDIR ) )

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
