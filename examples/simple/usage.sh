#!/usr/bin/env bash

ME=$(readlink -f "$0")
RDIR=$(dirname "$ME")
LOADER="${RDIR}/loader/loader.sh"
LIB1DIR="${RDIR}/lib1"
LIB2DIR="${RDIR}/lib2"
LIB1="${LIBDIR}/lib1.sh"
LIB2="${LIBDIR}/lib2.sh"

# ==============================================================================
# Set loader.sh
# ==============================================================================
# We set $LIB1IDR many times but will not store multiple
# ==============================================================================
# Load loader.sh first
source "$LOADER"
# Set directories to find scripts, current directory is always searched
load_path "$LIB1DIR"
# OK, set many directories
load_path "$LIB1DIR" "$LIB2DIR"
# Show all directories we set
load_path_show

# ==============================================================================
# Load scripts
# ==============================================================================
# We loaded lib1.sh and lib2.sh many times but only effective for the first time
# ==============================================================================
# OK, load lib1.sh with absolute path
load "$LIB1"
# OK, load lib2.sh in directories set by load_path
load $(basename "$LIB2")
# OK, load many scripts
load $(basename "$LIB1") "$LIB2"

{
  echo "run.sh: done."
}

