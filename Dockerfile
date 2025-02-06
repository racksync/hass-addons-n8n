ARG BUILD_FROM=n8nio/n8n:latest
FROM ${BUILD_FROM}

# Copy any custom scripts or configurations if needed
# For example, if you have a custom entrypoint script:
COPY run.sh /
RUN chmod a+x /run.sh
ENTRYPOINT [ "/run.sh" ]

# Expose the port defined in the manifest
EXPOSE 5678
