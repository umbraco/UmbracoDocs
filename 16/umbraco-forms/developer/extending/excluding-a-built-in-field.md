# Excluding a Built-in Field

Umbraco Forms comes with some built-in fields however it is possible to exclude/remove them if necessary.
There might some use cases where you have no use for file upload and don't want editors using them. Or perhaps you want to remove a field to replace it with one with enhanced functionality that you build yourself.

## Example

The following class shows how to exclude built-in field types using a custom composer. The `Password`, `Recaptcha2` and `RichText` field types (or "answers") will no longer be available for selection when creating a form in the backoffice.

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Forms.Core.Providers.Extensions;
using Umbraco.Forms.Core.Providers.FieldTypes;

namespace MyNamespace
{
    public class MyFormFieldsComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.FormsFields()
              .Exclude<Password>()
              .Exclude<Recaptcha2>()
              .Exclude<RichText>();
        }
    }
}
```
