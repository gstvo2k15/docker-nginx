#!/bin/bash
set -e

/opt/jboss/wildfly/bin/add-user.sh "$WILDFLY_USER" "$WILDFLY_PASS" --silent || true

/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 &
WILDFLY_PID=$!

until curl -s http://localhost:9990/management > /dev/null; do
  sleep 1
done

/opt/jboss/wildfly/bin/jboss-cli.sh --connect --commands="/core-service=management/access=authorization/role-mapping=SuperUser/include=user-admin:add(name=${WILDFLY_USER})" || true

wait $WILDFLY_PID
