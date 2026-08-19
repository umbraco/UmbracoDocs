---
description: Using Engage.AI from the Copilot sidebar, with example prompts.
---

# Copilot Sidebar

The Copilot sidebar is a panel that slides in from the right of the backoffice. It's ambient — ask about whatever you're currently looking at, in the section you're currently in.

## Accessing it

1. Open the **Engage** section.
2. Click the **AI Assistant** button in the top header.
3. Pick an agent from the picker, or leave it on **Auto** to let Copilot route to the best available agent. Start typing.

![The Copilot sidebar's opening state in the Engage section](.gitbook/assets/03-engage-sidebar-open.png)

{% hint style="info" %}
Switching agents, or reloading the page, clears the sidebar's conversation — it isn't saved. For a persistent, full-page conversation, see [Copilot Workspace](copilot-workspace.md).
{% endhint %}

## Example prompts

The following ran against a demo Engage installation, using an agent with Instructions similar to the [Installation](installation.md) example. Answers and numbers are from sample/demo data — treat the numbers below as illustrative, not a preview of what your own data will look like.

**"what campaigns do we have set up?"**

![Sidebar answer for the campaigns question](.gitbook/assets/sidebar-01-campaigns.png)

**"which campaign is giving us the best return right now?"**

![Sidebar answer for the campaign performance question](.gitbook/assets/sidebar-02-campaign-performance.png)

**"which channels should i double down on?"**

![Sidebar answer for the top traffic sources question](.gitbook/assets/sidebar-03-traffic-sources.png)

**"who are our visitor personas?"**

![Sidebar answer for the personas question](.gitbook/assets/sidebar-04-personas.png)

**"why would a visitor end up classified as a 'Window Shoppers'?"**

![Sidebar answer explaining the Window Shoppers persona](.gitbook/assets/sidebar-05-explain-persona.png)

**"should i end any of my running tests yet, or keep waiting for more data?"**

![Sidebar answer for the A/B testing question](.gitbook/assets/sidebar-06-abtests.png)

On a site with no A/B test configured yet, this last question comes back differently. Instead of a "who's winning" readout, it explains what to consider before launching one. The tool reports what exists — it doesn't invent a running test.

## Choosing which agent answers

Different agents can be configured with different AI Profiles (models) — for example a Marketer Agent on Anthropic Claude and another on DeepSeek. Since Instructions can be shared between them, the difference shows up in tone and in what each agent leads with:

![Marketer Agent Anthropic's reply to a greeting](.gitbook/assets/sidebar-agent-anthropic-welcome.png)

![Marketer Agent DeepSeek's reply to a greeting](.gitbook/assets/sidebar-agent-deepseek-welcome.png)
