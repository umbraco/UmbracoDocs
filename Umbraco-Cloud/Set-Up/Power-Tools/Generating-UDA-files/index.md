---
versionFrom: 9.0.0
---

# Generate UDA files

:::note
If you are running Deploy 4+, we recommend you generate UDA files from the Deploy Dashboard instead of KUDU. For more information, see the [Deploy Dashboard](../../../Deployment/Deploy-Operations/Extract-schema-to-data-files).
:::

Sometimes our guides require you to generate UDA files for your projects metadata. Every time you create something in the backoffice on your Umbraco Cloud project a UDA files will be generated.

Generating UDA files manually ensures that you have everything you need in order to deploy successfully from one environment to another.

## What are UDA files?

When you create something in the backoffice of your Umbraco Cloud project and hit save, a UDA file will be generated.

The UDA file contains metadata and detailed information about the type that was created.

Here's an example of what a UDA file looks like for a Content Page:

```json
{
  "Name": "Content Page",
  "Alias": "contentPage",
  "DefaultTemplate": "umb://template/3b0e5e0899414c4387ed4bf919f2e254",
  "AllowedTemplates": [
    "umb://template/3b0e5e0899414c4387ed4bf919f2e254"
  ],
  "Icon": "icon-article color-red",
  "Thumbnail": "folder.png",
  "Description": null,
  "IsContainer": false,
  "Permissions": {
    "AllowVaryingByCulture": false,
    "AllowVaryingBySegment": false,
    "AllowedAtRoot": false,
    "IsElementType": false,
    "AllowedChildContentTypes": [
      "umb://document-type/dd58f94c0b3341829186ec020cf06cfa"
    ]
  },
  "Parent": null,
  "CompositionContentTypes": [],
  "PropertyGroups": [],
  "PropertyTypes": [],
  "Udi": "umb://document-type/dd58f94c0b3341829186ec020cf06cfa",
  "Dependencies": [
    {
      "Udi": "umb://document-type/dd58f94c0b3341829186ec020cf06cfa",
      "Ordering": false,
      "Mode": 0
    },
    {
      "Udi": "umb://template/3b0e5e0899414c4387ed4bf919f2e254",
      "Ordering": true,
      "Mode": 0
    }
  ],
  "__type": "Umbraco.Deploy.Infrastructure,Umbraco.Deploy.Infrastructure.Artifacts.ContentType.DocumentTypeArtifact",
  "__version": "9.0.0-beta003"
}
```

This UDA file represents a Document Type with name **Content Page**. All dependencies for the document type is listed in the file and also metadata like `AllowedAtRoot` and `Icon`.

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

1. Access Kudu.
2. Navigate to **CMD** under the **Debug console** menu.
3. In the file structure, navigate to `site/wwwroot/umbraco/Deploy`.
4. Type the following command in the CMD console: `echo > deploy-export`
5. The Deploy engine will generate UDA files for all the types in your project.
6. When it's done you'll end up with a `deploy-complete` marker.
7. Run an extraction, making sure you can get a `deploy-complete` marker - see [**Run an extraction**](../Manual-extractions/index.md) article.

Generating UDA files manually might sometimes end up giving you collision errors on your environments due to duplicates. This can be resolved by following our [Structure Error](../../../Troubleshooting/Deployments/Structure-Error/) documentation.

Find general information about Kudu and how to access the tool in the [Power tools](../) article.
