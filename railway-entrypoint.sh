#!/bin/bash
set -x

export HOME=/opt/data
export HERMES_HOME=/opt/data
export PORT=${PORT:-8080}

cd /opt/data
. /opt/hermes/.venv/bin/activate

echo "=== PORT=$PORT ==="
echo "=== Starting gateway in background ==="
hermes gateway > /tmp/gateway.log 2>&1 &
GW_PID=$!
echo "Gateway PID: $GW_PID"

echo "=== Starting dashboard ==="
hermes dashboard --host 0.0.0.0 --port $PORT --no-open --skip-build > /tmp/dashboard.log 2>&1 &
DASH_PID=$!
echo "Dashboard PID: $DASH_PID"

sleep 5
echo "=== Dashboard log ==="
cat /tmp/dashboard.log
echo "=== Gateway log ==="
cat /tmp/gateway.log

wait $DASH_PID
