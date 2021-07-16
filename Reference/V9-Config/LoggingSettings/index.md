---
versionFrom: 9.0.0
meta.Title: "Umbraco Logging Settings"
meta.Description: "Information on the logging settings section"
state: complete
verified-against: beta-3
update-links: true
---

# Logging settings

The majority of logging related configuration has been moved to the Serilog configuration see [Serilog settings](../Serilog/) for more information. 

This settings section allows you to configure the max log age for the internal audit log scrubbing. The default maximum age for the internal audit log is 24 hours, however if you want to change this duration, you can with the `"MaxLogAge"` key, like so:


```json
"Umbraco": {
  "CMS": {
    "Logging": {
      "MaxLogAge": "2.00:00:00"
    }
  }
}
```

This will increase the maximum age of the entires in the audit log to 48 hours (2 days).
