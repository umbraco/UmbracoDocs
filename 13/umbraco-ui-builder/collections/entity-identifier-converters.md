---
description: Using Umbraco entities as reference with an UI Builder collection
---

# Entity Identifier Converters

Umbraco stores identifiers in UDI format for most Umbraco object types.

You can read more about them in the [UDI Identifiers](../../umbraco-cms/reference/querying/udi-identifiers.md) section of the documentation.

If you want to use in your model a reference to an Umbraco object and retrieve the `Integer` or `Guid` value of it, you would need to apply a conversion process to the `UDI` value.

Use one of UI Builder's converters - `EntityIdentifierToIntTypeConverter` or `EntityIdentifierToGuidTypeConverter`. Add it as a `[TypeConverterAttribute]` to your model's foreign key property.

An entity that references an Umbraco object would look like this:

```csharp
    [TableName(TableName)]
    [PrimaryKey("Id")]
    public class MemberReview
    {
        public const string TableName = "MemberReview";

        [PrimaryKeyColumn]
        public int Id { get; set; }

        public string Title { get; set; }

        public string Content { get; set; }

        [TypeConverter(typeof(EntityIdentifierToIntTypeConverter))]
        public int MemberId { get; set; }
    }
```

You can also create a custom type converter. UI Builder will handle data persistence automatically.
