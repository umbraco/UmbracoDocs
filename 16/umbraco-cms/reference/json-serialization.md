---
description: Describes how the JSON serialization within Umbraco can be customized.
---

# JSON Serialization

Umbraco uses JSON as a format to serialize information to the database and for output. For example, the configuration of data types and the property values of complex editors are serialized to JSON for persistence.

The serializers within Umbraco uses a `JavascriptEncoder` which only considers basic latin characters as unnecessary to encode.

## Implementing Custom Behavior

For projects making use of non-Latin characters you may want to amend this behavior. By doing so you can reduce the space the serialized information takes up in the database.

We support this by abstracting the default behavior behind the `IJsonSerializerEncoderFactory` interface found in the `Umbraco.Cms.Core.Serialization` namespace.

You can implement your own version of this interface and register it via a composer. This is shown in the following example that marks Cyrillic characters as excluded for encoding:

```csharp
using System.Text.Encodings.Web;
using System.Text.Unicode;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Serialization;
using Umbraco.Cms.Infrastructure.Serialization;

namespace Umbraco.Cms.Web.UI.Custom.SystemTextConfigurationEditor;

public class SystemTextConfigurationEditorComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddUnique<IJsonSerializerEncoderFactory, MyConfigurationEditorJsonSerializerEncoderFactory>();
    }
}

internal class MyConfigurationEditorJsonSerializerEncoderFactory : IJsonSerializerEncoderFactory
{
    public JavaScriptEncoder CreateEncoder<TSerializer>()
        where TSerializer : IJsonSerializer
    {
        return JavaScriptEncoder.Create(UnicodeRanges.BasicLatin, UnicodeRanges.Cyrillic);
    }
}
```

For reference, the default implementation can be found [in the Umbraco CMS source code](https://github.com/umbraco/Umbraco-CMS/blob/main/src/Umbraco.Infrastructure/Serialization/DefaultJsonSerializerEncoderFactory.cs).


