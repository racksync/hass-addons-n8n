# n8n - Home Assistant Add-on

`n8n` (pronounced n-eight-n) a.k.a. `Nodemation` is a powerful workflow automation platform that lets you connect any app with an API without coding. It features an intuitive visual interface for creating workflows and runs securely on your own server.

## Available Versions

| Version | Description | Best For |
|---------|-------------|----------|
| `n8n` | Stable release with thoroughly tested features | Production use, stable environments |
| `n8n-nightly` | Cutting-edge build with latest features | Testing, development, early adopters |

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


## Default Configuration - Edit in YAML

```yaml
timezone: Asia/Bangkok
env_vars_list: []
cmd_line_args: ""
```

## Example of Extra Environment Variables

Add environment variables as a list in the addon configuration. Each variable should be on a new line following this format:

```yaml
env_vars_list:
  - "N8N_HOST: localhost"
  - "N8N_PORT: 5678"
  - "N8N_PROTOCOL: http"
  - "WEBHOOK_URL: https://your-tunnel-url.com" 
  - "N8N_EDITOR_BASE_URL: http://localhost:5678"
  - "N8N_ENCRYPTION_KEY: your-secret-key"
  - "NODE_ENV: development" 
  - "N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS: true" 
  - "N8N_SECURE_COOKIE: false" 
  - "N8N_USER_MANAGEMENT_JWT_SECRET: secret-key"
  - "N8N_RUNNERS_ENABLED: true" 
  - "N8N_PERSONALIZATION: false" 
  - "N8N_LOG_LEVEL: info" 
  - "N8N_LOG_OUTPUT: console" 
  - "N8N_LOG_FILE: /home/node/.n8n/logs/n8n.log" 
  - "N8N_LOG_FILE_MAX_SIZE: 120mb" 
  - "N8N_LOG_FILE_MAX_FILES: 10" 
  - "N8N_LOG_FILE_COMPRESSION: true" 
  - "N8N_LOG_FILE_ROTATE: true" 
  - "N8N_LOG_FILE_ROTATE_INTERVAL: 1d" 
  - "DB_TYPE: postgresdb"
  - "DB_POSTGRESDB_HOST: postgres"
  - "DB_POSTGRESDB_PORT: 5432"
  - "DB_POSTGRESDB_DATABASE: n8n"
  - "DB_POSTGRESDB_USER: n8n"
  - "DB_POSTGRESDB_PASSWORD: n8n"
  - "OLLAMA_HOST: host.docker.internal:11434"
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

## Override Default Web Interface 

You can override the default web interface via `N8N_EDITOR_BASE_URL` and `N8N_PATH` to forward to a different port or path.

```yaml
env_vars_list:
  - "N8N_EDITOR_BASE_URL: http://YOUR-IP-ADDRESS:5678"
  - "N8N_PATH: /"
``` 

## Workflows and Credentials Migration on First Run

If you want to pre-load workflows and credentials into n8n when the add-on is started for the first time, simply place your files in the following locations **before starting the add-on**:

- Workflows directory: `/config/n8n/workflows/` (for multiple workflow files)
- Credentials directory: `/config/n8n/credentials/` (for multiple credential files)
- Single credentials file: `/config/n8n/creds.json`
- Single workflows file: `/config/n8n/flows.json`

**Don't forget to fill `N8N_ENCRYPTION_KEY` in the addon configuration before starting the add-on**

Example: `N8N_ENCRYPTION_KEY: YOUR_ENCRYPTION_KEY` add space between the key and the value.

**How it works:**
- On the first run, the add-on will automatically import all workflows and credentials found in these directories and/or single files if present.
- This process only happens once, when the add-on is started for the first time (tracked by a marker file at `/media/n8n_import.json`).
- If you add or change files in these locations after the first run, they will **not** be imported automatically. To re-import, you must delete the marker file or reset the add-on's data.

**Steps:**
1. Place your exported workflow and credential files in the appropriate directories or single files above.
2. Start the add-on for the first time.
3. The add-on will log messages about the import process.
4. After import, your workflows and credentials will be available in n8n.

> Tip: For security, make sure to remove sensitive files from these locations after import if you do not want them to persist in plain text.



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

# RACKSYNC CO., LTD

<div align="center">
  <img src="https://avatars.githubusercontent.com/u/86172519?s=200&v=4" alt="RACKSYNC Logo" width="200"/>
  
  **Innovative Cloud & Infrastructure Solutions**
</div>

## Technologies We Work With

<div align="center">
  
  ![AWS](https://img.shields.io/badge/-AWS-232F3E?style=flat-square&logo=amazon-aws&logoColor=white)
  ![GCP](https://img.shields.io/badge/-Google_Cloud-4285F4?style=flat-square&logo=google-cloud&logoColor=white)
  ![Kubernetes](https://img.shields.io/badge/-Kubernetes-326CE5?style=flat-square&logo=kubernetes&logoColor=white)
  ![Docker](https://img.shields.io/badge/-Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
  ![Terraform](https://img.shields.io/badge/-Terraform-623CE4?style=flat-square&logo=terraform&logoColor=white)
  ![Ansible](https://img.shields.io/badge/-Ansible-EE0000?style=flat-square&logo=ansible&logoColor=white)
  ![GitHub Actions](https://img.shields.io/badge/-GitHub_Actions-2088FF?style=flat-square&logo=github-actions&logoColor=white)
  ![Prometheus](https://img.shields.io/badge/-Prometheus-E6522C?style=flat-square&logo=prometheus&logoColor=white)
  ![Grafana](https://img.shields.io/badge/-Grafana-F46800?style=flat-square&logo=grafana&logoColor=white)
  
</div>

## About Us

RACKSYNC CO., LTD is a technology company specializing in cloud infrastructure, DevOps solutions, and system integrations. We empower businesses through innovative technology implementations and managed services tailored to meet specific operational needs.

### Home Automation Solutions

RACKSYNC provides cutting-edge home automation solutions that transform ordinary homes into smart, efficient living spaces:

- **Smart Home Integration**: Seamlessly connect and control all your smart devices through unified platforms
- **Voice-Controlled Systems**: Implement voice assistants and controls throughout your living space
- **Energy Management**: Optimize energy consumption with intelligent monitoring and automated controls
- **Security & Surveillance**: Advanced security systems with remote monitoring and alerts
- **Custom Automation Scripts**: Tailor-made automation workflows for your specific lifestyle needs
- **IoT Device Management**: Professional setup and management of Internet of Things ecosystems

## Connect With Us

- **Website**: [www.racksync.com](https://www.racksync.com)
- **GitHub**: [@racksync](https://github.com/racksync)
- **Email**: [contact@racksync.com](mailto:contact@racksync.com)
- **Location**: Bangkok, Thailand

---

<div align="center">
  <small>© 2007-2025 RACKSYNC CO., LTD. All Rights Reserved.</small>
</div>
