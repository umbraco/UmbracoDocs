---
versionFrom: 7.5.0
---

# New settings in 7.5.0

## `<allowPasswordReset>`

The feature to allow users to reset their passwords if they have forgotten them was introduced in 7.5. The feature is based on a method provided by ASP.NET Identity. 

By default, this is enabled but if you'd prefer to not allow users to do this it can be disabled at both the UI and API level by setting this value to false.