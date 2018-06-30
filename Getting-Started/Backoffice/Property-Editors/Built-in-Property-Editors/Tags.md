# Tags
`Alias: Umbraco.Tags`
`Returns: CSV` or `JSON`

The Tags property editor allows you to add multiple tags to a node.

## Data Type Definition Example

![Data Type Definition Example](images/tags/configuration.png)

Data can be saved in either CSV format or in JSON format. By default data is saved in CSV format. The difference between using CSV and JSON is that with JSON you can save a tag, which includes comma seperated values.

Since the release of Umbraco 7.6 there are built-in property value converters, which means you don't need to worry about writing them yourself or parse the JSON output when choosing "JSON" in the storage type field. Therefore code example last on this page will work out of the box without further ado.

## Content Examples

### CSV tags

![CSV tags example](images/tags/7.6/csv-example.png)

### JSON tags

![JSON tags example](images/tags/7.6/json-example.png)

### Tags typeahead

Whenever a tag has been added it will be visible in the typeahead when you start typing on other pages.

![Tags typeahead example](images/tags/7.6/typeahead.png)

## MVC View Example - displays a list of tags

### Typed:

    @if(Model.Content.Tags.Any()){
        <ul>
            foreach(var tag in Model.Content.Tags){
                <li>@tag</li>
            }
        </ul>
    }

