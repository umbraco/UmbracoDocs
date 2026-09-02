# Automate docs notes — features shipped since the last release

Source: Umbraco.Automate release PRs #278 (v18, `18.3.0 → 18.4.0`) and #279 (v17, `17.3.0 → 17.4.0`),
both currently open against `v18/main` / `v17/main`. Same feature set on both version lines — the
`17/umbraco-automate` and `18/umbraco-automate` doc trees are byte-identical for the affected pages, so every
change below applies to both.

Working notes only — not for publishing as-is. Each item names the doc gap, the page to touch, and what to say.

---

## 1. Webhook trigger URL + on-demand testing — closes [UmbracoDocs#8378](https://github.com/umbraco/UmbracoDocs/issues/8378)

**Page:** `concepts/triggers.md` (Webhook row + a new subsection), cross-link from `backoffice/building-an-automation.md` (Info tab table).

**What shipped** (PR umbraco/Umbraco.Automate#204, `feat(trigger): webhook-trigger-ux`):

- The webhook URL is now shown directly in the backoffice, in **two** places, both backed by the same
  `GET /automations/{id}/webhook-url` endpoint:
  - **Info tab** of the automation — a "Webhook URL" row, shown only when the automation's trigger is the
    Webhook trigger and the automation has been saved (has a real ID). Before that, the field shows an
    "unsaved" hint instead of a URL.
  - **Trigger settings panel** — opening the Webhook trigger's settings shows a dedicated "Webhook" box with
    the URL at the top, followed by test-request fields (see below).
  - Both are read-only, monospace, with a copy-to-clipboard button.
- **URL format:** `{host}/automate/webhook/{automationId}` — confirms the shape the issue reporter guessed,
  e.g. `https://example.com/automate/webhook/3fa85f64-5717-4562-b3fc-2c963f66afa6`. The host is resolved
  **server-side**, not from the browser address bar: it uses `WebRouting:UmbracoApplicationUrl` if configured
  (matters behind a load balancer or reverse proxy), otherwise the current request's scheme + host.
- **On-demand testing:** there's no live outbound test call. Instead the trigger settings panel has persisted
  **"Test request body"** and **"Test request headers"** JSON fields. Clicking **Run now** on the automation
  starts it immediately using this saved stand-in payload — the configured HTTP method (default POST), the
  saved body verbatim, and the saved headers (defaulting to `Content-Type: application/json`). Auth checks and
  the method allow-list are skipped for on-demand runs, since nothing is actually hitting the HTTP endpoint.
- **"Run now" is no longer Manual/Scheduled-only.** Any trigger can opt in via a new `ISupportsManualRun`
  interface; Webhook now implements it. The **Run now** action's visibility is driven by a
  `supportsManualRun` flag the backend reports per trigger type — worth a one-line mention in
  `backoffice/building-an-automation.md` or wherever "Run now" is currently documented (a search for "Run now"
  in the current docs came up empty, so this may be entirely undocumented today).

**Suggested content for `concepts/triggers.md`:**

- Expand the **Webhook** row's description or add a short subsection under "Trigger Settings" titled something
  like "Finding the webhook URL": *"Once an automation with a Webhook trigger is saved, its webhook URL is
  shown on the automation's **Info** tab and in the trigger's settings panel. Copy it from either location."*
- Note the URL shape (`{host}/automate/webhook/{automationId}`) so readers aren't left guessing, and mention
  that the host reflects server config (`WebRouting:UmbracoApplicationUrl`) — useful context if what they see
  doesn't match the URL they expect behind a proxy.
- Document **Run now** for webhook triggers: it fires using the saved test body/headers rather than a real
  HTTP call, which is a meaningfully different behavior from "send a test webhook" and should be called out so
  users don't expect an outbound request.
- Existing auth strategy documentation (Plain secret / HMAC) is unaffected by this PR — no changes needed there
  beyond making sure it's still accurate.

This directly answers what @erikjanwestendorp and @rickbutterfield discussed in the issue thread: the URL
pattern is confirmed correct, and it's now discoverable in-product instead of only inferable.

---

## 2. Run Script action (new)

**Page:** `concepts/actions.md` — needs a new row in the **General** table (or possibly its own subsection,
given it's a bigger feature — sandboxed JavaScript execution).

- New built-in action: sandboxed JavaScript execution, with `fetch`-like HTTP support and a configurable output
  schema (feat(action): Add Run Script action with sandboxed JavaScript; feat(action): Add an output schema
  setting to the Run Script action).
- The Umbraco.Automate repo has developer-facing notes already at `docs/run-script-action.md` (repo root, not
  UmbracoDocs) — worth reading as background before writing the public page, but it's written for a different
  audience/format.
- Needs: what the sandbox can and can't do, how output schema shapes `${ steps.x.output... }` bindings, any
  execution limits (timeout, memory) worth calling out as a hint box like the existing HTTP Request size-limit
  hint in `actions.md`.

## 3. Find Media / Get Media / Get Media Property actions (new)

**Page:** `concepts/actions.md` — the **Media** table currently only lists **Update Media Property**. Add:

- **Find Media** — find media items by name, optionally filtered by media type (mirrors **Find Content**).
- **Get Media** — fetch a media item and expose its properties for downstream steps (mirrors **Get Content**).
- **Get Media Property** — read a single property value from a media item (mirrors **Get Content Property**).

These three bring the Media action set to parity with the existing Content action set — worth a one-line note
to that effect, and possibly restructuring the Media table to mirror the Content table's row order.

## 4. Step name, alias, error behavior, retry controls (#213)

**Page:** `concepts/actions.md` (`Step Behaviour` section) and/or `backoffice/building-an-automation.md`.

- `actions.md` already documents **Error behavior**, **Max retries**, and **Retry interval** as existing step
  settings — confirm with the PR whether those already existed and this change only added **name** and
  **alias** as separate, explicitly-editable fields (previously alias may have been auto-derived, e.g. from
  step position or action type). If so, the "step's alias... is set in the step settings panel" line already
  in `actions.md` (line 61) may need a rewrite to describe an explicit Name/Alias pair rather than one field.
- Needs a source check before writing — don't guess at the before/after UI here.

## 5. Warn on disconnected steps

**Page:** `backoffice/building-an-automation.md`, "Save and Publish" section.

- New validation: saving or publishing an automation with steps that aren't connected to the trigger now
  surfaces a warning. Worth a short note near the existing "A draft automation does not respond to triggers"
  hint box — something like: *"If the canvas has steps that aren't connected to the trigger, Automate warns you
  before saving or publishing, since disconnected steps never run."*
- Confirm exact wording/severity (is it a blocking validation or just a warning toast?) before writing.

## 6. Per-document culture deltas on content triggers

**Page:** `concepts/triggers.md`, Content Published trigger row / trigger output section.

- feat(trigger): "Consume per-document culture deltas from content notifications" — affects what a
  content-related trigger fires for/exposes on multi-culture (variant) content. Needs a source check to
  describe precisely: does this change which cultures a trigger fires for, or just what's in the output? The
  existing docs don't currently mention culture/variant behavior for content triggers at all, so this may be
  the first time it needs covering.

## Skipped (not user-facing, no doc action)

- `refactor(core): Extract IScriptExecutor and make ScriptExecutor internal`, `refactor(core): Move the HTTP
  client names onto Constants`, and other refactor-only commits — internal, already excluded from the product
  changelogs.
- `fix(ui): ...` cosmetic fixes (edge label orientation, approval prompt wrap, retry validation, code editor
  for Body/Headers/Message fields) — implementation polish, not new documented behavior. The code-editor field
  change is arguably screenshot-relevant if any `actions.md` figures show the old plain-text Body/Headers
  fields — worth a screenshot refresh, not new prose.

## Open questions before writing final docs

1. Item 4 (step name/alias) and item 6 (culture deltas) need a closer look at the actual PR diffs — I didn't
   verify implementation details for those two the way I did for the webhook trigger UX (item 1).
2. Confirm whether "Run now" is documented anywhere today — a page-level search turned up nothing, so this PR
   may be the first opportunity to document it at all, not just extend existing coverage.
3. Decide whether Run Script gets its own page (like the repo-root `docs/run-script-action.md` suggests it's a
   meaty feature) or a table row + expanded description in `actions.md` alongside everything else.
