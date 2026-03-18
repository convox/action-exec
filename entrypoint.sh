#!/bin/sh
set -e

if [ -z "${INPUT_RACK:-}" ]; then
  echo "::error::Required input 'rack' is missing"
  exit 1
fi
if [ -z "${INPUT_APP:-}" ]; then
  echo "::error::Required input 'app' is missing"
  exit 1
fi
if [ -z "${INPUT_SERVICE:-}" ]; then
  echo "::error::Required input 'service' is missing"
  exit 1
fi
if [ -z "${INPUT_COMMAND:-}" ]; then
  echo "::error::Required input 'command' is missing"
  exit 1
fi

export CONVOX_RACK=$INPUT_RACK

echo "Running command on the application."

CONVOX_ARGS="--app $INPUT_APP --rack $INPUT_RACK"

# Use 'script' to allocate a pseudo-TTY. GitHub Actions runners provide a
# non-interactive terminal, which causes convox exec to disable TTY mode.
# Without TTY mode the WebSocket/SPDY connection to the Kubernetes pod hangs
# or fails to return output.
#
# Flags: -q (quiet), -e (return child exit code), -c (run command)
# /dev/null discards the typescript recording file.
set +e
script -qec "convox exec $INPUT_SERVICE '$INPUT_COMMAND' $CONVOX_ARGS" /dev/null
exit_code=$?
set -e

echo "Command completed with exit code: $exit_code"
exit $exit_code