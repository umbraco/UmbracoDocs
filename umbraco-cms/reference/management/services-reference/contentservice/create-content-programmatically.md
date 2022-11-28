# Create content programmatically

In the example below, a new page is programmatically created using the content service. It is assumed that there are two document types, namely people and person. In this case, a new person is added underneath the people page.

```csharp
// Get access to ContentService
var contentService = Services.ContentService;

// Create a variable for the GUID of the parent where you want to add a child item.
// In this case the people page. 
var parentId = Guid.Parse("b6fbbb31-a77f-4f9c-85f7-2dc4835c7f31");

// Create a new child item of type 'person'
var person = contentService.Create("James", parentId, "person"); 

// Set the value of the property with alias 'email'
person.SetValue("email" , "james@contact.com");

// Set the value of the property with alias 'isAuthor'
person.SetValue("isAuthor", false);

// Save the child item
contentService.Save(person);
```
