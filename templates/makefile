# ------------------------------------------------------------------------------
# Makefile to build the <Program>
#
# Author:    Johannes Gebert - HLRS - NUM - gebert@hlrs.de
# Date:      25.04.2021
# Last edit: 28.12.2021
#
# For use of make visit: https://www.gnu.org/software/make/
# ------------------------------------------------------------------------------
trgt_vrsn="vx.y.z"
bin_name="abcd"
long_name="Some Programm Foo Bar"
# ------------------------------------------------------------------------------
ifeq ($(PROVIDES_GIT),YES)
# Get git hash https://jblevins.org/log/vc
	rev = $(shell git rev-parse HEAD)
else
	rev = NO_GIT_REPOSITORY
endif
# -----------------------------------------------------------------------------
# Check for environment
check-env:
ifeq ($(SYS_ENV),)
	@echo "-----------------------------------------------"
	@echo "-- Please source environment.sh <system> first."
	@echo "-----------------------------------------------"
else
	@echo "-----------------------------------------------"
	@echo "-- Environment to build for: "$(SYS_ENV)
	@echo "-----------------------------------------------"
	$(MAKE) all
endif
# ------------------------------------------------------------------------------
# Build path
build_path = $(CURDIR)
export build_path
#
# ------------------------------------------------------------------------------
# Directories
subtree_path= $(build_path)/central_src/
#
subtree_obj_dir = $(subtree_path)/obj/
#
mod_dir   = $(build_path)/mod/
obj_dir   = $(build_path)/obj/
lib_dir   = $(build_path)/lib/
bin_dir   = $(build_path)/bin/
f-src_dir = $(build_path)/f-src/
ext_f-src = $(build_path)/f-src/ext-src_
#
# Directory for documentation
doc_dir  = $(build_path)/doc/
html_dir = $(build_path)/html/
tex_dir  = $(build_path)/latex/
#
# ------------------------------------------------------------------------------
# File extensions and suffixes
mod_ext = .mod
obj_ext = .o
sho_ext = .so
f90_ext = .f90
bin_suf = _x86_64
# ------------------------------------------------------------------------------
clean_cmd = rm -f
# ------------------------------------------------------------------------------
# Compilers
#ifeq($(strip $(trgt_arch)) ,"julius" )
  compiler = "mpif90"
#endif
#ifeq($(strip $(trgt_arch)) ,"hawk" )
#  compiler = "mpif90"
#endif
export compiler
# ------------------------------------------------------------------------------
# Programming Environment - gnu, LLVM
PE = gnu
# ------------------------------------------------------------------------------
# Compile flags GNU Compiler
ifeq ($(PE),gnu)
   c_flags_f90 = -J$(mod_dir) -I$(mod_dir) \
				-g \
				-o \
				-O3 \
				-fbacktrace \
				-fbounds-check \
				-fbackslash \
				-Wno-conversion \
				-Wall
endif
# ------------------------------------------------------------------------------
# Executable
main_bin = $(bin_dir)$(bin_name)_$(trgt_vrsn)$(bin_suf)

# ------------------------------------------------------------------------------
# Generate objects
#
f-objects = $(subtree_obj_dir)mod_global_std$(obj_ext)\
			$(subtree_obj_dir)mod_strings$(obj_ext)\
			$(subtree_obj_dir)mod_messages_errors$(obj_ext) \
			$(subtree_obj_dir)mod_meta$(obj_ext) \
			$(obj_dir)mod_prog_specific_1$(obj_ext)\
			$(obj_dir)mod_prog_specific_2$(obj_ext)\
			$(obj_dir)mod_prog_specific_3$(obj_ext)\
			$(obj_dir)main_program_file$(obj_ext)

# ------------------------------------------------------------------------------
# Build the subtree directory first
subtree: 
	$(MAKE) all -C $(subtree_path)

# ------------------------------------------------------------------------------
# Begin Building
all: subtree $(main_bin)  

# ------------------------------------------------------------------------------
# Module containing stuff

[some recipes]

# ------------------------------------------------------------------------------
# Main object 
[recipe of main binary]

# -----------------------------------------------------------------------------
# Final Link step of MAIN -----------------------------------------------------
$(main_bin):$(f-objects)
	@echo "----------------------------------------------------------------------------------"
	@echo '--- Write revision and git info'
	@echo "CHARACTER(LEN = scl), PARAMETER :: revision = '$(trgt_vrsn)'" > $(f-src_dir)include_f90/revision_meta$(f90_ext)
	@echo "CHARACTER(LEN = scl), PARAMETER :: hash = '$(rev)'" >> $(f-src_dir)include_f90/revision_meta$(f90_ext)
	@echo "----------------------------------------------------------------------------------"
	@echo '--- Final link step of $(long_name) executable'
	@echo "----------------------------------------------------------------------------------"
	$(compiler) $(f-objects) -o $(main_bin)
	@echo
	@echo "----------------------------------------------------------------------------------"
	@echo "-- Successfully build all."
	@echo "----------------------------------------------------------------------------------"

help:
	@echo "----------------------------------------------------------------------------------"
	@echo "$(long_name) make targets"
	@echo "Regular:       »make (all)«   - Build the $(long_name)"
	@echo "Cleaning:      »make clean«   - Remove generated files, keep the config"
	@echo "Documentation: »make docs     - Build the html and the tex documentation"
	@echo "----------------------------------------------------------------------------------"

docs: 
	@echo "----------------------------------------------------------------------------------"
	@echo "-- Beginn buiding the documentation of the $(long_name)."
	@echo "----------------------------------------------------------------------------------"
	doxygen doc/doxy.conf
	$(MAKE) pdf -C $(tex_dir)  
	@echo "----------------------------------------------------------------------------------"
	@echo "-- Successfully build the documentation of the $(long_name)."
	@echo "----------------------------------------------------------------------------------"

cleandocs:
	@echo "----------------------------------------------------------------------------------"
	@echo "-- Cleaning html documentation"
	@echo "----------------------------------------------------------------------------------"
	$(clean_cmd) $(html_dir)/*
	@echo "----------------------------------------------------------------------------------"
	@echo "-- Cleaning tex documentation"
	@echo "----------------------------------------------------------------------------------"
	$(clean_cmd) $(tex_dir)/*
	@echo "----------------------------------------------------------------------------------"
	@echo "-- Documentation removed."
	@echo "----------------------------------------------------------------------------------"
	
clean:
	@echo "----------------------------------------------------------------------------------"
	@echo "-- Cleaning module directory"
	@echo "----------------------------------------------------------------------------------"
	$(clean_cmd) $(mod_dir)*$(mod_ext)
	@echo "----------------------------------------------------------------------------------"
	@echo "-- Cleaning object directory"
	@echo "----------------------------------------------------------------------------------"
	$(clean_cmd) $(f-objects)
	@echo "----------------------------------------------------------------------------------"
	@echo "-- Cleaning MAIN binary"
	@echo "----------------------------------------------------------------------------------"
	$(clean_cmd) $(main_bin)
	@echo "----------------------------------------------------------------------------------"
	@echo "-- Cleaning completed."
	@echo "----------------------------------------------------------------------------------"
