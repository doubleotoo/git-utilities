#!/bin/bash

## Get absolute path to the top of $git-utilities
if ! top_srcdir="$(readlink -f "$(dirname "$0")/..")"; then
  echo "[${0}:${LINENO}] [Error] could not determine the absolute path to the top of \$git-utilities."
  echo "$top_srcdir"
  exit 1
else
  : echo $top_srcdir

  top_testsdir="$top_srcdir"/tests

  for testdir in $(find "$top_testsdir"/* -type d); do
      relative_testdir="${testdir#$top_srcdir/}/"
      echo "+ ${relative_testdir}"  # relative test directory

      testscript="$testdir"/test-all.sh
      if [ ! -f "$testscript" ]; then
          echo "[${0}:${LINENO}] [Error] '$testscript': No such file."
      else
          "$testscript"
          let failures=$?-100
          echo "+ $relative_testdir"
          echo "|"
          echo "'--> ($failures) FAILED"
      fi
  done
fi

