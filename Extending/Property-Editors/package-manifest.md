# Package Manifest
The package.manifest JSON file format is used to describe one or more custom Umbraco property editors. This page outlines the file format and properties found in the JSON

## Sample Manifest
This is a sample manifest, it is always stored in a folder in `/App_Plugins/{YourPackageName}`, with the name `package.manifest`

    {
        "propertyEditors": [
            {
                "alias": "Sir.Trevor",
                "name": "Sir Trevor",
                "editor": {
                    "view": "~/App_Plugins/SirTrevor/SirTrevor.html",
                    "hideLabel": true,
                    "valueType": "JSON"
                }
            }
        ],
        "javascript": [
            "~/App_Plugins/SirTrevor/SirTrevor.controller.js"
        ]
    }

## Root elements
The manifest can contain 4 root colllections, none of them are mandatory

    {
        "propertyEditors": [],
        "parameterEditors": [],
        "javascript": [],
        "css": []
    }

## Property Editors
`propertyEditors` returns an array of editor objects, each object specifies an editor to make available to data types as an editor component. These editors are primarily property editors for content, media and members, but can also be made available as a macro parameter editor.

The basic values on any editor is `alias`, `name`, and `editor` these three **must** be set. Furthermore the editor value is an object with additional configuration options on, but must contain a view value.

    {
        "alias": "my.editor.alias",
        "name": "My friendly editor name",
        "editor": {
            view: "~/App_Plugins/SirTrevor/view.html"
        },
        "prevalues": {
            fields: []
        }
    }

* `alias` The alias of the editor, this must be unique, its recommended to prefix with your own "namespace"
* `name` The name visible to the user in the ui, should also be unique.
* `editor` Object containing editor configuration (see below)
* `isParameterEditor` enables the property editor as a macro parameter editor can be true/false
* `prevalues` Configuration of editor prevalues (see below)
* `defaultConfig` Default configation values (see below)
* `icon` A CSS class for the icon to be used in the 'Select Editor' dialog: eg `icon-autofill`
* `group` The group to place this editor in within the 'Select Editor' dialog. Use a new group name or alternatively use an existing one such as `Pickers`
* `defaultConfig` Provides a collection of default configuration values, in cases the property editor is not configured or is used a parameter editor, which doesnt allow configuration. The object is a key/value collection and must match the `prevalues` fields keys.

### Editor
`editor` Besides setting a view, the editor can also contain additional information.

    "editor": {
        "view": "~/App_Plugins/SirTrevor/view.html",
        "hideLabel": true,
        "valueType": "TEXT",
        "validation": {},
        "isReadOnly": false 
    }

* `view` Path to the html file to use for rendering the editor
* `hideLabel` Turn the label on/off
* `valueType` Sets the DB type the value is stored as, by default its `string`
* `validation` Object describing required validators on the editor
* `isReadOnly` Disables editing the value

`valueType` sets what kind of data the editor will save in the database. by default this is set to `string`. The available options are:
* `STRING` Stores the value as an nvarchar in the database
* `DATETIME` Stores the value as datetime in the database
* `TEXT` Stores the value as ntext in the database
* `INT` Stores the value as a bigint in the database
* `JSON` Stored as ntext, but automatically serialized to dynamic object

### Pre Values
`preValues` is a collection of prevalue editors, used for configuring the property editor, the prevalues object must return an array of editors, called `fields`.

    "prevalues": {
        "fields": [
            {
                "label": "Enable something",
                "description": "This is a describtion",
                "key": "enableStuff",
                "view": "boolean"
            }            
        ]
    }

Each field contains a number of configuration values:
* `label` The label shown on the data type configuration screen
* `description` Help text displayed underneath the label
* `key` The key the prevalue is stored under (see below)
* `view` Path to the editor used to configure this prevalue (see below)

`key` on a prevalue, determines where its stored in the database, so if you give your prevalue the key "wolf" - then this key will be used in the prevalue table.

But it also means that when this property editor is used on a property, then this prevalue will be exposed on the models configuration object like below, inside the property editors controller:

    //this is the property value
    $scope.model.value = "hello";

    ///this is the configration on the property editor:
    $scope.model.config

    //this is our specific prevalue with the alias wolf
    $scope.model.config.wolf

`view` config value points the prevalue editor to an editor to use. This follows the same concept as any other editor in umbraco, but with prevalue editors there are a couple of conventions.

If you just specify a name like `boolean` then umbraco will look at `/umbraco/views/prevalueeditors/boolean/boolean.html` for the editor view - if you wish to use your own, you specify the path like `~/app_data/package/prevalue-editor.html`.

### Default Config
The defaultConfig object, provides a collection of default configuration values, in cases the property editor is not configured or is used a parameter editor, which doesnt allow configuration. The object is a key/value collection and must match the prevalue fields keys.

    "defaultConfig": {
        "wolf": "nope",
        "editor": "hello",
        "random": 1234
    }

## Parameter Editors
`parameterEditors` returns an array of editor objects, each object specifies an editor to make available to macro parameters as an editor component. These editors work solely as parameter editors, and will not show up on the property editors list.

The parameter editors array follows the same format as the property editors described above, however, it cannot contain prevalues since there are no configuration options for macro parameter editors.

## JavaScript
`javascript` returns a string[] of javascript files to load on application start

    "javascript": [
            "~/App_Plugins/SirTrevor/SirTrevor.controller.js",
            "~/App_Plugins/SirTrevor/service.js"
    ]

## CSS
`css` returns a string[] of css files to load on application start

    "css": [
            "~/App_Plugins/SirTrevor/SirTrevor.css",
            "~/App_Plugins/SirTrevor/hibba.css"
    ]


## JSON Schema
The package.manifest JSON file has a hosted online JSON Schema file that allows editors such as Visual Studio and Visual Studio Code to have autocomplete/intellisense support when creating and editing package.manifest files and avoid mistakes or errors when creating your package.manifest files.

### Setting up Visual Studio 2015

To asscoiate the hosted JSON schema file to all package.manifest files you will need to perform the following inside of Visual Studio 2015.

* Tools -> Options
* Browse down to Text Editor -> File Extension
* Add `manifest` into the Extension box
* Select `JSON Editor` from dropdown and add the mapping
* Open a `package.manifest` file and ensure in the top left hand corner you see the schema with the URL set to http://json.schemastore.org/package.manifest


### Setting up Visual Studio Code

To associate the hosted JSON schema file to all package.manifest files you will need to perform the following inside of Visual Studio Code editor.

* File -> Preferences -> User Settings
* This will open two editors side by side with the default settings on the left and custom overrides on the right
* In the right hand file add the following

    {
        "json.schemas": [
            {
                "fileMatch": [
                    "manifest.json"
                ],
                "url": "http://json.schemastore.org/package.manifest"
            }
        ]
    }
