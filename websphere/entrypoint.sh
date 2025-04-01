#!/bin/bash
set -e

# Create admin user if basicRegistry is used
if ! grep -q "$ADMIN_USER" "/config/server.xml"
  then
    echo "Basic user registry is not configured in server.xml"
  fi

# Start Liberty
exec /opt/ibm/wlp/bin/server run "$SERVER_NAME"
