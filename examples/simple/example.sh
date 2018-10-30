#!/usr/bin/env bash

RDIR=$(dirname $(readlink -f "$0"))
LOADER="${RDIR}/loader/loader.sh"
LIBDIR="${RDIR}/lib1"

source "$LOADER"
load_path "$LIBDIR"
load 'lib1.sh'

{
  echo "example.sh: done."
}

