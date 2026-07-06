#!/bin/bash
set -e

export HOME=/opt/data
export HERMES_HOME=/opt/data
export PORT=${PORT:-8080}

cd /opt/data
. /opt/hermes/.venv/bin/activate

# Start gateway in background
s6-setuidgid hermes hermes gateway &
GW_PID=$!

# Start web dashboard
s6-setuidgid hermes hermes dashboard --host 0.0.0.0 --port $PORT &
WEB_PID=$!

# Wait for either to exit
wait -n $GW_PID $WEB_PID
