#!/bin/bash
set -e

export HOME=/opt/data
export HERMES_HOME=/opt/data

cd /opt/data
. /opt/hermes/.venv/bin/activate

exec hermes gateway
