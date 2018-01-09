# Generate UDA files

Sometimes our guides requires you to generate UDA files for your projects metadata. Everytime you create something in the backoffice on your Umbraco Cloud project a UDA files will be generated.

Generating UDA files manually ensures that you have everything you need in order to deploy succesfully from one environment to another.

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

Follow these steps to generate UDA files:

1. Access Kudu
2. Navigate to **CMD** under the **Debug console** menu
3. In the file structure, navigate to `site/wwwroot/data`
4. Type the following command in the CMD console: `echo > deploy-export`
5. The Deploy engine will generate UDA files for all the types in your project
6. When it's done you'll end up with a `deploy-complete` marker
7. Final step is to run an extraction, making sure you can get a `deploy-complete` marker - see [**Run an extraction**](../Manual-extractions) article

Generating UDA files manually might sometimes end up giving you collision errors on your environments due to duplicates. This can be resolved by following our [Structure Error](../../../Troubleshooting/Structure-Error) documentation.

Find general information about Kudu and how to access the tool in the [Power tools](../Manual-extractions) article.