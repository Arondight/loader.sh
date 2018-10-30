#!/usr/bin/env sh
# ==============================================================================
# A simple shell script loader for modular scripting, Support many shells
# that were derived from bourne shell include bash, ksh93 and zsh.
# ==============================================================================
#                               Copyright (c) 2018 秦凡东 (Qin Fandong)
# ==============================================================================
__load_error ()
{
  action="$1" && shift
  target="$1" && shift
  message="$1" && shift

  echo "loader.sh> Failed to ${action} ${target}: ${message}." >&2
  return "$?"
}

load_path_show ()
{
  echo "${__load_paths[@]}"
  return "$?"
}

load_path ()
{
  paths=("$@")

  for p in ${paths[@]}
  do
    if [ ! -d "$p" ]
    then
      __load_error 'set' "$p" 'not found'
      exit 1
    fi

    p=$(readlink -f "$p")
    __load_paths[$p]="$p"
  done

  return "$?"
}

load ()
{
  scripts=("$@")

  for s in ${scripts[@]}
  do
    sname=$(basename "$s")

    if [ ! -r "$s" ]
    then
      s=$(find "${__load_paths[@]}" -type f -name $(basename "$s") | head -1)

      if [ -z "$s" ]
      then
        __load_error 'load' "$sname" 'not found'
        exit 1
      fi
    fi

    s=$(readlink -f "$s")

    if [ -z "${__load_scripts[${s}]+_}" ]
    then
      __load_scripts[$s]=1
      source "$s"
    fi
  done

  return "$?"
}

{
  if ! ((${#__load_scripts[@]}))
  then
    typeset -A __load_scripts=()
  fi

  if ! ((${#__load_paths[@]}))
  then
    # Here we use values for compatibility with zsh
    typeset -A __load_paths=()
  fi
}

