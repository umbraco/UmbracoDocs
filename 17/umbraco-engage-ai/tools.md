---
description: The full set of tools Umbraco Engage AI makes available to a Copilot agent.
---

# Tools

Umbraco Engage AI ships these read-only tools, grouped under the **Engage Read** permission. An agent granted this permission can query Engage's campaigns, segments, goals, personas, customer journeys, performance figures, traffic, and A/B tests. It cannot create, edit, or delete anything in Engage.

| Tool | Category | Answers questions like |
|---|---|---|
| `engage_get_summary` | Summary | "Give me a quick overview of how things are going." |
| `engage_get_campaigns` | Discovery | "What campaigns do we have set up?" |
| `engage_get_segments` | Discovery | "What segments do we have?" |
| `engage_get_goals` | Discovery | "What goals are we tracking?" |
| `engage_get_personas` | Discovery | "Who are our visitor personas?" |
| `engage_get_customer_journeys` | Discovery | "What customer journeys are set up?" |
| `engage_get_campaign_performance` | Performance | "Which campaign is giving us the best return right now?" |
| `engage_get_goal_performance` | Performance | "Are our conversions going up or down lately?" |
| `engage_get_segment_performance` | Performance | "Which of our segments is performing best right now?" |
| `engage_get_top_pages` | Traffic | "Show our top pages by pageviews for this year." |
| `engage_get_top_entry_pages` | Traffic | "Where do most visitors first land on the site?" |
| `engage_get_top_traffic_sources` | Traffic | "Which channels should I double down on?" |
| `engage_explain_goal` | Explain | "What exactly counts as a completed goal, and when does it trigger?" |
| `engage_explain_segment` | Explain | "What does this segment capture? Break it down for me." |
| `engage_explain_persona` | Explain | "Why would a visitor end up classified as a 'Window Shoppers'?" |
| `engage_explain_customer_journey` | Explain | "What happens at each stage of a customer journey, and how does a visitor move between them?" |
| `engage_get_ab_tests` | A/B Testing | "Should I end any of my running tests yet, or keep waiting for more data?" |

The **Discovery** tools list what's configured. The **Performance** and **Traffic** tools report figures. The **Explain** tools answer "what does this mean and how is it scored" rather than only "what is it". All of them are available from either Copilot surface (see [Asking Engage Questions](asking-engage-questions.md)). The agent needs the **Engage Read** permission and must be attached to that surface.
