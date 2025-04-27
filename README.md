# n8n - Home Assistant Add-on

`n8n` (pronounced n-eight-n) a.k.a. `Nodemation` is a powerful workflow automation platform that lets you connect any app with an API without coding. It features an intuitive visual interface for creating workflows and runs securely on your own server.

## Available Versions

| Version | Description | Best For |
|---------|-------------|----------|
| `n8n` | Stable release with thoroughly tested features | Production use, stable environments |
| `n8n-nightly` | Cutting-edge build with latest features | Testing, development, early adopters |

Choose the version that best suits your needs:
- Use `n8n` for reliable, production-ready automation
- Use `n8n-nightly` to try out the latest features and improvements

## Why n8n on Home Assistant?

| Advantage | Description |
|-----------|-------------|
| 🔒 Security | Runs locally on your server, keeping sensitive data secure |
| 🏠 Home Integration | Direct integration with Home Assistant for smart home automation |
| 🔌 Low-Code Solution | Visual workflow builder for connecting apps and services |
| 🌐 API Freedom | Connect to any service with an API endpoint |
| 🚀 Real-time Processing | Execute workflows flowlessly with webhook triggers |
| 🛡️ Authentication | Protected by Home Assistant's authentication and ingress system |

# Installation

1. Add our repository to Home Assistant: `https://github.com/racksync/hass-addons-n8n`
2. Navigate to **Supervisor** -> **Add-on Store**
3. Find either:
   - `n8n` for the stable version
   - `n8n-nightly` for the cutting-edge version
4. Click "INSTALL" on your chosen version

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

Common environment variables:
| Variable | Purpose | Example |
|----------|---------|---------|
| `TIMEZONE` | Set your local timezone | `TIMEZONE: Asia/Bangkok` |
| `N8N_HOST` | n8n instance hostname | `N8N_HOST: localhost` |
| `WEBHOOK_URL` | External webhook access | `WEBHOOK_URL: https://your-tunnel.com` |
| `NODE_FUNCTION_ALLOW_EXTERNAL` | Allow external npm packages | `NODE_FUNCTION_ALLOW_EXTERNAL: moment,lodash` |
| `EXTERNAL_URL` | Nabu Casa remote URL | `EXTERNAL_URL: https://your-nabu-casa.com` |

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
- Webhook/API traffic runs on port 7123
- For external access, use [Cloudflared addon](https://github.com/brenner-tobias/addon-cloudflared)
- Set `WEBHOOK_URL` to your tunnel URL

### Remote Access
- For Nabu Casa: Set `EXTERNAL_URL` to your remote URL
- For manual setup: Configure port 5678 in the Network section

# Quick Start

1. Install the addon
2. Start it from the Home Assistant interface
3. Access n8n through the addon's Web UI
4. Begin creating your first workflow!

## Resources

- [n8n Documentation](https://docs.n8n.io)
- [Workflow Examples](https://n8n.io/workflows)
- [Available Integrations](https://n8n.io/integrations)

## Support

Having issues? [Open an issue](https://github.com/racksync/hass-addons-n8n) on our GitHub repository.

## License

This addon is published under the Apache 2 license. Original software by n8n.

## Troubleshooting

**OAuth Issues**: If you encounter a `401: Unauthorized` in the OAuth popup window, copy the URL to a new tab in your main window to complete the authorization.
