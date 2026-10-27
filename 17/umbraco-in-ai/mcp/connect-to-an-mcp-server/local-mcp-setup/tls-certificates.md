---
description: >-
  Connect an Umbraco MCP server to a local Umbraco with a self-signed certificate, and why NODE_TLS_REJECT_UNAUTHORIZED is for local sites only.
---

# TLS Certificates

A local Umbraco site serves HTTPS with the .NET development certificate. Node.js runs the MCP server and doesn't trust that certificate. Without extra configuration, requests from the MCP server to Umbraco fail with a certificate error such as `DEPTH_ZERO_SELF_SIGNED_CERT`.

You can solve this in two ways:

| Setting | Certificate verification | Use with |
|---|---|---|
| `NODE_TLS_REJECT_UNAUTHORIZED=0` | Off | A local Umbraco only |
| `NODE_EXTRA_CA_CERTS` | On | Any site whose certificate Node.js doesn't trust |

The [Local MCP Setup](README.md) examples use `NODE_TLS_REJECT_UNAUTHORIZED=0`, the quickest option for a local site.

## Use NODE_TLS_REJECT_UNAUTHORIZED for a Local Umbraco Only

Setting `NODE_TLS_REJECT_UNAUTHORIZED` to `0` turns off certificate verification for every HTTPS request the MCP server makes. The setting applies to the whole process, not only to requests to Umbraco.

When Umbraco runs on your own machine, the traffic between the MCP server and Umbraco stays on that machine. Over a network, anyone who can intercept the traffic could impersonate the site, for example on shared Wi-Fi. The MCP server would then send them the API user's client ID and secret.

### Remote Connections Are Refused

An Umbraco MCP server refuses to start when `NODE_TLS_REJECT_UNAUTHORIZED` is `0` and `UMBRACO_BASE_URL` isn't local. The server writes an error and exits before it requests an access token. The client secret is never sent over an unverified connection. No setting overrides this check.

The server treats `UMBRACO_BASE_URL` as local only when its hostname is exactly one of the following:

* `localhost`
* `127.0.0.1`
* `[::1]`

Any other hostname counts as remote. This includes names that point to your own machine or network, such as `mysite.local`, hosts-file aliases, `host.docker.internal`, and IP addresses on your local network. For these hosts, use `NODE_EXTRA_CA_CERTS`, described below.

If the MCP server stops starting after you change `UMBRACO_BASE_URL`, check whether `NODE_TLS_REJECT_UNAUTHORIZED` is still set. The error appears in your MCP client's log for the server.

{% hint style="info" %}
The check applies to Umbraco MCP servers built on version `1.0.0-beta.47` or later of the MCP Server SDK. These package versions include it:

* Developer MCP Server: 17.6.12
* Forms MCP Server: 17.6.1-beta.6
* Automate MCP Server: 17.4.0-beta.5
* Engage MCP Server: 17.0.0-beta.5
{% endhint %}

## Connect to a Remote Umbraco

Remove `NODE_TLS_REJECT_UNAUTHORIZED` from the server's configuration. A site with a certificate from a public certificate authority needs no TLS setting.

If the site uses a self-signed or internal certificate, use `NODE_EXTRA_CA_CERTS`.

## Keep Verification On with NODE_EXTRA_CA_CERTS

`NODE_EXTRA_CA_CERTS` adds certificates to the set that Node.js trusts. Certificate verification stays on, so the MCP server still rejects any certificate you haven't trusted.

1. Export the .NET development certificate as a `.pem` file:

    ```bash
    dotnet dev-certs https --export-path ./dev-cert.pem --format Pem
    ```

    The command exports the certificate only, without its private key.

2. Set `NODE_EXTRA_CA_CERTS` to the full path of the file in the server's `env`. Use it instead of `NODE_TLS_REJECT_UNAUTHORIZED`:

    ```json
    {
      "mcpServers": {
        "umbraco-mcp": {
          "command": "npx",
          "args": ["@umbraco-cms/mcp-dev@lts-17"],
          "env": {
            "NODE_EXTRA_CA_CERTS": "/full/path/to/dev-cert.pem",
            "UMBRACO_CLIENT_ID": "umbraco-back-office-mcp",
            "UMBRACO_CLIENT_SECRET": "1234567890",
            "UMBRACO_BASE_URL": "https://localhost:12345"
          }
        }
      }
    }
    ```

3. Restart the MCP server.

Set `NODE_EXTRA_CA_CERTS` in your MCP client's configuration, not in a `.env` file. Node.js reads it when the process starts, before the MCP server loads `.env`.

The certificate only covers the hostnames listed in it. Recent versions of the .NET development certificate include `host.docker.internal` as well as `localhost`, `127.0.0.1` and `[::1]`.

For a site with its own certificate, export that certificate, or the certificate of the authority that issued it, as a `.pem` file. Then use it in the same way.

If you regenerate the development certificate, for example after it expires, export it again.
