# Date Time (Unspecified)

`Schema Alias: Umbraco.DateTimeUnspecified`

`UI Alias: Umb.PropertyEditorUi.DateTimePicker`

`Returns: DateTime?`

The Date Time (Unspecified) property editor provides a comprehensive interface for selecting dates and times without time zone information.

## Key Features

- Calendar-based date selection
- Configurable time precision (hours/minutes or hours/minutes/seconds)
- No time zone handling - stores pure date/time values
- Returns strongly-typed `DateTime?` values
- Compatible with existing DateTime-based editors

## Configuration
You can configure this property editor in the same way as any standard property editor, using the *Data Types* admin interface.

To set up a property using this editor, create a new *Data Type* and select **Date Time (unspecified)** from the list of available property editors.

You will see the configuration options as shown below.

![Date Time Unspecified property editor configuration](../built-in-umbraco-property-editors/images/date-time-unspecified-property-editor-config.png)

- **Time format** - Specifies the level of precision for time values shown and stored by the editor.

### Time format

- **HH:mm** - Displays hours and minutes (e.g., `14:30`).  
Suitable for most general use cases.  
![Date Time Unspecified property editor showing time format in HH:mm format (hours and minutes only)](../built-in-umbraco-property-editors/images/date-time-time-format-hhmm.png)
- **HH:mm:ss** - Displays hours, minutes, and seconds (e.g., `14:30:45`).  
Use this when you need more precise timing.  
![Date Time Unspecified property editor showing time format in HH:mm:ss format (hours, minutes, and seconds)](../built-in-umbraco-property-editors/images/date-time-time-format-hhmmss.png)

## Editing experience

### Adding or editing a value

You will be presented with a date and time input. Unlike the time zone version, this editor focuses only on the date and time components.

![Date Time Unspecified property editor interface](../built-in-umbraco-property-editors/images/date-time-unspecified-editor.png)

## Rendering

The value returned will have the type `DateTime?`.

### Display the value

With Models Builder:
```csharp
@Model.EventDateTime.Value
```

Without Models Builder:
```csharp
@Model.Value<DateTime?>("eventDateTime")
```

## Add values programmatically

When working with this property editor programmatically, understand that it stores values as a JSON object. The object contains the date (as an ISO 8601 string).

### Storage format

The property editor stores values in this JSON format:
```json
{
    "date": "2025-01-01T00:00:00+00:00"
}
```

The property editor handles unspecified date times with no time zone information. The value is stored with offset +00:00 for consistency. The offset is not used unless you replace the property editor with the Date Time (with time zone) version.

1. Create a C# model that matches the JSON schema.

    ```csharp
    using System.Text.Json.Serialization;

    namespace UmbracoProject;

    public class DateTimeWithTimeZone
    {
        /// <summary>
        /// The date and time value, represented as a <see cref="DateTimeOffset"/>.
        /// </summary>
        [JsonPropertyName("date")]
        public DateTimeOffset Date { get; init; }
    }
    ```

2. Create an instance of the class with the desired values.
    ```csharp
    var value = new DateTimeWithTimeZone
    {
        Date = DateTimeOffset.Now // The date and time value to store.
    };
    ```
3. Inject the `IJsonSerializer` and use it to serialize the object.
    ```csharp
    var jsonValue = _jsonSerializer.Serialize(value);
    ```
4. Inject the `IContentService` to retrieve and update the value of a property of the desired content item.
    ```csharp
    IContent content = _contentService.GetById(contentKey) ?? throw new Exception("Content not found");

    // Set the value of the property with alias 'currentDate'. 
    content.SetValue("eventDateTime", jsonValue);

    // Save the change
    _contentService.Save(content);
    ```
