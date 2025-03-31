#!/bin/bash
set -e

# Create admin user if already not exist
$WILDFLY_HOME/bin/add-user.sh "$WILDFLY_USER" "$WILDFLY_PASS" --silent || true

# Execute WildFly (allow mgmt)
exec $WILDFLY_HOME/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
