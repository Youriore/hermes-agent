#!/bin/bash
set -x

export HOME=/opt/data
export HERMES_HOME=/opt/data
export PORT=${PORT:-8080}

cd /opt/data
. /opt/hermes/.venv/bin/activate

echo "=== Hermes Railway Starting ==="
echo "PORT=$PORT"
echo "HOME=$HOME"
echo "HERMES_HOME=$HERMES_HOME"

echo "Starting gateway in background..."
hermes gateway > /tmp/gw.log 2>&1 &
GW_PID=$!

echo "Starting dashboard on port $PORT..."
hermes dashboard --host 0.0.0.0 --port $PORT --no-open --skip-build > /tmp/dash.log 2>&1 &
DASH_PID=$!

echo "Dashboard PID=$DASH_PID, Gateway PID=$GW_PID"
sleep 5
echo "=== Dashboard log ==="
cat /tmp/dash.log 2>/dev/null || echo "(no dashboard log)"
echo "=== Gateway log ==="
cat /tmp/gw.log 2>/dev/null | tail -20 || echo "(no gateway log)"

# Keep running - wait for both
while kill -0 $DASH_PID 2>/dev/null && kill -0 $GW_PID 2>/dev/null; do
    sleep 5
done

echo "One process exited. Dashboard alive: $(kill -0 $DASH_PID 2>/dev/null && echo yes || echo no)"
echo "Gateway alive: $(kill -0 $GW_PID 2>/dev/null && echo yes || echo no)"
