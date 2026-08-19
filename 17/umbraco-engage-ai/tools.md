---
description: The full set of tools Engage.AI makes available to a Copilot agent.
---

# Toolset

Engage.AI ships 17 tools, grouped under a single read-only scope
(`EngageReadScope`). An agent granted this scope can query Engage's campaigns,
segments, goals, personas, customer journeys, performance figures, traffic, and A/B
tests — it cannot create, edit, or delete anything in Engage.

| Tool | Category | Answers questions like |
|---|---|---|
| `engage_get_summary` | Summary | "give me a quick overview of how things are going" |
| `engage_get_campaigns` | Discovery | "what campaigns do we have set up?" |
| `engage_get_segments` | Discovery | "what segments do we have?" |
| `engage_get_goals` | Discovery | "what goals are we tracking?" |
| `engage_get_personas` | Discovery | "who are our visitor personas?" |
| `engage_get_customer_journeys` | Discovery | "what customer journeys are set up?" |
| `engage_get_campaign_performance` | Performance | "which campaign is giving us the best return right now?" |
| `engage_get_goal_performance` | Performance | "are our conversions going up or down lately?" |
| `engage_get_segment_performance` | Performance | "which of our segments is performing best right now?" |
| `engage_get_top_pages` | Traffic | "show our top pages by pageviews for this year" |
| `engage_get_top_entry_pages` | Traffic | "where do most visitors first land on the site?" |
| `engage_get_top_traffic_sources` | Traffic | "which channels should i double down on?" |
| `engage_explain_goal` | Explain | "what exactly counts as a completed goal, and when does it trigger?" |
| `engage_explain_segment` | Explain | "what does this segment capture — break it down for me" |
| `engage_explain_persona` | Explain | "why would a visitor end up classified as a 'Window Shoppers'?" |
| `engage_explain_customer_journey` | Explain | "what happens at each stage of a customer journey, and how does a visitor move between them?" |
| `engage_get_ab_tests` | A/B Testing | "should i end any of my running tests yet, or keep waiting for more data?" |

The **Discovery** tools list what's configured. The **Performance** and **Traffic**
tools report figures. The **Explain** tools answer "what does this mean and how is it
scored" rather than only "what is it". All of them are available from either
[Copilot Sidebar](copilot-sidebar.md) or [Copilot Workspace](copilot-workspace.md), once
the agent has access to the `EngageReadScope` scope and is attached to that surface.
