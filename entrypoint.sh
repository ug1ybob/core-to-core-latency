#!/usr/bin/env bash

get_index() {
  local arrName=$1[@]
  local theArr=("${!arrName}")
  for i in "${!theArr[@]}"; do
    if [[ "${theArr[$i]}" = "${2}" ]]; then
      echo "${i}";
    fi
  done
}

del_param() {
  local theArr
  declare -n theArr=$1
  theArr=( "${theArr[@]/"$2"/}" )
}

del_pair() {
  local theArr
  declare -n theArr=$1
  local index
  index="$(get_index "$1" "$2")"
  if [ -n "$index" ]; then
    del_param "$1" "$2"
    ((++index))
    del_param "$1" "${theArr[$index]}"
  fi
}

clear_arr() {
  local theArr
  declare -n theArr=$1
  for i in "${!theArr[@]}"; do
    [[ -z ${theArr[i]} ]] && unset "theArr[i]";
  done
}

argsArr=( "$@" )
del_pair argsArr "--expression"
del_pair argsArr "--title"
del_pair argsArr "--subtitle"
del_param argsArr "--yticks"
del_pair argsArr "--figsize"
if [[ "$*" == *"--png"* ]]; then
  del_param argsArr "--csv"
  del_param argsArr "--png"
fi
clear_arr argsArr

c2pArgsArr=( "$@" )
del_pair c2pArgsArr "-b"
del_pair c2pArgsArr "--bench"
del_pair c2pArgsArr "-c"
del_pair c2pArgsArr "--cores"
del_param c2pArgsArr "--csv"
del_param c2pArgsArr "--png"
clear_arr c2pArgsArr

if [[ "$*" == *"--png"* ]]; then
  core-to-core-latency --csv "${argsArr[@]}" |ctcl2png "${c2pArgsArr[@]}"
else
  core-to-core-latency "${argsArr[@]}"
fi

if [[ "$*" == *"-h"* ]]; then
  echo "        --png              Outputs the mean latencies in PNG format on stdout"
  ctcl2png --help |tail -9 |sed 's/^/      /'
fi
