# Generate UDA files

Sometimes our guides requires you to generate UDA files for your projects metadata. Every time you create something in the backoffice on your Umbraco Cloud project a UDA files will be generated.

Generating UDA files manually ensures that you have everything you need in order to deploy successfully from one environment to another.

## What are UDA files?

When you create something in the backoffice of your Umbraco Cloud project and hit save, a UDA file will be generated.

The UDA file contains metadata and detailed information about the type that was created.

Here's an example of what a UDA file looks like for Umbraco Deploy 2:

    {
        "DefaultTemplate": null,
        "AllowedTemplates": [],
        "Icon": "icon-document",
        "Thumbnail": "folder.png",
        "Description": null,
        "AllowedAtRoot": false,
        "IsContainer": false,
        "Parent": null,
        "AllowedChildContentTypes": [],
        "CompositionContentTypes": [
            "umb://document-type/4c04d968448747d791b5eae254afc7ec"
        ],
        "PropertyGroups": [],
        "PropertyTypes": [],
        "Udi": "umb://document-type/f76e64bec5e741cd801b290c54bb16de",
        "Dependencies": [
            {
            "Udi": "umb://document-type/4c04d968448747d791b5eae254afc7ec",
            "Ordering": true,
            "Mode": 0
            }
        ],
        "Name": "TextPage2",
        "Alias": "textPage2",
        "__type": "Umbraco.Deploy,Umbraco.Deploy.Artifacts.DocumentTypeArtifact",
        "__version": "2.0.3"
    }

This UDA file represents a Document Type with name **TextPage2**. All dependencies for the document type is listed in the file and also metadata like `AllowedAtRoot` and `Icon`.

UDA files are generated for the following types:

* Data types
* Data type containers
* Dictionary items
* Document types
* Document type container
* Languages
* Macros
* Media types
* Member types
* Relation types
* Templates

## Generate UDA files manually

Follow these steps to generate UDA files:

1. Access Kudu
2. Navigate to **CMD** under the **Debug console** menu
3. In the file structure, navigate to `site/wwwroot/data`
4. Type the following command in the CMD console: `echo > deploy-export`
5. The Deploy engine will generate UDA files for all the types in your project
6. When it's done you'll end up with a `deploy-complete` marker
7. Final step is to run an extraction, making sure you can get a `deploy-complete` marker - see [**Run an extraction**](../Manual-extractions) article

Generating UDA files manually might sometimes end up giving you collision errors on your environments due to duplicates. This can be resolved by following our [Structure Error](../../../Troubleshooting/Structure-Error) documentation.

Find general information about Kudu and how to access the tool in the [Power tools](../) article.