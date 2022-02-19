#!/bin/bash
ARGS=( "$@" )
ffmpeg -f lavfi -i `python .py "${ARGS[@]:1}"` -v error -f "${ARGS[0]}" -
