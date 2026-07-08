---
description: >-
  Provision the hosted Umbraco MCP Worker on Cloudflare with OpenTofu or
  Terraform, and run the same Worker locally for development.
---

# Infrastructure as Code

This guide provisions the hosted MCP Worker with [OpenTofu](https://opentofu.org/) or Terraform. Terraform creates the Cloudflare resources and renders the Worker configuration. Wrangler then uploads the Worker code.

The [Deployment](deployment.md) guide covers the imperative path, where you run `wrangler` commands by hand. Use Infrastructure as Code when you want a repeatable, version-controlled setup, or when you run more than one environment.

{% hint style="info" %}
The examples use the `tofu` command. Every command works with `terraform` as well. Set `TF_BIN=terraform` where the scripts read it.
{% endhint %}

## What Terraform Manages vs What Wrangler Manages

The two tools own different parts of the deployment. Terraform creates the durable resources. Wrangler owns everything tied to a specific code version.

| Resource | Terraform | Wrangler |
|----------|-----------|----------|
| KV namespace | Creates | Reads the ID |
| Worker shell (the named Worker) | Creates | – |
| `COOKIE_ENCRYPTION_KEY` secret | Generates the value | Pushes it to the Worker |
| Worker code (`src/worker.ts` bundle) | – | Uploads |
| KV and Durable Object bindings, migrations | – | Uploads |
| Custom domain and DNS | – | Provisions on deploy |
| `wrangler.toml` | Renders it | Reads it |

Terraform creates only the Worker shell, not its code. Attaching a custom domain requires an existing deployment, so Wrangler owns the domain. This split lets you re-run `tofu apply` without fighting a `wrangler deploy`.

## Prerequisites

- A [Cloudflare account](https://dash.cloudflare.com/sign-up) and its account ID
- A Cloudflare API token with `Workers Scripts:Edit`, `Workers KV Storage:Edit`, and `DNS:Edit` (for a custom domain)
- [OpenTofu](https://opentofu.org/docs/intro/install/) 1.7+ or Terraform 1.7+
- The [Wrangler CLI](https://developers.cloudflare.com/workers/wrangler/install-and-update/)
- A checkout of your MCP source repository (the one containing `src/worker.ts`)
- An Umbraco instance with an OAuth client registered (see [Umbraco Setup](umbraco-setup.md))

## Project Layout

Create a directory for the Terraform configuration, separate from the MCP source repository:

```
infra/
├── providers.tf
├── versions.tf
├── variables.tf
├── main.tf
├── outputs.tf
└── templates/
    └── wrangler.toml.tftpl
```

## Step 1: Configure the Providers

The Cloudflare provider reads the API token from the `CLOUDFLARE_API_TOKEN` environment variable.

{% code title="providers.tf" %}
```hcl
provider "cloudflare" {
  # Reads CLOUDFLARE_API_TOKEN from the environment.
}
```
{% endcode %}

Pin the provider version. Releases from 5.20 onwards enable an observability trace feature that some accounts reject.

{% code title="versions.tf" %}
```hcl
terraform {
  required_version = ">= 1.7.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.19.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}
```
{% endcode %}

## Step 2: Declare the Variables

{% code title="variables.tf" %}
```hcl
variable "account_id" {
  description = "Cloudflare account ID."
  type        = string
}

variable "worker_name" {
  description = "Worker name. Account-global; renaming recreates the Worker."
  type        = string
  default     = "umbraco-cms-mcp"
}

variable "umbraco_base_url" {
  description = "Public HTTPS URL of the Umbraco instance the MCP connects to."
  type        = string
}

variable "oauth_client_id" {
  description = "OAuth client ID registered in Umbraco. Must match the Worker source."
  type        = string
  default     = "umbraco-back-office-mcp"
}

variable "hostname" {
  description = "Custom domain for the Worker. Leave null to use the workers.dev subdomain."
  type        = string
  default     = null
}

variable "extra_vars" {
  description = "Extra non-secret env vars, e.g. UMBRACO_TOOL_MODES or UMBRACO_READONLY."
  type        = map(string)
  default     = {}
}
```
{% endcode %}

## Step 3: Define the Worker Resources

This file creates the KV namespace, generates the cookie key, and creates the Worker shell. It also renders the `wrangler.toml` body from a template.

{% code title="main.tf" %}
```hcl
locals {
  worker_vars = merge({
    UMBRACO_BASE_URL        = var.umbraco_base_url
    UMBRACO_OAUTH_CLIENT_ID = var.oauth_client_id
  }, var.extra_vars)

  wrangler_config = templatefile("${path.module}/templates/wrangler.toml.tftpl", {
    name                = var.worker_name
    compatibility_date  = "2025-04-01"
    compatibility_flags = ["nodejs_compat_v2"]
    kv_namespace_id     = cloudflare_workers_kv_namespace.oauth.id
    do_class_name       = "UmbracoMcpAgent"
    hostname            = var.hostname
    vars                = local.worker_vars
  })
}

resource "cloudflare_workers_kv_namespace" "oauth" {
  account_id = var.account_id
  title      = "${var.worker_name}-oauth"
}

# 32 random bytes as a 64-char hex string. Stored in state so re-applying does
# not rotate it. Rotating the key invalidates every live OAuth session.
resource "random_id" "cookie_key" {
  byte_length = 32
}

# The Worker shell. Code, bindings, migrations, and secrets are owned by
# `wrangler deploy`, so Terraform ignores the attributes Wrangler manages.
resource "cloudflare_worker" "this" {
  account_id = var.account_id
  name       = var.worker_name

  subdomain = {
    enabled          = true
    previews_enabled = false
  }

  lifecycle {
    ignore_changes = [observability, subdomain]
  }
}
```
{% endcode %}

{% hint style="info" %}
`observability` and `subdomain` are per-deployment settings that Wrangler applies. The bare Worker shell cannot persist them, so `ignore_changes` stops Terraform from reporting a permanent diff.
{% endhint %}

## Step 4: Render the Wrangler Configuration

Terraform writes the KV namespace ID, cookie key placeholder, and custom domain into a `wrangler.toml` body. The template mirrors the bindings the Worker expects.

{% code title="templates/wrangler.toml.tftpl" %}
```toml
# Generated by Terraform. Do not edit.
name = "${name}"
main = "src/worker.ts"
compatibility_date = "${compatibility_date}"
compatibility_flags = ${jsonencode(compatibility_flags)}
find_additional_modules = true

%{ if hostname != null ~}
[[routes]]
pattern = "${hostname}"
custom_domain = true

%{ endif ~}
[[kv_namespaces]]
binding = "OAUTH_KV"
id = "${kv_namespace_id}"

[durable_objects]
bindings = [
  { name = "MCP_AGENT", class_name = "${do_class_name}" }
]

[[migrations]]
tag = "v1"
new_sqlite_classes = ["${do_class_name}"]

[observability]
enabled = true
head_sampling_rate = 1

[vars]
%{ for k, v in vars ~}
${k} = "${v}"
%{ endfor ~}
```
{% endcode %}

Expose the rendered config and the cookie key as outputs. The deploy script reads both.

{% code title="outputs.tf" %}
```hcl
output "wrangler_config" {
  description = "Rendered wrangler.toml body. Write it into the Worker source repo before deploying."
  value       = local.wrangler_config
  sensitive   = true
}

output "cookie_encryption_key" {
  description = "Terraform-managed cookie key. Pipe into `wrangler secret put COOKIE_ENCRYPTION_KEY`."
  value       = random_id.cookie_key.hex
  sensitive   = true
}

output "worker_host" {
  description = "Resolved Worker hostname."
  value       = var.hostname
}
```
{% endcode %}

{% hint style="info" %}
The only secret Terraform generates is `COOKIE_ENCRYPTION_KEY`. `UMBRACO_BASE_URL` and `UMBRACO_OAUTH_CLIENT_ID` are not secrets, so they render into `[vars]`. To keep them out of the config file, push them as secrets instead, as shown in the [Deployment](deployment.md) guide.
{% endhint %}

## Step 5: Provision the Infrastructure

Set the API token and apply the configuration:

```bash
export CLOUDFLARE_API_TOKEN="your-token"

cd infra
tofu init
tofu apply \
  -var="account_id=your-account-id" \
  -var="umbraco_base_url=https://my-umbraco.example.com"
```

Terraform creates the KV namespace, the cookie key, and the Worker shell. The Worker has no code yet.

## Step 6: Deploy the Worker Code

Wrangler uploads the code, bindings, and custom domain, then receives the cookie secret. Run this script from a checkout of the MCP source repository.

{% code title="deploy-worker.sh" %}
```bash
#!/usr/bin/env bash
set -euo pipefail
# Requires: tofu (or terraform), npx (wrangler), CLOUDFLARE_API_TOKEN.

TF_DIR="${TF_DIR:?Set TF_DIR to your Terraform directory}"
TF_BIN="${TF_BIN:-tofu}"

# Write the Terraform-rendered config into the source repo.
"$TF_BIN" -chdir="$TF_DIR" output -raw wrangler_config > wrangler.toml

# Upload code, bindings, migrations, and the custom domain.
npx wrangler deploy --config wrangler.toml

# Push the generated cookie key as a secret.
"$TF_BIN" -chdir="$TF_DIR" output -raw cookie_encryption_key \
  | npx wrangler secret put COOKIE_ENCRYPTION_KEY --config wrangler.toml
```
{% endcode %}

Run it:

```bash
TF_DIR=../infra ./deploy-worker.sh
```

The Worker version equals the git ref of the source repository at deploy time. Cloudflare records every upload. List them with `wrangler deployments list`, and roll back with `wrangler rollback`.

## Custom Domain

When you set the `hostname` variable, the template adds a `custom_domain` route. Wrangler provisions the domain, DNS record, and certificate on the next deploy. Register the domain's callback as a redirect URI in Umbraco:

```
https://mcp.example.com/callback
```

See [Umbraco Setup](umbraco-setup.md) for redirect URI configuration.

## Multiple Environments

Use one variable file per environment to run a development and a production Worker from the same configuration.

{% code title="dev.tfvars" %}
```hcl
worker_name      = "umbraco-cms-mcp-dev"
umbraco_base_url = "https://dev-umbraco.example.com"
hostname         = "mcp-dev.example.com"
```
{% endcode %}

Apply an environment with its file:

```bash
tofu workspace new dev
tofu apply -var="account_id=your-account-id" -var-file=dev.tfvars
```

Each Worker name is account-global, so give every environment a distinct `worker_name`. Store state remotely (for example, in Cloudflare R2 or Terraform Cloud) when a team shares the configuration.

## Local Development

Terraform provisions the remote, edge-hosted Worker. You do not need it to develop locally. For local iteration, run the Worker with `wrangler dev` against a local Umbraco instance.

Before applying changes, preview them:

```bash
tofu plan -var="account_id=your-account-id" -var-file=dev.tfvars
```

To run the Worker on your machine, follow the [Local Development Setup](local-dev-setup.md) guide. It uses a `.dev.vars` file and a placeholder KV namespace, so no Cloudflare resources are created. This lets you test tool changes and the OAuth flow before you deploy.

## Verify the Deployment

1. Visit the Worker URL in a browser. You should see the landing page.
2. Visit `/info` to confirm the configuration and tool collections. This requires `ENABLE_INFO_ENDPOINT=true`.
3. Stream logs with `wrangler tail`.
4. Connect with the [MCP Inspector](https://inspector.tools.modelcontextprotocol.io/) to test the OAuth flow.

## Next Steps

- [Deployment](deployment.md) — the imperative Wrangler path and monitoring.
- [Architecture](architecture.md) — the auth flow and three-tier configuration.
- [Multi-Site Deployments](multi-site.md) — serve multiple Umbraco instances from one Worker.
- [Security](security.md) — token isolation, consent, and CSRF protection.
