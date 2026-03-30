# Images Needed for Umbraco AI Documentation

This document tracks all screenshots and images needed for the documentation. Images should be placed in `.gitbook/assets/` at the product root.

## Image Conventions

- **Format**: PNG for screenshots, SVG for diagrams
- **Max width**: 800px
- **Naming**: kebab-case, descriptive
- **Alt text**: Describe what the image shows (under 125 characters)

## Capture Script

Run `node scripts/capture-screenshots.mjs` from the repo root to auto-capture screenshots from a running Umbraco instance. The script logs into the backoffice and navigates through the AI section. See the script for configuration (URL, credentials).

---

## Getting Started

| File | Filename | Description | Priority | Status |
|------|----------|-------------|----------|--------|
| `getting-started/installation.md` | `backoffice-ai-section-sidebar.png` | The AI section visible in the Umbraco backoffice main navigation sidebar | High | ✅ |
| `getting-started/installation.md` | `user-group-ai-section-access.png` | User Groups edit screen with the AI section checkbox enabled under Sections | Medium | ❌ |
| `getting-started/first-connection.md` | `backoffice-create-connection-form.png` | The Create Connection form showing Name, Alias, Provider dropdown, and settings fields | High | ✅ |
| `getting-started/first-profile.md` | `backoffice-create-profile-form.png` | The Create Profile form showing Name, Alias, Capability, Connection, and Model fields | High | ❌ Create button blocked by shadow DOM |
| `getting-started/first-profile.md` | `backoffice-ai-settings-page.png` | The AI Settings page with the Default Chat Profile dropdown | Medium | ✅ |
| `getting-started/configuration.md` | `backoffice-ai-settings-page.png` | The AI Settings page showing both Default Chat Profile and Default Embedding Profile dropdowns | Medium | ✅ Same image |

## Concepts

| File | Filename | Description | Priority | Status |
|------|----------|-------------|----------|--------|
| `concepts/connections.md` | `openai-create-connection.png` | The OpenAI connection detail page with provider-specific fields visible | Medium | ✅ |
| `concepts/profiles.md` | `backoffice-ai-settings-page.png` | The AI Settings page showing the Default Chat Profile dropdown | Low | ✅ Same image |
| `concepts/contexts.md` | `backoffice-manage-contexts.png` | The Brand Voice context detail showing the resource editor | Medium | ✅ |
| `concepts/context-picker.md` | `content-node-context-picker.png` | The AI Context Picker property editor on a content node with a context selected | High | ❌ Requires Document Type + content node setup |
| `concepts/context-picker.md` | `context-picker-inheritance-tree.png` | Content tree showing context assignments and inheritance visualization | Medium | ❌ Requires content tree setup |
| `concepts/guardrails.md` | `backoffice-guardrail-rules.png` | The Content Safety Policy guardrail showing rule configuration | Medium | ✅ |
| `concepts/settings.md` | `backoffice-ai-settings-page.png` | The full AI Settings page with all profile dropdowns | Low | ✅ Same image |
| `concepts/versioning.md` | `backoffice-version-history.png` | The Version History tab showing version list and comparison view | Medium | ❌ Needs entity with multiple versions |
| `concepts/observability.md` | `observability-trace-example.png` | Application Insights or Jaeger trace view showing gen_ai.chat span with Umbraco tags | Low | ❌ Requires external APM tool |

## Providers

| File | Filename | Description | Priority | Status |
|------|----------|-------------|----------|--------|
| `providers/openai.md` | `openai-create-connection.png` | OpenAI connection detail showing API Key and Organization fields | Medium | ✅ |
| `providers/anthropic.md` | `anthropic-create-connection.png` | Create Connection dialog with Anthropic selected, showing API Key field | Medium | ❌ Requires Anthropic provider installed |
| `providers/google.md` | `google-create-connection.png` | Create Connection dialog with Google Gemini selected | Low | ❌ Requires Google provider installed |
| `providers/amazon.md` | `amazon-bedrock-create-connection.png` | Create Connection dialog with Amazon Bedrock selected, showing Region and Access Key fields | Low | ❌ Requires Amazon provider installed |
| `providers/microsoft-foundry.md` | `microsoft-foundry-create-connection.png` | Create Connection dialog with Microsoft AI Foundry selected, showing Entra ID fields | Low | ❌ Requires Microsoft Foundry provider installed |

## Backoffice (Highest Priority)

| File | Filename | Description | Priority | Status |
|------|----------|-------------|----------|--------|
| `backoffice/README.md` | `backoffice-ai-section-overview.png` | The AI section welcome page with sidebar showing all navigation nodes | High | ✅ |
| `backoffice/managing-connections.md` | `backoffice-connections-list.png` | The connections list view showing the OpenAI connection with Active status | High | ✅ |
| `backoffice/managing-connections.md` | `backoffice-create-connection-form.png` | The Create Connection form with provider selection and fields visible | High | ✅ |
| `backoffice/managing-connections.md` | `backoffice-connection-active-toggle.png` | Connection detail showing the Active/Inactive toggle | Low | ❌ |
| `backoffice/managing-profiles.md` | `backoffice-profiles-list.png` | The profiles list view showing the Default Chat profile | High | ✅ |
| `backoffice/managing-profiles.md` | `backoffice-create-profile-form.png` | The Create Profile form with capability, connection, and model fields | High | ❌ Create button blocked by shadow DOM |
| `backoffice/managing-profiles.md` | `backoffice-chat-profile-settings.png` | Chat profile settings showing Temperature, Max Tokens, and System Prompt fields | High | ✅ |
| `backoffice/managing-profiles.md` | `backoffice-profile-governance-tab.png` | The Governance tab showing Content Safety Policy and PII Protection guardrails | Medium | ✅ |
| `backoffice/managing-contexts.md` | `backoffice-contexts-list.png` | The contexts list showing the Brand Voice context | High | ✅ |
| `backoffice/managing-contexts.md` | `backoffice-create-context-form.png` | The Create Context form with resource editor | High | ❌ Create button blocked by shadow DOM |
| `backoffice/managing-contexts.md` | `backoffice-context-add-resource.png` | Resource editor showing Type, Name, Content, and Injection Mode fields | Medium | ❌ |
| `backoffice/managing-guardrails.md` | `backoffice-guardrails-list.png` | The guardrails list showing Content Safety Policy and PII Protection | High | ✅ |
| `backoffice/managing-guardrails.md` | `backoffice-create-guardrail-form.png` | The Create Guardrail form | High | ❌ Create button blocked by shadow DOM |
| `backoffice/managing-guardrails.md` | `backoffice-guardrail-add-rule.png` | Add Rule dialog showing Evaluator, Phase, and Action dropdowns | High | ❌ |
| `backoffice/managing-guardrails.md` | `backoffice-profile-guardrails-assigned.png` | Governance tab on Default Chat profile with guardrails assigned | Medium | ✅ Same as governance tab |
| `backoffice/managing-settings.md` | `backoffice-ai-settings-page.png` | The AI Settings page showing Default Chat, Classifier, and Embedding profile dropdowns | High | ✅ |
| `backoffice/version-history.md` | `backoffice-version-history-tab.png` | Version History tab showing version list for an entity | High | ❌ Needs entity with multiple versions |
| `backoffice/version-history.md` | `backoffice-version-compare.png` | Version comparison view showing diff between two versions | High | ❌ Needs multiple versions |
| `backoffice/version-history.md` | `backoffice-version-rollback.png` | Rollback confirmation dialog | Medium | ❌ |
| `backoffice/audit-logs.md` | `backoffice-audit-logs-list.png` | Audit logs list view (empty — no AI operations run yet) | High | ✅ Empty state |
| `backoffice/audit-logs.md` | `backoffice-audit-logs-filters.png` | Audit logs with filter panel expanded | Medium | ❌ |
| `backoffice/audit-logs.md` | `backoffice-audit-log-detail.png` | Log detail view showing Summary, AI Configuration, Token Usage sections | High | ❌ Requires AI operation data |
| `backoffice/usage-analytics.md` | `backoffice-analytics-dashboard.png` | Analytics dashboard showing Usage metrics and Usage Over Time chart (empty state) | High | ✅ Empty state |
| `backoffice/usage-analytics.md` | `backoffice-analytics-time-series.png` | Time series chart showing usage over time | Medium | ❌ Requires usage data |
| `backoffice/usage-analytics.md` | `backoffice-analytics-breakdowns.png` | Breakdown charts (by provider, model, profile, user) | Medium | ❌ Requires usage data |

## Add-ons

| File | Filename | Description | Priority | Status |
|------|----------|-------------|----------|--------|
| `add-ons/prompt/property-actions.md` | `prompt-property-action-dropdown.png` | The AI action dropdown menu on a property editor in the content editor | Medium | ❌ Requires content node with property |
| `add-ons/agent-copilot/copilot.md` | `copilot-sidebar.png` | The AI Copilot sidebar in the Umbraco backoffice showing a conversation | High | ❌ Requires opening copilot + conversation |
| `add-ons/agent-copilot/copilot.md` | `copilot-hitl-approval.png` | The Human-in-the-Loop approval dialog in the Copilot | Medium | ❌ Requires agent interaction |
| `add-ons/agent/permissions.md` | `agent-governance-tab.png` | The Governance tab showing tool permission configuration | Medium | ❌ |
| `add-ons/agent/scopes.md` | `agent-scope-assignment.png` | The backoffice scope assignment UI for agents | Low | ❌ |

## Summary

| Section | ✅ Captured | ❌ To Do | Total |
|---------|------------|---------|-------|
| Getting Started | 4 | 2 | 6 |
| Concepts | 5 | 4 | 9 |
| Providers | 1 | 4 | 5 |
| Backoffice | 13 | 12 | 25 |
| Add-ons | 0 | 5 | 5 |
| **Total** | **23** | **27** | **50** |

## Remaining Blockers

### Shadow DOM pointer interception
The Umbraco backoffice uses Lit web components with `umb-router-slot` and `umb-split-panel` elements that intercept pointer events, preventing Playwright from clicking "Create" buttons in collection views. Possible fixes:
- Use `{ force: true }` on clicks to bypass actionability checks
- Navigate directly to the create workspace URL (e.g., `/umbraco/section/ai/workspace/connection/create`)
- Use `page.evaluate()` to dispatch click events directly on the shadow DOM elements

### Content/data dependencies
Some screenshots require specific content or data to exist:
- **Context Picker**: Needs a Document Type with the `Uai.ContextPicker` property editor and a content node
- **Version History**: Needs an entity that has been saved multiple times
- **Audit Logs / Analytics with data**: Needs actual AI operations to have been executed
- **Copilot**: Needs to open the copilot sidebar and have a conversation
- **Provider-specific connections**: Needs each provider package installed

### External tools
- **Observability trace**: Needs Application Insights or Jaeger configured and an AI operation traced
