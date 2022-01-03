#!/bin/bash
# ----------------------------------------------------------------------------------------
# PETSc download, build and install script.
#
# Author:          Johannes Gebert »gebert@hlrs.de«
# Created: on :    14.09.2021
# Last edit:       14.09.2021
# ----------------------------------------------------------------------------------------
#
# Requirements:
# GCC
# GNU Make
# tar
# wget
# Ensure, your OS is allowed to run this script:
# »sudo chmod +x PETSc_install.sh«
#
# ----------------------------------------------------------------------------------------
#
# usage: »./<this script>«
# The Script will ask for sudo. It's required to create the target directory at /opt
# ----------------------------------------------------------------------------------------
#
# Modify only in case you know what you like to achieve :-)
# ----------------------------------------------------------------------------------------
#
# Specify the Version of PETSc
# https://gitlab.com/petsc/petsc/-/tree/release
# https://petsc.org/release/
VERSION="3.15"
#
# Target install directory
PREF=/opt/petsc/petsc-$VERSION
# ----------------------------------------------------------------------------------------
#
# Check whether all programs and compilers are accesible
declare -a BIN=("valgrind" "gfortran" "gcc" "g++" "git" "make")
#
echo "----------------------------------------------------------------------------------------"
echo "The installation of petsc reasonably is done via its own confige/install routine.       "
echo "Therefore, this script just is an additional step to simplify the installation.         "
echo "----------------------------------------------------------------------------------------"
echo "During configuration/installation, you need to enter the target install directory:      "
echo; echo $PREF; echo
echo "----------------------------------------------------------------------------------------"
echo "Ensure to note PETSC_DIR and PETSC_ARCH!"
echo "----------------------------------------------------------------------------------------"
echo "Press any key to continue"; echo
#
# Based on https://linuxhint.com/bash_wait_keypress/
while [ true ] ; do
	read -t 2 -n 1
	if [ $? = 0 ] ; then
		break ;
	else
		echo "Waiting for the keypress"
	fi
done
#
echo "----------------------------------------------------------------------------------------"

# sleep 3

for i in "${BIN[@]}"
do
   which "$i" > /dev/null 2> /dev/null
   if [ $? -eq 1 ]; then
	echo "Please make »"$i"« available."
	exit=1
   fi
done

builddir=$PWD/build_petsc

git clone -b release https://gitlab.com/petsc/petsc.git $builddir

cd $builddir

./configure -prefix=$PREF                      								\
            --with-fortran-datatypes --with-fortran-interfaces=1            \
            --with-x=0  --with-64-bit-indices=1                             \
            CC_LINKER_FLAGS="-O3 -Wall" CFLAGS="-O3 -Wall" LDFLAGS="-O3"    \
            CXXFLAGS="-O3 -Wall" CXX_LINKER_FLAGS="-O3 -Wall"               \
            FFLAGS="-O3 -Wall" FC_LINKER_FLAGS="-O3 -Wall"                  \
            --with-precision=double --with-fortran-datatypes                \
            --with-shared-libraries=0 

