# Generate UDA files

{% hint style="info" %}
If you are running Deploy 4+, we recommend you generate Umbraco Deploy Artifact (UDA) files from the Deploy Dashboard instead of KUDU. For more information, see the [Deploy Dashboard](../deployment/deploy-operations/extract-schema-to-data-files.md).
{% endhint %}

Sometimes our guides require you to generate UDA files for your project's metadata. Every time you create something in the backoffice on your Umbraco Cloud project, UDA files will be generated.

Generating UDA files manually ensures that you have everything you need to deploy successfully from one environment to another.

## What are UDA files?

When you create something in the backoffice of your Umbraco Cloud project and hit save, a UDA file will be generated.

The UDA file contains metadata and detailed information about the type that was created.

Here's an example of what a UDA file looks like for a Blog Page:

```json
{
  "Name": "Blog",
  "Alias": "Blog",
  "DefaultTemplate": "umb://template/fa51596e66574dc7b2839354be1c0ddf",
  "AllowedTemplates": [
    "umb://template/fa51596e66574dc7b2839354be1c0ddf"
  ],
   "HistoryCleanup": {
    "preventCleanup": false,
    "keepAllVersionsNewerThanDays": null,
    "keepLatestVersionPerDayForDays": null
  },
  "Icon": "icon-calendar-alt color-black",
  "Thumbnail": "folder.png",
  "Description": null,
  "IsContainer": true,
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
  "CompositionContentTypes": [
    "umb://document-type/4ff4a1fc24db489abdd2532081dbc62f",
    "umb://document-type/e24e6d11800547d99078219a2182f34f"
  ],
  "PropertyGroups": [
    {
      "Key": "964c16db-bf0b-4ffd-a993-423533cb5ad5",
      "Name": "Settings",
      "SortOrder": 0,
      "Type": 0,
      "Alias": "settings",
      "PropertyTypes": [
        {
          "Key": "5ed407a1-9ab5-403e-b1dd-6405c2f3e421",
          "Alias": "howManyPostsShouldBeShown",
          "DataType": "umb://data-type/9d5ba2c5ed7a41f8b4549fc65f48752e",
          "Description": null,
          "Mandatory": true,
          "Name": "How many posts should be shown?",
          "SortOrder": 0,
          "Validation": null,
          "VariesByCulture": false,
          "VariesBySegment": false,
          "LabelOnTop": false,
          "MemberCanEdit": false,
          "ViewOnProfile": false,
          "IsSensitive": false
        }
      ]
    }
  ],
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
  "__version": "10.0.0-rc6"
}
```

This UDA file represents a Document Type with the name **Blog**. All dependencies for the document type are listed in the file and metadata like `AllowedAtRoot` and `Icon`.

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
6. When it's done, you'll end up with a `deploy-complete` marker.
7. Run an extraction, making sure you can get a `deploy-complete` marker - see [**Run an extraction**](manual-extractions.md) article.

Generating UDA files manually might sometimes end up giving you collision errors on your environments due to duplicates. This can be resolved by following our [Structure Error](../resolve-issues-quickly-and-efficiently/deployments/structure-error.md) documentation.

Find general information about Kudu and how to access the tool in the [Power tools](./) article.
