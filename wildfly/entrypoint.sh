#!/bin/bash
set -e

echo "==> Create admin user if not exist..."
$WILDFLY_HOME/bin/add-user.sh "$WILDFLY_USER" "$WILDFLY_PASS" --silent || true

echo "==> Starting WildFly in background for manage CLI..."
$WILDFLY_HOME/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 &
WILDFLY_PID=$!

echo "==> Waitting server to start..."
until curl -s http://localhost:9990/management > /dev/null; do
  sleep 1
done

echo "==> Asign SuperUser rol to $WILDFLY_USER..."
$WILDFLY_HOME/bin/jboss-cli.sh --connect --commands="/core-service=management/access=authorization/role-mapping=SuperUser/include=user-admin:add(name=${WILDFLY_USER})" || true

# Traer el servidor al primer plano
echo "==> Execute WildFly in foreground..."
wait $WILDFLY_PID
