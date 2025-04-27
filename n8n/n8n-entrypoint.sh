#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

export N8N_SECURE_COOKIE=false
export N8N_HIRING_BANNER_ENABLED=false
export N8N_PERSONALIZATION_ENABLED=false
export N8N_VERSION_NOTIFICATIONS_ENABLED=false
export N8N_RUNNERS_ENABLED=true
export N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

CONFIG_PATH="/data/options.json"
export GENERIC_TIMEZONE="$(jq --raw-output '.timezone // empty' $CONFIG_PATH)"
export N8N_PROTOCOL="$(jq --raw-output '.protocol // empty' $CONFIG_PATH)"
export N8N_SSL_CERT="/ssl/$(jq --raw-output '.certfile // empty' $CONFIG_PATH)"
export N8N_SSL_KEY="/ssl/$(jq --raw-output '.keyfile // empty' $CONFIG_PATH)"
export N8N_CMD_LINE="$(jq --raw-output '.cmd_line_args // empty' $CONFIG_PATH)"

echo -e "${BLUE}=== Starting n8n Configuration ===${NC}"

#####################
## USER PARAMETERS ##
#####################

# REQUIRED

# Extract the values from env_vars_list
values=$(jq -r '.env_vars_list | .[]' "$CONFIG_PATH")

# Convert the values to an array
IFS=$'\n' read -r -d '' -a array <<< "$values"

# Export keys and values
for element in "${array[@]}"
do
    key="${element%%:*}"
    value="${element#*:}"
    value=$(echo "$value" | xargs) # Remove leading and trailing whitespace
    export "$key"="$value"
    echo -e "${GREEN}✓ Exported${NC} ${CYAN}${key}=${value}${NC}"
done

# IF NODE_FUNCTION_ALLOW_EXTERNAL is set, install the required packages

if [ -n "${NODE_FUNCTION_ALLOW_EXTERNAL}" ]; then
    echo -e "\n${YELLOW}Installing external packages...${NC}"
    IFS=',' read -r -a packages <<< "${NODE_FUNCTION_ALLOW_EXTERNAL}"
    for package in "${packages[@]}"
    do
        echo -e "${PURPLE}→ Installing ${package}...${NC}"
        npm install -g "${package}"
    done
fi

DATA_DIRECTORY_PATH="/data/n8n"

mkdir -p "${DATA_DIRECTORY_PATH}/.n8n/.cache"

export N8N_USER_FOLDER="${DATA_DIRECTORY_PATH}"
echo -e "${CYAN}N8N_USER_FOLDER:${NC} ${N8N_USER_FOLDER}"

INFO=$(curl -s -H "Authorization: Bearer ${SUPERVISOR_TOKEN}" http://supervisor/info)
INFO=${INFO:-'{}'}
echo -e "${CYAN}Fetched Info from Supervisor:${NC} ${INFO}"

CONFIG=$(curl -s -H "Authorization: Bearer ${SUPERVISOR_TOKEN}" http://supervisor/core/api/config)
CONFIG=${CONFIG:-'{}'}
echo -e "${CYAN}Fetched Config from Supervisor:${NC} ${CONFIG}"

ADDON_INFO=$(curl -s -H "Authorization: Bearer ${SUPERVISOR_TOKEN}" http://supervisor/addons/self/info)
ADDON_INFO=${ADDON_INFO:-'{}'}
echo -e "${CYAN}Fetched Add-on Info from Supervisor:${NC} ${ADDON_INFO}"

INGRESS_PATH=$(echo "$ADDON_INFO" | jq -r '.data.ingress_url // "/"')
echo -e "${CYAN}Extracted Ingress Path from Supervisor:${NC} ${INGRESS_PATH}"

# Get the port from the configuration
LOCAL_HA_PORT=$(echo "$CONFIG" | jq -r '.port // "8123"')

# Get the Home Assistant hostname from the supervisor info
LOCAL_HA_HOSTNAME=$(echo "$INFO" | jq -r '.data.hostname // "localhost"')
LOCAL_N8N_URL="http://$LOCAL_HA_HOSTNAME:8765"
echo -e "${CYAN}Local Home Assistant n8n URL:${NC} ${LOCAL_N8N_URL}"

# Get the external URL if configured, otherwise use the hostname and port
EXTERNAL_N8N_URL=${EXTERNAL_URL:-$(echo "$CONFIG" | jq -r ".external_url // \"$LOCAL_N8N_URL\"")}
EXTERNAL_HA_HOSTNAME=$(echo "$EXTERNAL_N8N_URL" | sed -e "s/https\?:\/\///" | cut -d':' -f1)
echo -e "${CYAN}External Home Assistant n8n URL:${NC} ${EXTERNAL_N8N_URL}"

export N8N_PATH=${N8N_PATH:-"${INGRESS_PATH}"}
export N8N_EDITOR_BASE_URL=${N8N_EDITOR_BASE_URL:-"${EXTERNAL_N8N_URL}${N8N_PATH}"}
export WEBHOOK_URL=${WEBHOOK_URL:-"http://${LOCAL_HA_HOSTNAME}:8081"}

echo -e "\n${BLUE}=== Final Configuration ===${NC}"
echo -e "${CYAN}N8N_PATH:${NC} ${N8N_PATH}"
echo -e "${CYAN}N8N_EDITOR_BASE_URL:${NC} ${N8N_EDITOR_BASE_URL}"
echo -e "${CYAN}WEBHOOK_URL:${NC} ${WEBHOOK_URL}"

###########
## MAIN  ##
###########

echo -e "\n${GREEN}=== Starting n8n ===${NC}"

if [ "$#" -gt 0 ]; then
  # Got started with arguments
  echo -e "${YELLOW}Starting with custom arguments:${NC} ${N8N_CMD_LINE}"
  exec n8n "${N8N_CMD_LINE}"
else
  # Got started without arguments
  echo -e "${YELLOW}Starting with default configuration${NC}"
  exec n8n
fi