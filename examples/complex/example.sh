#!/usr/bin/env bash

RDIR=$(dirname $(readlink -f "$0"))
LOADER="${RDIR}/loader/loader.sh"
LIBDIR="${RDIR}/libs"
LIBS=($(basename -a $(find "$LIBDIR" -type f -name '*.sh' | sort)))

source "$LOADER"
load_path "$LIBDIR"
load "${LIBS[@]}"

{
  echo "example.sh: here we load ${LIBS[@]}."
  echo "example.sh: done."
}

