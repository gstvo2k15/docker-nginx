#!/bin/bash
set -e

# Create admin user if already not exist
if [ ! -f "$WILDFLY_HOME/standalone/configuration/mgmt-users.properties" ] || ! grep -q "$WILDFLY_USER=" "$WILDFLY_HOME/standalone/configuration/mgmt-users.properties"
  then
    echo -e "\n==> Include admin user..."
    $WILDFLY_HOME/bin/add-user.sh "$WILDFLY_USER" "$WILDFLY_PASS" --silent
  fi

# Execute WildFly (allow mgmt)
exec $WILDFLY_HOME/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
