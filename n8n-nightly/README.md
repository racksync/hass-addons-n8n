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

If you want to pre-load workflows and credentials into n8n when the add-on is started for the first time, simply place your files in the following locations **before starting the add-on**:

- Workflows directory: `/config/n8n/workflows/` (for multiple workflow files)
- Credentials directory: `/config/n8n/credentials/` (for multiple credential files)
- Single credentials file: `/config/n8n/creds.json`
- Single workflows file: `/config/n8n/flows.json`

**Don't forget to fill `N8N_ENCRYPTION_KEY` in the addon configuration before starting the add-on**

Example: `N8N_ENCRYPTION_KEY: YOUR_ENCRYPTION_KEY` add space between the key and the value.

**How it works:**
- On the first run, the add-on will automatically import all workflows and credentials found in these directories and/or single files if present.
- This process only happens once, when the add-on is started for the first time (tracked by a marker file at `/media/.n8n_import_done`).
- If you add or change files in these locations after the first run, they will **not** be imported automatically. To re-import, you must delete the marker file or reset the add-on's data.

**Steps:**
1. Place your exported workflow and credential files in the appropriate directories or single files above.
2. Start the add-on for the first time.
3. The add-on will log messages about the import process.
4. After import, your workflows and credentials will be available in n8n.

> Tip: For security, make sure to remove sensitive files from these locations after import if you do not want them to persist in plain text.
