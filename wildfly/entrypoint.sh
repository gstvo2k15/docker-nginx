#!/bin/bash
set -e

$WILDFLY_HOME/bin/add-user.sh -a -u $WILDFLY_USER -p $WILDFLY_PASS --silent || true

$WILDFLY_HOME/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 &
WILDFLY_PID=$!

until curl -s http://localhost:9990/management > /dev/null; do
  sleep 1
done

$WILDFLY_HOME/bin/jboss-cli.sh --connect <<EOF
if (outcome != success) of /core-service=management/access=authorization/role-mapping=SuperUser/include=$WILDFLY_USER:read-resource
    /core-service=management/access=authorization/role-mapping=SuperUser/include=$WILDFLY_USER:add(name="$WILDFLY_USER", type="USER")
end-if
EOF

wait $WILDFLY_PID
