FROM quay.io/wildfly/wildfly:latest

ENV WILDFLY_HOME /opt/jboss/wildfly
ENV WILDFLY_USER=admin
ENV WILDFLY_PASS=admin123

USER root
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
USER jboss

EXPOSE 8080 9990
ENTRYPOINT ["/entrypoint.sh"]
