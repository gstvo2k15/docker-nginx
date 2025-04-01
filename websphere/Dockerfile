# Use a specific version of IBM WebSphere Liberty with Java 8
FROM websphere-liberty:full-java8-ibmjava

# Define Liberty server name and default credentials (can be overridden)
ENV SERVER_NAME=defaultServer
ENV ADMIN_USER=admin
ENV ADMIN_PASS=admin123

# Copy server configuration and applications
COPY server.xml /config/server.xml
COPY jvm.options /config/jvm.options
COPY apps/*.war /config/apps/

# Optional: copy and set custom entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose HTTP port
EXPOSE 9080 9443

# Define container health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD curl -fs http://localhost:9080 || exit 1

# Run Liberty server
ENTRYPOINT ["/entrypoint.sh"]
