# Configuring block editor label properties

When configuring a block, the label property allows you to define a label for the appearance of the Block in the editor. The label can use AngularJS template string syntax to display values of properties. Example: `My Block {{myPropertyAlias}}` will be shown as: `My Block FooBar`.

You can also use more advanced expressions using AngularJS filters. Example: `{{myPropertyAlias | limitTo:100}}` or for a property using Richtext editor `{{myPropertyAlias | ncRichText | truncate:true:100}}`.

It is also possible to use properties from the settings model by using `{{$settings.propertyAlias}}`.

## Useful Angular filters

As well as the [default AngularJS filters](https://docs.angularjs.org/api/ng/filter), Umbraco ships with some additional filters which are useful for setting the Label field of Block editors.

| Filter                                                       | Description                                             | Property type               | Parameters                                                   |
| ------------------------------------------------------------ | ------------------------------------------------------- | --------------------------- | ------------------------------------------------------------ |
| ncNodeName                                                   | Gets the name of a node                                 | Umbraco node                |                                                              |
| ncRichText                                                   | Strips HTML                                             | Richtext editor             |                                                              |
| [limitTo](https://docs.angularjs.org/api/ng/filter/limitTo)  | AngularJS native truncate                               | String                      | n: maximum length of the string                              |
| [truncate](https://apidocs.umbraco.com/v10/ui/#/api/umbraco.filters.filter:truncate) | Umbraco's richer truncate function                      | String                      | wordwise: boolean to indicaste whether to truncate a string mid-word or not<br />max: maximum length of the string<br />tail (optional): string to indicate a truncated string, "`…`" by default |
| [umbWordLimit](https://apidocs.umbraco.com/v10/ui/#/api/umbraco.filters.filter:umbWordLimit) | Truncates to a number of words (rather than characters) | String                      | n: maximum number of words in string                         |
| [umbCmsTitleCase](https://apidocs.umbraco.com/v10/ui/#/api/umbraco.filters.filter:umbCmsTitleCase) | Converts a string to title case                         | String                      |                                                              |
| [umbCmsJoinArray](https://apidocs.umbraco.com/v10/ui/#/api/umbraco.filters.filter:umbCmsJoinArray) | Joins an array into one string                          | Array (of string or object) | separator: string used to join values together, e.g. "`, `"<br />prop (optional): string key indicating which property to join when used on an array of objects |

### Custom filters

If the filters do not suit your needs, you can create custom filters by creating a plugin in `App_Plugins` and adding a filter module. You can see an example below:

{% hint style="warning" %}
If you do not have an `/App_Plugins` folder, you can create it at the root of your project.
{% endhint %}

1. Create a plugin by adding a folder inside `App_Plugins` called `MyFilters`
2. Inside the `MyFilters` folder add a `package.manifest` file containing:

```json
{
    "name": "MyFilters",
    "version": "1.0.0",
    "allowPackageTelemetry": false,
    "javascript": [
        "/App_Plugins/MyFilters/myFilter.filter.js"
    ]
}
```

3. Add a `myFilter.filter.js` file containing:

```javascript
angular.module("umbraco.filters").filter("myFilter", function () {
  return function (input, parameter1, parameter2, etc) {
      // Apply any custom logic to modify the output value and return a string
      return `My filter says: "${input}"`;
  }
});
```

4. Implement a [block editor](README.md) of your choice. When adding a label add `{{ myFilter }}` which is the property alias of the element type. The `myFilter` property has a `textstring` editor. When adding the content, the block editor will then display the data that you input.

## Special variables

| Variable    | Description                                                  |
| ----------- | ------------------------------------------------------------ |
| `$index`    | The 1-based index of this block item in the current block list |
| `$settings` | Provides access to the settings model for the block (if configured) |
