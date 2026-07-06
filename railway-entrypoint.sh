#!/bin/bash
set -e

export HOME=/opt/data
export HERMES_HOME=/opt/data
export PORT=${PORT:-8080}

cd /opt/data
. /opt/hermes/.venv/bin/activate

echo "Starting gateway in background..."
hermes gateway &
GW_PID=$!

echo "Starting web dashboard on port $PORT (foreground, skip-build)..."
exec hermes dashboard --host 0.0.0.0 --port $PORT --no-open --skip-build
