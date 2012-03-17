#!/bin/bash

## Get absolute path to this srcidr
if ! srcdir="$(readlink -f "$(dirname "$0")")"; then
  echo "[${0}:${LINENO}] [Error] could not determine the absolute path to tests/rewrite."
  echo "$srcdir"
  exit 1
else
  : echo $srcdir

  for testdir in $(find "$srcdir"/* -type d); do
      relative_testdir="${testdir#$srcdir/}/"
      echo "+ $relative_testdir"  # relative test directory

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

