# Extending

Umbraco Forms functionality can be extended in different ways.

For front-end extensions, specifically via theming, see the [Themes](../themes.md) section.

## Extending the Backoffice
Umbraco Forms publishes an NPM package called `@umbraco-forms/backoffice` that holds typings and other niceties to build extensions.

{% hint style="warning" %}
Ensure that you install the version of the Backoffice package compatible with your Umbraco Forms installation. You can find the appropriate version on the [@umbraco-forms/backoffice npm page](https://www.npmjs.com/package/@umbraco-forms/backoffice).
{% endhint %}

You can install this package by running the command:

```bash
npm install -D @umbraco-forms/backoffice@x.x.x
```

This will add a package to your devDependencies containing the TypeScript definitions for Umbraco Forms.

**TSConfig**

Make sure to configure your TypeScript compiler so it includes the Global Types from the package. This enables you to utilize the declared Extension Types. If your project is using other Packages that provide their Extension Types, list these as well.

In your `tsconfig.json` file, add the array `types` inside `compilerOptions`, with the entry of `@umbraco-forms/backoffice`:

```json
{
    "compilerOptions": {
        ...
        "types": [
            ...
            "@umbraco-forms/backoffice"
        ]
    }
}
```

**Take extra care when using Vite**

It is important that this namespace is ignored in your bundler. If you are using Vite, you can add the following to your `vite.config.ts` file:

```ts
import { defineConfig } from "vite";

export default defineConfig({
    // other config
    // ...
    // add this to your config
    build: {
        rollupOptions: {
            external: [/^@umbraco/],
        },
    }
});
```

This ensures that the Umbraco Backoffice packages are not bundled with your package.

Read more about using Vite with Umbraco in the [Vite Package Setup](umbraco-cms/customizing/development-flow/vite-package-setup.md) article.

## Developing Custom Providers

Although the Forms package comes with many fields, workflows and other built-in types, you can still create and develop your own if needed.

### [Provider model](adding-a-type.md)

Many features of Forms use a provider model, which makes it quicker to add new parts to the application.

The model uses the notion that everything must have a type to exist. The type defines the capabilities of the item. For instance a Textfield on a form has a FieldType, this particular field type enables it to render an input field and save text strings. The same goes for workflows, which have a workflow type, datasources which have a datasource type and so on. Using the model you can seamlessly add new types and thereby extend the application.

It is possible to add new Field types, Data Source Types, Prevalue Source Types, Export Types, and Workflow Types.

### [Field types](adding-a-fieldtype.md)

A field type handles rendering of the UI for a field in a form. It renders a standard ASP.NET Razor partial view and is able to return a list of values when the form is saved.

The concept of provider settings, common to the field and other types, is also discussed in this section.

### Data Source Types

A data source type enables Umbraco Forms to connect to a custom source of data. A data source consists of any kind of storage if it is possible to return a list of fields Umbraco Forms can map values to. For example: a Database data source can return a list of columns Forms can send data to. This enables Umbraco Forms to map a form to a data source. A data source type is responsible for connecting Forms to external storage.

### [Prevalue Source Types](adding-a-prevaluesourcetype.md)

A prevalue source type connects to 3rd party storage to retrieve values. These values are used on fields supporting prevalues. The source fetches the collection of values.

### [Workflow Types](adding-a-workflowtype.md)

A workflow can be executed each time a form changes state (when it is submitted for instance). A workflow is responsible for executing logic which can modify the record or notify 3rd party systems.

### [Export Types](adding-a-exporttype.md)

Export types are responsible for turning form records into any other data format, which is then returned as a file.

### [Magic String Format Functions](adding-a-magic-string-format-function.md)

Custom magic string format functions to add to the [ones shipped with Umbraco Forms](../magic-strings.md#formatting-magic-strings) can be created in code.

### [Validation Patterns](adding-a-validation-pattern.md)

When creating a text field in Umbraco Forms, a validation pattern in the form of a regular expression can be applied. Default patterns can be removed or re-ordered, and custom ones created and added.

## Handling Forms Events

Another option for extension via custom code is to hook into one of the many events available.

### [Validation](adding-an-event-handler.md)

Form events are raised during the submission life cycle and can be handled for executing custom logic.

### [Default Fields and Workflows](customize-default-workflows.md)

When a new form is created, the default behavior is to add a single workflow. This workflow will send a copy of the form to the current backoffice user's email address.

A single "data consent" field will also be added unless it has been disabled via configuration.

It's possible to amend this behavior and change it to fit your needs.

## Responding to State Values

In the course of submitting a form, Umbraco Forms will set values in `TempData` and/or `HttpContext.Items`, that you can use to customize the website functionality.

### Customizing Post-Submission Behavior

Whether displaying a message or redirecting, a developer can customize the page viewed after the form is submitted based on the presence of `TempData` variables.

One variable with a key of `UmbracoFormSubmitted` has a value containing the Guid identifier for the submitted form.

A second variable contains the Guid identifier of the record created from the form submission. You can find this using the `Forms_Current_Record_id` key.

In order to redirect to an external URL rather than a selected page on the Umbraco website, you will need to use a [custom workflow](adding-a-workflowtype.md). Within this workflow you can set the required redirect URL on the `HttpContext.Items` dictionary using the key `FormsRedirectAfterFormSubmitUrl` (defined in the constant `Umbraco.Forms.Core.Constants.ItemKeys.RedirectAfterFormSubmitUrl`).

For example, using an injected instance of `IHttpContextAccessor`:

```
_httpContextAccessor.HttpContext.Items[Constants.ItemKeys.RedirectAfterFormSubmitUrl] = "https://www.umbraco.com";
```
