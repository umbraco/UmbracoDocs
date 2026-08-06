---
description: "Information on the scheduled publishing settings section."
---

# Scheduled Publishing Settings

The scheduled publishing settings control how often Umbraco checks for content scheduled to be published or unpublished. They also control whether those checks are aligned to clock boundaries.

By default, scheduled publishing runs once a minute. An item scheduled to go live at a specific time is therefore published at some point in the following minute. It is not published exactly at the configured time. These settings let you tune that cadence and optionally snap it to wall-clock boundaries.

## Configuration

```json
"Umbraco": {
  "CMS": {
    "ScheduledPublishing": {
      "Period": "00:01:00",
      "AlignToClock": false
    }
  }
}
```

## Settings

### Period

**Default:** `00:01:00` (1 minute)

Specifies how often scheduled publishing runs.

A shorter period means scheduled content is published closer to its configured time, but increases the processing overhead. Reducing the period too far is not recommended, as each run has a performance cost and publishing itself takes some time.

### AlignToClock

**Default:** `false`

Determines whether scheduled publishing runs are aligned to clock boundaries derived from `Period`, rather than drifting based on when the previous run completed.

{% hint style="info" %}
The default is `false` in Umbraco 17 and 18 to preserve the existing behaviour. It is due to change to `true` in Umbraco 19.
{% endhint %}

When `false` (the default), each run is scheduled relative to the completion of the previous run. This means the time of day at which publishing occurs gradually drifts forward.

When `true`, runs are aligned to clock boundaries that are a multiple of `Period`. For example, with a `Period` of `00:00:10`, runs are aligned to the `:00`, `:10`, `:20`, `:30`, `:40`, and `:50` seconds of each minute. This makes the time at which scheduled content is published more predictable.

When `AlignToClock` is enabled, `Period` must be a whole number of seconds that divides evenly into one hour (3600 seconds). For example, 10, 12, 15, 20, 30, or 60 seconds. If this condition is not met, the configuration fails validation on startup.

This does not guarantee publishing to the exact second, as publishing still takes a little time to run. It does, however, narrow the range of when scheduled content goes live.
