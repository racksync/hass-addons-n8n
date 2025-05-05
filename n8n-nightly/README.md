# n8n - Home Assistant Add-on

*n8n* (pronounced n-eight-n) a.k.a. `Nodemation` is a powerful workflow automation platform that lets you connect any app with an API without coding. It features an intuitive visual interface for creating workflows and runs securely on your own server.

## Version?

You are now using `n8n nightly` The Cutting-edge build with latest features, Testing, development, early adopters.

## Why n8n on Home Assistant?

| Advantage | Description |
|-----------|-------------|
| 🔒 Security | Runs locally on your server, keeping sensitive data secure |
| 🏠 Home Integration | Direct integration with Home Assistant for smart home automation |
| 🔌 Low-Code Solution | Visual workflow builder for connecting apps and services |
| 🌐 API Freedom | Connect to any service with an API endpoint |
| 🚀 Real-time Processing | Execute workflows flowlessly with webhook triggers |
| 🛡️ Authentication | Protected by Home Assistant's authentication and ingress system |


# Workflows and Credentials Migration

If you want to pre-load workflows and credentials into n8n when the add-on is started for the first time, simply place your files in the following directories **before starting the add-on**:

- Workflows: `/config/n8n/workflows/`
- Credentials: `/config/n8n/credentials/`

> Tip: For security, make sure to remove sensitive files from these directories after import if you do not want them to persist in plain text.
