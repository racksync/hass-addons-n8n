# Configuration

```yaml
timezone: Asia/Bangkok
env_vars_list: []
cmd_line_args: ""
```

## Required Settings

### `env_vars_list`
Add environment variables as a list in the addon configuration. Each variable should be on a new line following this format:
```yaml
env_vars_list:
  - "TIMEZONE: Asia/Bangkok"
  - "N8N_HOST: localhost"
  - "N8N_PORT: 5678"
  - "NODE_FUNCTION_ALLOW_EXTERNAL: moment,lodash"
  - "WEBHOOK_URL: https://your-tunnel-url.com"
```


[View all available environment variables](https://docs.n8n.io/hosting/environment-variables/environment-variables/)

### External Packages
To use external npm packages, add them to `env_vars_list`:
```yaml
env_vars_list:
  - "NODE_FUNCTION_ALLOW_EXTERNAL: axios,moment,lodash"
```

Multiple packages should be comma-separated without spaces.

## Network Configuration

### Webhooks and API Access
For secure external access to webhooks and the n8n API, we strongly recommend using Cloudflared:

1. Install [Cloudflared addon](https://github.com/racksync/hass-addons-suite)
2. Create a tunnel for port 7123 (webhook/API port)
3. Add the tunnel URL to your configuration:
```yaml
env_vars_list:
  - "WEBHOOK_URL: https://your-tunnel.cloudflare.com"
```

Benefits of using Cloudflared:
- 🔒 Secure HTTPS endpoint
- 🌍 Global CDN access
- 🛡️ DDoS protection
- 🔑 Zero trust security
- 🚫 No port forwarding needed

### Remote Access
- For Nabu Casa: Set `EXTERNAL_URL` to your remote URL
- For manual setup: Configure port 5678 in the Network section