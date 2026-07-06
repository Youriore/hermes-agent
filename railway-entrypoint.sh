#!/bin/bash
set -e

export HOME=/opt/data
export HERMES_HOME=/opt/data
export PORT=${PORT:-8080}

cd /opt/data
. /opt/hermes/.venv/bin/activate

echo "Starting web dashboard on port $PORT..."
hermes dashboard --host 0.0.0.0 --port $PORT --no-open &
WEB_PID=$!

echo "Starting gateway..."
hermes gateway &
GW_PID=$!

echo "Dashboard PID: $WEB_PID, Gateway PID: $GW_PID"

# Wait for both
wait $WEB_PID $GW_PID
