# Use a specific version of WildFly instead of "latest"
FROM quay.io/wildfly/wildfly:35.0.1.Final-jdk17

# Define WildFly home and credentials
ENV WILDFLY_HOME=/opt/jboss/wildfly
ENV WILDFLY_USER=admin
ENV WILDFLY_PASS=admin123

# Switch to root to install scripts and set permissions
USER root

# Copy the custom entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Ensure the script is executable
RUN chmod +x /entrypoint.sh

# Switch back to the default user
USER jboss

# Expose HTTP and management ports
EXPOSE 8080 9990

# Define container health check for management interface
HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD curl -fs http://localhost:9990/management || exit 1

# Start WildFly through the custom entrypoint
ENTRYPOINT ["/entrypoint.sh"]
