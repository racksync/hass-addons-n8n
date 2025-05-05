# n8n - Home Assistant Add-on

*n8n* (pronounced n-eight-n) a.k.a. `Nodemation` is a powerful workflow automation platform that lets you connect any app with an API without coding. It features an intuitive visual interface for creating workflows and runs securely on your own server.

## Version?

You are now using `n8n stable` The Stable release with thoroughly tested features, Production use, stable environments.

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
