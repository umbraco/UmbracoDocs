---
description: >-
    Create and run your first AI test.
---

# Getting Started with Testing

This guide walks you through creating and running your first AI test.

## Prerequisites

- At least one prompt or agent configured
- At least one chat profile with a valid connection

## Step 1: Create a Test

1. Navigate to the **AI** section > **Tests**
2. Click **Create**
3. Fill in the test details:

| Field | Description |
|-------|-------------|
| Name | A descriptive name for the test |
| Alias | Unique identifier |
| Description | What the test validates |

4. Select the **Target** — the prompt or agent to test
5. Configure the **Profile** and **Contexts** to use during execution

![Test settings showing target, profile, and context configuration](../.gitbook/assets/backoffice-ai-test-settings.png)

## Step 2: Add Graders

Graders define the success criteria for the test output.

1. Click **Add Grader** in the Graders section
2. Select a grader type (e.g., Contains, Regex Match, LLM Judge)
3. Configure the grader settings

![Configure Contains Grader showing name, severity, weight, negate, and search pattern fields](../.gitbook/assets/backoffice-ai-test-grader-settings.png)

See [Graders](graders.md) for details on all available grader types.

## Step 3: Run the Test

1. Click **Run** in the toolbar
2. The test executes against the target with the configured graders
3. View the results in the **Runs** tab

![Test runs view showing 4 runs with pass rates and execution details](../.gitbook/assets/backoffice-ai-test-runs.png)

## Step 4: Review Results

Click a run to see the details:

- **Score** — overall pass rate
- **Graders Passed** — how many graders passed
- **Outcome** — the actual output from the AI

![Test run detail showing score, graders passed, and outcome](../.gitbook/assets/backoffice-ai-test-run-details.png)

## Next Steps

- [Graders](graders.md) — Configure success criteria
- [Variations](variations.md) — A/B test across models
- [Concepts](concepts.md) — Understand tests, features, and metrics
