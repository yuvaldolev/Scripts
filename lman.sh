#!/bin/bash

set -e

if [[ 1 == $# ]]; then
  MANPAGE="$1"
elif [[ 2 == $# ]]; then
  MANPAGE="$2.$1"
else
  echo "USAGE: $0 [section] <page>" 1>&2
  exit 1
fi

curl -sL "https://manpages.debian.org/stable/$MANPAGE.en.gz" \
  | groff -man -Tutf8 -rLL=$(($(tput cols)*90/100))n \
  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g" \
  | bat -l man
