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

## Workflows and Credentials Migration on First Run

If you want to pre-load workflows and credentials into n8n when the add-on is started for the first time, simply place your files in the following directories **before starting the add-on**:

- Workflows: `/config/n8n/workflows/`
- Credentials: `/config/n8n/credentials/`

**How it works:**
- On the first run, the add-on will automatically import all workflows and credentials found in these directories.
- This process only happens once, when the add-on is started for the first time (tracked by a marker file at `/share/.n8n_import_done`).
- If you add or change files in these directories after the first run, they will **not** be imported automatically. To re-import, you must delete the marker file or reset the add-on's data.

**Steps:**
1. Place your exported workflow and credential files in the appropriate directories above.
2. Start the add-on for the first time.
3. The add-on will log messages about the import process.
4. After import, your workflows and credentials will be available in n8n.

> Tip: For security, make sure to remove sensitive files from these directories after import if you do not want them to persist in plain text.
