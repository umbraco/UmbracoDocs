# Images for Umbraco AI Documentation

All screenshots are in `.gitbook/assets/` at the product root.

## Image Conventions

- **Format**: PNG for screenshots, SVG for diagrams
- **Max width**: 800px
- **Naming**: kebab-case, descriptive
- **Alt text**: Describe what the image shows (under 125 characters)

## Capture Script

Run `node scripts/capture-screenshots.mjs` from the repo root to auto-capture a subset of screenshots from a running Umbraco instance. Most screenshots were captured manually for better quality.

---

## Inventory (40 images)

### Getting Started

| Filename | Used In | Description |
|----------|---------|-------------|
| `backoffice-ai-section-overview.png` | `getting-started/installation.md`, `backoffice/README.md` | AI section welcome page with full sidebar |
| `user-group-ai-section-access.png` | `getting-started/installation.md` | User Groups edit with AI section checkbox |
| `backoffice-create-connection-modal.png` | `getting-started/first-connection.md`, `backoffice/managing-connections.md` | Provider selection modal |
| `backoffice-create-connection-form.png` | `getting-started/first-connection.md`, `backoffice/managing-connections.md` | Connection configuration form |
| `backoffice-create-profile-modal.png` | `getting-started/first-profile.md`, `backoffice/managing-profiles.md` | Capability selection (Chat/Embedding) |
| `backoffice-create-profile-form.png` | `getting-started/first-profile.md`, `backoffice/managing-profiles.md` | Profile configuration form |

### Backoffice

| Filename | Used In | Description |
|----------|---------|-------------|
| `backoffice-connections-list.png` | `backoffice/managing-connections.md` | Connections list with Active status |
| `backoffice-profiles-list.png` | `backoffice/managing-profiles.md` | Profiles list |
| `backoffice-chat-profile-settings.png` | `backoffice/managing-profiles.md` | Profile settings (Temperature, Max Tokens, System Prompt) |
| `backoffice-profile-governance-tab.png` | `backoffice/managing-profiles.md` | Governance tab with guardrails assigned |
| `backoffice-contexts-list.png` | `backoffice/managing-contexts.md` | Contexts list |
| `backoffice-create-context-form.png` | `backoffice/managing-contexts.md` | Create context form |
| `backoffice-context-add-resource.png` | `backoffice/managing-contexts.md` | Resource type picker (Brand Voice, Text) |
| `backoffice-context-add-resource-details.png` | `backoffice/managing-contexts.md` | Resource details form |
| `backoffice-manage-contexts.png` | `concepts/contexts.md` | Brand Voice context detail |
| `backoffice-guardrails-list.png` | `backoffice/managing-guardrails.md` | Guardrails list |
| `backoffice-create-guardrail-form.png` | `backoffice/managing-guardrails.md` | Create guardrail form |
| `backoffice-create-guardrail-add-guardrail.png` | `backoffice/managing-guardrails.md` | Evaluator selection panel |
| `backoffice-create-guardrail-add-guardrail-details.png` | `backoffice/managing-guardrails.md` | Rule configuration panel |
| `backoffice-guardrail-rules.png` | `backoffice/managing-guardrails.md`, `concepts/guardrails.md` | Content Safety Policy rules detail |
| `backoffice-ai-settings-page.png` | `backoffice/managing-settings.md`, `getting-started/configuration.md` | AI Settings with profile dropdowns |
| `backoffice-version-history.png` | `backoffice/version-history.md`, `concepts/versioning.md` | Version history tab |
| `backoffice-version-compare.png` | `backoffice/version-history.md` | Version comparison diff |
| `backoffice-audit-log-list.png` | `backoffice/audit-logs.md` | Audit logs list with data |
| `backoffice-audit-log-detail.png` | `backoffice/audit-logs.md` | Audit log detail panel |
| `backoffice-analytics-dashboard.png` | `backoffice/usage-analytics.md` | Analytics dashboard with metrics + chart |
| `backoffice-analytics-breakdowns.png` | `backoffice/usage-analytics.md` | Breakdown tables by provider, model, profile, user |

### Providers

| Filename | Used In | Description |
|----------|---------|-------------|
| `openai-create-connection.png` | `providers/openai.md` | OpenAI connection detail |
| `anthropic-create-connection.png` | `providers/anthropic.md` | Anthropic connection detail |
| `google-create-connection.png` | `providers/google.md` | Google Gemini connection detail |
| `amazon-bedrock-create-connection.png` | `providers/amazon.md` | Amazon Bedrock connection detail |
| `microsoft-foundry-create-connection.png` | `providers/microsoft-foundry.md` | Microsoft AI Foundry connection detail |

### Concepts

| Filename | Used In | Description |
|----------|---------|-------------|
| `content-node-context-picker.png` | `concepts/context-picker.md` | Context picker property editor on content node |
| `observability-trace-example.png` | `concepts/observability.md` | Aspire trace with umbraco.ai.* tags |

### Add-ons

| Filename | Used In | Description |
|----------|---------|-------------|
| `prompt-property-action-dropdown.png` | `add-ons/prompt/property-actions.md` | AI action dropdown on property editor |
| `prompt-availability-scopes.png` | `add-ons/prompt/scoping.md` | Prompt scope configuration |
| `copilot-sidebar.png` | `add-ons/agent-copilot/copilot.md` | Copilot sidebar conversation |
| `copilot-hitl-approval.png` | `add-ons/agent-copilot/copilot.md` | HITL approval dialog |
| `agent-governance-tab.png` | `add-ons/agent/permissions.md` | Agent governance/permissions config |
| `agent-scope-assignment.png` | `add-ons/agent/scopes.md` | Agent scope assignment UI |
