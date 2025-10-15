# Add Values Programmatically

## Configuration

For this example, the default grid configuration has been used.

![Grid configuration](../../built-in-property-editors/grid-layout/Images/Grid-configuration.jpg)

## Set value

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](../../../../../reference/management/services/contentservice/).

```csharp
@using Newtonsoft.Json
@using Umbraco.Cms.Core.Services;
@using Umbraco.Cms.Core.Models;
@inject IContentService Services;
@{
	// Get access to ContentService
	var contentService = Services;

	// Create a variable for the GUID of the page you want to update
	var guid = Guid.Parse("32e60db4-1283-4caa-9645-f2153f9888ef");

	// Get the page using the GUID you've defined
	var content = contentService.GetById(guid); // ID of your page

	// Create a variable for the grid value with the 1 one column layout and add a headline
	var gridValue = new GridValue
	{
		Name = "1 column layout",
		Sections = new List<GridValue.GridSection>
		{
			new GridValue.GridSection
			{
				Rows = new List<GridValue.GridRow>
				{
					new GridValue.GridRow
					{
						Name = "Headline",
						Id = new Guid(),
						Areas = new List<GridValue.GridArea>
						{
							new GridValue.GridArea
							{
								Controls = new List<GridValue.GridControl>
								{
									new GridValue.GridControl
									{
										Editor = new GridValue.GridEditor
										{
											Alias = "headline"
										},
										Value = "Our Umbraco"
									}
								}
							}

						}
					}
				}

			}
		}
	};

	// Serialize the grid value
	var serializedGridValue = JsonConvert.SerializeObject(gridValue);

	// Set the value of the property with alias 'body'
	content.SetValue("body", serializedGridValue);

	// Save the change
	contentService.Save(content);
}
```

Although the use of a GUID is preferable, you can also use the numeric ID to get the page:

```csharp
@{
    // Get the page using it's id
    var content = contentService.GetById(1234); 
}
```

If Modelsbuilder is enabled you can get the alias of the desired property without using a magic string:

```csharp
@using Umbraco.Cms.Core.PublishedCache;
@inject IPublishedSnapshotAccessor _publishedSnapshotAccessor;
@{
    // Set the value of the property with alias 'body'
    content.SetValue(Home.GetModelPropertyType(_publishedSnapshotAccessor, x => x.Body).Alias, serializedGridValue);
}
```
