#!/bin/bash

passes=0
failures=0

## Get absolute path to this srcdir
if ! srcdir="$(readlink -f "$(dirname "$0")/..")"; then
  echo "[${0}:${LINENO}] [Error] could not determine the absolute path to tests/rewrite/author_committer_info."
  echo "$srcdir"
  exit 1
else
  : echo $srcdir

  for testscript in $(find "$srcdir"/* -type f -name "*test__*" ); do
      echo "+ ${testscript#$srcdir/}"  # relative test script file
      if ! result="$("$testscript")"; then
          echo "'--> FAILURE"
          let failures++
      else
          echo "'--> SUCCESS"
          let passes++
      fi
  done
fi

cat <<-SUMMARY
|
|  Summary: ($passes) PASSED, ($failures) FAILED
|
SUMMARY

let failures+=100
exit $failures

