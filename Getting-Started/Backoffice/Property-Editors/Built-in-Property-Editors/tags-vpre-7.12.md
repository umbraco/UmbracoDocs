---
keywords: tags property editors v7.6 version7.6
versionFrom: 7.6.0
versionTo: 7.11.2
---

# Tags
`Alias: Umbraco.Tags`

`Returns: CSV` or `JSON`

The Tags property editor allows you to add multiple tags to a node.

## Data Type Definition Example

![Data Type Definition Example](images/tags/configuration.png)

### Tag group

The **Tag group** setting provides a way to categorize your tags in groups. So for each category you will create a new instance of the Tags property editor and setup the unique category name for each instance. Whenever a tag is added to an instance of the tags property editor it's added to the tag group, which means it will appear in the Typeahead list when you start to add another tag. Only tags that belong to the specified group will be listed. So if you have a "Frontend" group and a "Backend" group the tags from the "Frontend" group will only be listed if you're adding a tag to the Tags property editor configured with the "Frontend" group name and vice versa.

### Storage type

Data can be saved in either CSV format or in JSON format. By default data is saved in CSV format. The difference between using CSV and JSON is that with JSON you can save a tag, which includes comma separated values.

Since the release of Umbraco 7.6 there are built-in property value converters, which means you don't need to worry about writing them yourself or parse the JSON output when choosing "JSON" in the storage type field. Therefore [the last code example](mvc-view-example-displays-a-list-of-tags) on this page will work out of the box without further ado.

## Content Examples

### CSV tags

![CSV tags example](images/tags/7_6/csv-example.png)

### JSON tags

![JSON tags example](images/tags/7_6/json-example.png)

### Tags typeahead

Whenever a tag has been added it will be visible in the typeahead when you start typing on other pages.

![Tags typeahead example](images/tags/7_6/typeahead.png)

## MVC View Example - displays a list of tags

### Typed:

    @if(Model.Content.Tags.Any()){
        <ul>
            @foreach(var tag in Model.Content.Tags){
                <li>@tag</li>
            }
        </ul>
    }

