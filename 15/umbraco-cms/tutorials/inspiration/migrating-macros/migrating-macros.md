---
description: >-
  Get started with developing a custom migration path for Macros to Blocks in the Rich Text Editors.
---

# Introduction
As with many things in Umbraco, there are a multitude of ways on how to migrate away from macros and use the blocks in the RTE instead. In this article we will try to mention as many of them as possible while showcasing one of them in detail. The route chosen here is most likely not the best one for your setup but can serve as an inspiration on how you can build your own solution specific your current setup.

In this article we will be doing a one on one conversion from macro to block with each paramater matching the same named properties on an element document type. We are also keeping it quite simple and are using pure text as values. If your migration deals with more complex types, we advice you to create an instance of the new data format and compare the old value against the new as there might have been more differences between the paramater type on the macro and the propertyEditor/datatype on the element document type.

Because most people will be dealing with this kind of migrations when they move between LTS version from 13 to 15, we chose to do just that in this article. More precisly from 13.7.2 to 15.2.3

# Macro setup
If you are reading this you most likely have experience with macros and know what needs to be configured to make them work but lets go over it just in case.
You need to
- Define a macro and its parameters
- Have a macro partial view that is used to render the macro in the frontoffice. It is also used in the backoffice rendering if enabled in the macro settings.
- Enable the Richtext editor (TinyMce) to allow the insertion of macros

Below you can find the relevant items setup for our example

###### Macro definition
![Backoffice configuration of the macro](macro-settings.png)
![Backoffice configuration of the macro parameters](macro-parameters.png)

###### Backoffice macro editing
![Backoffice view of the sample macro](macro-backoffice.png)

###### TinyMce macro configuration
![Enable Macro in TinyMce Toolbar](macro-tinymce.png)

###### MacoPartialView (/Views/MacroPartials/CtaButtonMacro.cshtml)
```csharp
@inherits Umbraco.Cms.Web.Common.Macros.PartialViewMacroPage
<div class="Button">
    <a href="https://www.youtube.com/watch?v=@Model.MacroParameters["youtubeVideoId"]">@Model.MacroParameters["title"]</a>
</div>
```

# Block setup
The block setup is similar but with a few changes
- As off this writing the inline rendering of blocks is not working for tinyMce and tinyMce support will be removed from the core in the near future. So we switch the propertyEditorView of the Richtext property from TinyMce to Tiptap
- Setup an element Doctype with the same properties as the macro parameters
- Allow the tiptap editor to insert blocks and configure our newly created block to be one of the options
- Transform the macroview into a webcomponent for the backofice custom view
- Register the webcomponent
- Transform the macroview in to a richtext block view

Below you can find the relevant items setup for our example

###### Richtext propertyeditor configuration
![Richtext editor configuration](rte-tipttap.png)

###### Element definition
![Block element doctype definition](block-definition.ng)

###### TipTap block configuration
![Tiptap block configuration](tiptap-blocks)

###### Backoffice block editing
![alt text](block-backoffice)

###### Backoffice custom view (/app_plugins/CustomBlockViews/ctaBlock.js)
```js

import { html, customElement, LitElement } from '@umbraco-cms/backoffice/external/lit';
export class ExampleBlockCustomView extends LitElement {

    static properties = {
        mode: { type: Object },
        content: { attribute: false },
    };

    render() {
        return html`
            <div class="Button">
                <a href="https://www.youtube.com/watch?v=${this.content?.youtubeVideoId}">${this.content?.title}</a>
            </div>
		`;
    }
}
export default ExampleBlockCustomView;
window.customElements.define('custom-view', ExampleBlockCustomView);
```
###### Backoffice custom view registration (/app_plugins/CustomBlockViews/umbraco-package.json)
```json
{
  "$schema": "../../umbraco-package-schema.json",
  "name": "My.CustomViewPackage",
  "version": "0.1.0",
  "extensions": [
    {
      "type": "blockEditorCustomView",
      "alias": "my.blockEditorCustomView.ctaBlock",
      "name": "Custom ctaBlock view",
      "element": "/App_Plugins/CustomBlockViews/ctaBlock.js",
      "forContentTypeAlias": "ctaBlock"
    }
  ]
}
```

###### Richtext component view (/Views/Partials/richtext/Components/ctaBlock.cshtml)
```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<Umbraco.Cms.Core.Models.Blocks.RichTextBlockItem>
@{
    var blockValue = Model.Content as CtaBlock;
}
<div class="Button">
    <a href="https://www.youtube.com/watch?v=@blockValue.YoutubeVideoId">@blockValue.Title</a>
</div>
```

# The core conversion
No matter how you go about retrieving the relevant data or when, eventually you will end up with a raw string that you need to convert. Hopefully at this point you are on an Umbraco version that supports blocks in the RTE (v13+). Let's have a look at a sample value.
###### MacroValue
```json
{
    "blocks": {
        "contentData": [
        ],
        "settingsData": [
        ]
    },
    "markup": "<p>Text before macro</p>\n<p>&nbsp;</p>\n<?UMBRACO_MACRO macroAlias=\"ctaButtonMacro\" title=\"CLICK HERE\" youtubeVideoId=\"xvFZjo5PgG0\" />\n<p>&nbsp;</p>\n<p>Text After Macro</p>"
}
```
Let's break this down. The value holds json with
- Empty block information
- The markup with the actual RTE value and the inline macro data
- The macro consists off
  - The tag used as a placeholder where to render its output
  - An alias to find the correct render/update logic
  - Two paramaters with values entered by the user

The first step in transforming the data is taking the json value and deserializing it into a `RichTextEditorValue`. This way we have a nice class to work with to store the updated data in.
You deserialize it yourself, or you can use the `RichTextPropertyEditorHelper` to do the juob for you as it will also try to catch non json values that have not been migrated to the new format.

###### Usage of RichtextPropertyEditorHelper
```csharp
RichTextPropertyEditorHelper.TryParseRichTextEditorValue(originalValue, _jsonSerializer, _logger, out var richTextEditorValue);
```

Next is to get all (relevant) macro tags out of the markup. One way of doing this is trough regex. Do not that the sample regex does not take into account that the order of parameters might be different from tag to tag. One way of dealing with this is to not take out the paramaters in the first match, but to move each paramater to a seperate regex that runs on the first match.

###### Example regex
```csharp
// this regex does not take into account that the paramaters might be in a different order.
private static readonly Regex MacroTagRegex = new(
    @"<\?UMBRACO_MACRO\s+macroAlias=['""](?<macroAlias>.+)['""]\s+title=['""](?<title>.+)['""]\s+youtubeVideoId=['""](?<youtubeVideoId>.+)['""]\s*/>",
    RegexOptions.IgnoreCase | RegexOptions.IgnorePatternWhitespace | RegexOptions.Multiline);
```

Since every macro conversion will be different based on which paramaters get matched to which properties on the

# Files

# Retrieving the data
- Directly from the database
- Trough the services

# Putting the updated value back
- Directly into the dababase
- Through the service?
- Should you validate?

# How to run the migration
- At runtime
- As a migration
- Using deploy