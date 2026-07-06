#!/bin/bash
set -e

export HOME=/opt/data
export HERMES_HOME=/opt/data
export PORT=${PORT:-8080}

cd /opt/data
. /opt/hermes/.venv/bin/activate

# Start web dashboard in background
hermes dashboard --host 0.0.0.0 --port $PORT &
WEB_PID=$!

# Start gateway (foreground)
exec hermes gateway
