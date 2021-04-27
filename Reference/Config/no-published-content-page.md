---
versionFrom: 9.0.0
verified-against: alpha-3
state: complete
updated-links: true
---

# No Published Content Page

When Umbraco is first installed and no starter kit is chosen, there will be no content created in the backoffice, and no published content to display.

It's also possible to create content, but have it unpublished.

If browsing the front-end of the website, when this situation of no published content is found, a custom page is displayed.

This page is served from `~/umbraco/UmbracoWebsite/NoNodes.cshtml`.

## Customising The Page

Whilst the contents of this page can be edited directly, this isn't recommended, as care would need to be taken to avoid the changes getting overwritten in upgrades.

Instead, a better approach is to create your own view file and apply a configuration setting to indicate the path to the view to use.

To return the contents of a different file, create it at your chosen location and configure it's use by adding an entry for `NoNodesViewPath` at the following path: `Umbraco:CMS:Global`.

This configuration can be setup in a configuration source of your choice.  For the default JSON based configuration you can apply this to `appSettings.json` (or `appSettings.<environment>.json`, e.g. `appSettings.Development.json`) as follows:

```json
"Umbraco": {
  "CMS": {
    ...
    "Global": {
      ...
      "NoNodesViewPath": "~/Views/CustomNoNodes.cshtml",
      ...
    },
    ...
```
