---
description: >-
  Guidelines for Umbraco employees contributing documentation using AI tools,
  covering disclosure, content ownership, tooling, and PR size.
tags:
  - ai-generated-content
---

# AI Contribution Guidelines

We encourage using AI tools to contribute documentation. These guidelines exist to keep the review process smooth and ensure AI-generated content meets the same quality bar as anything else we publish.

{% hint style="warning" %}
We are not currently accepting AI-generated or AI-assisted documentation contributions from external contributors. This policy may be revisited in the future.
{% endhint %}

## 1. Disclose AI use in your PR description

Tell us whether the content is **fully AI-generated** or **AI-assisted** (for example, AI expanded an outline, rewrote sections, or suggested phrasing). Apply the **AI-generated PR label**.

The documentation team will add a tag (`AI-generated`) to published articles.

If AI use isn't disclosed, we'll reach out before the review begins so we know which approach to take.

## 2. You own the content

The documentation team reviews for style and consistency, but technical accuracy is your area. Before submitting, it's worth double-checking:

* **Code samples** — run them to make sure they work as expected.
* **Version references** — APIs, namespaces, and feature availability for the correct Umbraco version.

Any feedback we receive on articles you've generated with AI will be directed back to you. This includes feedback via PR, issue, or directly from our documentation platform.

## 3. Use the `umbraco-docs-content` skill

The repo includes the [**`umbraco-docs-content` skill**](../../.claude/skills/umbraco-docs-content/SKILL.md) built for our structure, tone, and formatting. We recommend using it exclusively.

Using other prompts, custom skills, or third-party templates is **not recommended**, as it risks inconsistency across the documentation. If you spot something the skill does poorly, suggest an improvement — don't work around it.

## 4. Maximum 10 files per PR

We ask that AI-generated PRs stay within **10 article files**. This isn't an arbitrary number. It comes down to two practical limitations:

* **Vale linting** — GitHub Actions caps annotations at 50 per job. In a larger PR, violations in later files won't surface, meaning automated feedback becomes incomplete.
* **AI review reliability** — AI-assisted review tend to become less thorough when evaluating a large number of articles at once, and things slip through.

Keeping PRs smaller means better automated coverage, more reliable review, and less back-and-forth for everyone.

{% hint style="warning" %}
Over 10 files = you'll be asked to split the PR before review starts.
{% endhint %}

## Questions?

If you have any questions about these guidelines, you can reach out in the following ways:

* **Umbraco employees** — reach out to the Documentation team directly or drop a message in the **#documentation-ama** channel on Slack.
* **Community contributors** — open an issue in the [UmbracoDocs repository](https://github.com/umbraco/UmbracoDocs).
