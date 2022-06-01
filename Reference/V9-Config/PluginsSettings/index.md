---
versionFrom: 9.0.0
versionTo: 10.0.0
meta.Title: "Umbraco Plugins Settings"
meta.Description: "Information on the plugins settings section"
---

# Plugins settings

The plugins settings allow you to configure how Umbraco handles plugins, currently you can only configure browsable file extensions, which allows you to customize what file types plugins are allowed to use for the front end. The default configuration looks like this:

```json
"Umbraco": {
  "CMS": {
    "Plugins": {
      "BrowsableFileExtensions": [
        ".html",
        ".css",
        ".js",
        ".jpg", ".jpeg", ".gif", ".png", ".svg",
        ".eot", ".ttf", ".woff",
        ".xml", ".json", ".config",
        ".lic"]
    }
  }
}
```

As you can see above, by default markup, styles, scripts, images, fonts, configurations and license type, if you were to for example remove the ".html" entry, then plugins would no longer be allowed to use html files.

