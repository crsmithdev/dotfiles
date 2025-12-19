#!/bin/bash
set -e

if [ -z "$*" ]; then
  code .
else
  code "$@"
fi
