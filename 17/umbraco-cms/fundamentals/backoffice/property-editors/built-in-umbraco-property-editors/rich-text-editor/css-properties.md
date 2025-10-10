# Custom CSS properties

Customize the appearance of the Rich Text Editor with custom CSS properties.

You can customize the appearance of the Rich Text Editor using CSS properties by defining them in your CSS files.

For example, to set the minimum height of all Rich Text Editors throughout the backoffice. You could use the following CSS rule:

```css
:root {
    --umb-rte-min-height: 300px;
}
```

For general information on working with stylesheets and JavaScript in Umbraco, check [Stylesheets and JavaScript](../../../../design/stylesheets-javascript.md).

If you wanted to target a specific Rich Text Editor, you can set the [stylesheet directly in the configuration](configuration.md#stylesheets).


## Custom CSS properties reference

The following CSS properties are available for customization:

| CSS Property           | Description                                | Default Value |
| ---------------------- | ------------------------------------------ | ------------- |
| `--umb-rte-width`      | The width of the rich-text-editor          | `unset`       |
| `--umb-rte-min-width`  | The minimum width of the rich-text-editor  | `unset`       |
| `--umb-rte-max-width`  | The maximum width of the rich-text-editor  | `100%`        |
| `--umb-rte-height`     | The height of the rich-text-editor         | `100%`        |
| `--umb-rte-min-height` | The minimum height of the rich-text-editor | `100%`        |
| `--umb-rte-max-height` | The maximum height of the rich-text-editor | `100%`        |


The CSS custom properties may change in future versions of Umbraco. You can always find the latest values in the [Rich Text Editor component base class](https://github.com/umbraco/Umbraco-CMS/blob/main/src/Umbraco.Web.UI.Client/src/packages/rte/components/rte-base.element.ts) in the Umbraco CMS GitHub repository.

