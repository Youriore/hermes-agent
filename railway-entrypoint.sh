#!/bin/bash
set -e

export HOME=/opt/data
export HERMES_HOME=/opt/data
export PORT=${PORT:-8080}

cd /opt/data
. /opt/hermes/.venv/bin/activate

echo "=== Hermes Railway Starting ==="
echo "PORT=$PORT"

echo "Starting gateway in background..."
hermes gateway &
GW_PID=$!

echo "Starting dashboard on port $PORT..."
hermes dashboard --host 0.0.0.0 --port $PORT --no-open --skip-build &
DASH_PID=$!

echo "Dashboard PID=$DASH_PID, Gateway PID=$GW_PID"

# Wait for either to exit
wait -n $GW_PID $DASH_PID