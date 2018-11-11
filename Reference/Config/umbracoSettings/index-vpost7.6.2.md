---
versionFrom: 7.6.2
---

# New settings in 7.6.2

## `<AllowedUploadFiles>`

If greater control is required than available from the above, this setting can be used to store a "white list" of file extensions.  If provided, only files with these extensions can be uploaded via the backoffice.

```xml
<!-- If completed, only the file extensions listed below will be allowed to be uploaded.  
If empty, disallowedUploadFiles will apply to prevent upload of specific file extensions. -->
<allowedUploadFiles></allowedUploadFiles>
```
