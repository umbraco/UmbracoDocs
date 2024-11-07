---
description: Information on how to work with TinyMCE plugins in the rich text editor.
---

# Plugins

The Rich Text Editor (RTE) in Umbraco is based on the open source editor [TinyMCE](https://www.tiny.cloud/). TinyMCE is a highly customizable editor, and it is possible to extend the functionality of the editor by adding plugins.

TinyMCE comes with a lot of plugins out of the box, but it is also possible to create your own plugins. This article will show you how to add a custom plugin to the rich text editor.

## Open-Source Plugins

TinyMCE has a lot of open-source plugins available. You can find a list of these plugins on the [TinyMCE website](https://www.tiny.cloud/docs/tinymce/6/plugins/#open-source-plugins).

## Premium Plugins

TinyMCE also has a number of [premium plugins](https://www.tiny.cloud/docs/tinymce/6/plugins/#premium-plugins) available. These plugins are only available for [paid TinyMCE subscriptions](https://www.tiny.cloud/pricing/). They can be added to the rich text editor by [adding a bit of configuration](#adding-a-premium-plugin).

## Adding a Plugin

To enable plugins in the rich text editor, you need to add an extension type called `tinyMcePlugin` in a manifest file. The manifest file is a JSON file that describes the plugin and how it should be loaded. You can add a plugin such as the open source [Word Count Plugin](https://www.tiny.cloud/docs/tinymce/6/wordcount/) to the rich text editor. You can also define your own custom plugin to extend the functionality of the editor. This way you can add custom buttons, dialogs, or other features to the editor.

{% hint style="info" %}
The manifest file should be placed in a folder in `App_Plugins/{YourPackageName}`, with the name `umbraco-package.json`. Learn how to use the [package manifests](../../../../../extending/property-editors/package-manifest.md).
{% endhint %}

{% code title="App_Plugins/YourPackageName/umbraco-package.json" lineNumbers="true" %}

```json
{
    "name": "My TinyMCE Plugin",
    "version": "1.0.0",
    "extensions": [
        {
            "type": "tinyMcePlugin",
            "alias": "mytinymceplugin",
            "name": "My TinyMCE Plugin",
            "meta": {
                "config": {
                    "plugins": ["wordcount"],
                    "statusbar": true
                }
            }
        }
    ]
}
```

{% endcode %}

The example above shows how to add the open-source [Word Count Plugin](https://www.tiny.cloud/docs/tinymce/6/wordcount/) to the rich text editor. The plugin is added to the `Plugins` array in the configuration. The plugin itself will be shown in the statusbar of the rich text editor, so the `statusbar` option is also added to the `config` object.

## Creating a Custom Plugin

If you want to create your own plugin, you should in general follow the [TinyMCE documentation](https://www.tiny.cloud/docs/tinymce/latest/creating-a-plugin/). However, there are a few things you need to be aware of to load the plugin in Umbraco. See the example below.

### Examples

Load a custom plugin that gives you the ability to interact with the global `tinymce` editor object.

Here we are loading a custom plugin called `myrteplugin` and adding a button to the editor called `myrtebutton`. When the button is clicked, it will insert the text `Hello World!` into the editor.

<figure><img src="images/my-rte-button-editor.jpg" alt="Rich text editor showing a custom button"><figcaption><p>The text "Hello World!" shows up after clicking the button</p></figcaption></figure>

1.**Add a manifest file**

First we create an `umbraco-package.json` file which will contain the manifest for the plugin. This adds a button to the toolbar in the rich text editor, which editors can enable on the Data Type. We are also letting the rich text editor know it should load the plugin from the `plugin.js` file.

{% code title="App_Plugins/MyRtePlugin/umbraco-package.json" lineNumbers="true" %}

```json
{
    "name": "My TinyMCE Plugin",
    "version": "1.0.0",
    "extensions": [
        {
            "type": "tinyMcePlugin",
            "alias": "myrteplugin",
            "name": "My TinyMCE Plugin",
            "js": "/App_Plugins/MyRtePlugin/plugin.js",
            "meta": {
                "toolbar": [
                    {
                        "alias": "myrtebutton",
                        "label": "My RTE Button",
                        "icon": "code-sample"
                    }
                ]
            }
        }
    ]
}
```

{% endcode %}

2.**Add the plugin.js file**

The `plugin.js` file should contain the JavaScript code for the plugin. The file is loaded as a JavaScript module and must export a default class that extends the `UmbTinyMcePluginBase` class.

{% hint style="info" %}
The `UmbTinyMcePluginBase` class is a class provided by Umbraco that you can use to create your own plugins. The class is a wrapper around the TinyMCE plugin API. We can use the `args` object on the constructor to access the TinyMCE editor instance and other useful properties.
{% endhint %}

{% code title="App_Plugins/MyTinyMCEPlugin/plugin.js" lineNumbers="true" %}

```js
import { UmbTinyMcePluginBase } from '@umbraco-cms/backoffice/tiny-mce';

export default class UmbTinyMceMediaPickerPlugin extends UmbTinyMcePluginBase {
    /**
     @param args {import('@umbraco-cms/backoffice/tiny-mce').TinyMcePluginArguments}
     */
    constructor(args: TinyMcePluginArguments) {
        super(args);

        // Add your plugin code here
        args.editor.ui.registry.addButton('myrtebutton', {
            text: 'My RTE Button',
            icon: 'code-sample',
            onAction: () => {
                args.editor.insertContent('Hello World!');
            }
        });
    }
}
```

{% endcode %}

The button must be added to the toolbar in the rich text editor configuration.

<figure><img src="images/my-rte-button.jpg" alt="Rich text editor configuration showing available options"><figcaption><p>Enable the button in the rich text editor configuration</p></figcaption></figure>

You can go to any Document Type that uses the rich text editor and click the button to insert the text `Hello World!` after.

You have full access to the `tinymce` editor object, so you can create any custom functionality you need.

### Learn more

* [TinyMCE documentation](https://www.tiny.cloud/docs/)
* [TinyMCE tutorial: Creating a plugin](https://www.tiny.cloud/docs/tinymce/latest/creating-a-plugin/)

## Adding a premium plugin

To add a premium plugin, you need to add the plugin name to the `plugins` array in the `config` object of a `tinyMcePlugin` extension. You also need to add a JavaScript module that can load up the cloud-hosted TinyMCE premium plugins bundle.

{% hint style="info" %}
Premium plugins require a subscription at [TinyMCE Cloud](https://www.tiny.cloud/). You can go there and sign up for a free trial. You will get a Cloud API key that you can use to try out the premium plugins.
{% endhint %}

1. Declaring the plugin

Let us first add the [powerpaste](https://www.tiny.cloud/docs/tinymce/6/introduction-to-powerpaste/) plugin to the rich text editor. This plugin is a premium plugin that helps you paste content from Word documents and other sources. We will configure the plugin to allow local images and clean the HTML when pasting Word documents.

{% code title="App_Plugins/MyRtePlugin/umbraco-package.json" lineNumbers="true" %}

```json
{
    "name": "My TinyMCE Plugin",
    "version": "1.0.0",
    "extensions": [
        {
            "type": "tinyMcePlugin",
            "alias": "mytinymceplugin",
            "name": "My TinyMCE Plugin",
            "js": "/App_Plugins/MyRtePlugin/plugin.js",
            "meta": {
                "config": {
                    "plugins": ["powerpaste"],
                    "powerpaste_allow_local_images": "true",
                    "powerpaste_word_import": "clean"
                }
            }
        }
    ]
}
```

{% endcode %}

2. Creating the plugin.js file

The `plugin.js` file should contain the JavaScript code to load the cloud-hosted TinyMCE premium plugins bundle. You must replace `{Cloud API Key}` with your own Cloud API key.

{% code title="App_Plugins/MyTinyMCEPlugin/plugin.js" lineNumbers="true" %}

```js
import 'https://cdn.tiny.cloud/1/{Cloud API Key}/tinymce/6/plugins.min.js';
```

{% endcode %}

We have now enabled the `powerpaste` plugin. We have configured it to allow pasting in local images. It will prompt when pasting Word documents, but for HTML documents it will clean the HTML without prompting.

{% hint style="info" %}
You can enable as many plugins as you want through the `plugins` array in the `config` object. You can even combine premium, open-source, and your own plugins as you see fit.
{% endhint %}

See all the [available premium plugins](https://www.tiny.cloud/docs/tinymce/6/plugins/#premium-plugins) on the TinyMCE website.
