#!/usr/bin/with-contenv bash
set -e

# Optionally, print out configuration for debugging
echo "Starting n8n..."
if [ "${N8N_BASIC_AUTH_ACTIVE}" = "true" ]; then
  echo "Basic authentication is enabled."
fi

# Execute the default command from the n8n image
exec n8n
