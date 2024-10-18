---
description: Reporting section in Configuration.
---

# Reporting

Reporting will run every night at 04:00 AM (configurable). All data is transferred from the relational database tables to a star scheme. All existing reporting tables are dropped and recreated during the process.

You can use the Log to see if reporting ran successfully.

There is a red Regenerate button, do NOT use this on production environments. This button is only intended to use on non-production environments to regenerate the reporting data while you not have to wait till 04:00 AM.
