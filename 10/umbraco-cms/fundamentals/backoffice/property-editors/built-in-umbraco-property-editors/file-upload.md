# File Upload

`Alias: Umbraco.UploadField`

`Returns: string`

Adds an upload field, which allows documents or images to be uploaded to Umbraco.

You can define which file types should be accepted through the upload field.

{% hint style="info" %}
For uploading and adding files and images to your Umbraco project, we recommend using the Media Picker.

Find the full documentation for the property in the [Media Picker](media-picker-3.md) article.
{% endhint %}

## Data Type Definition Example

![Data Type Definition Example](../built-in-property-editors/images/definition-example-v10.png)

## Content Example

![Content Example Empty](../built-in-property-editors/images/content-example-empty.png) ![Content Example](../built-in-property-editors/images/File-Upload-content-example.png)

In code, the property is a string, which references the location of the file.

Example: `"/media/o01axaqu/guidelines-on-remote-working.pdf"`

## MVC View Example

### Without Modelsbuilder

```csharp
@using System.IO;
@{
    if (Model.HasValue("myFile"))
    {
        var myFile = Model.Value<string>("myFile");

        <a href="@myFile">@System.IO.Path.GetFileName(myFile)</a>
    }

}
```

### With Modelsbuilder

```csharp
@if (!Model.HasValue(Model.MyFile))
{
   <a href="@Model.MyFile">@System.IO.Path.GetFileName(Model.MyFile)</a>
}
```

## Add values programmatically

{% hint style="info" %}
The samples in this section have not been verified against the latest version of Umbraco.

Instead, we recommend using the [Media Picker](media-picker-3.md) for uploading files to your Umbraco website.
{% endhint %}

See the example below to see how a value can be added or changed programmatically. To update a value of this property editor you need the [Content Service](../../../../reference/management/services/contentservice/) and the [Media Service](../../../../reference/management/services/mediaservice.md).

{% hint style="info" %}
The example below demonstrates how to add values programmatically using a Razor view. However, this is used for illustrative purposes only and is not the recommended method for production environments.
{% endhint %}

```csharp
@using Umbraco.Cms.Core.IO
@using Umbraco.Cms.Core.Serialization
@using Umbraco.Cms.Core.Strings
@inject MediaFileManager _mediaFileManager;
@inject IShortStringHelper _shortStringHelper;
@inject IContentTypeBaseServiceProvider _contentTypeBaseServiceProvider;
@inject IContentService Services;
@inject IJsonSerializer _serializer;
@inject MediaUrlGeneratorCollection _mediaUrlGeneratorCollection;

@{
   // Get access to ContentService
    var contentService = Services;

    // Get access to MediaService 
    var mediaService = MediaService;

    // Create a variable for the GUID of the parent where you want to add a child item
    var guid = Guid.Parse("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = contentService.GetById(guid); // ID of your page

    // Create a variable for the file you want to upload, in this case the Our Umbraco logo
    var imageUrl = "https://our.umbraco.com/assets/images/logo.svg";

    // Create a request to get the file
    var request = WebRequest.Create(imageUrl);
    var webResponse = request.GetResponse();
    var responseStream = webResponse.GetResponseStream();

    // Get the file name 
    var lastIndex = imageUrl.LastIndexOf("/", StringComparison.Ordinal) + 1;
    var filename = imageUrl.Substring(lastIndex, imageUrl.Length - lastIndex);

    // Create a media file
    var media = mediaService.CreateMediaWithIdentity("myImage", -1, "File");
    media.SetValue(_mediaFileManager, _mediaUrlGeneratorCollection, _shortStringHelper, _contentTypeBaseServiceProvider, Constants.Conventions.Media.File, filename, responseStream);
    // Save the created media 
    mediaService.Save(media);

    // Get the published version of the media (IPublishedContent)
    var publishedMedia = Umbraco.Media(media.Id);

    // Set the value of the property with alias 'myFile' 
    content.SetValue("myFile", publishedMedia.Url());

    // Save the child item
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
@inject IPublishedSnapshotAccessor _publishedSnapshotAccessor;
@{
    // Set the value of the property with alias 'myFile'
    content.SetValue(Home.GetModelPropertyType(_publishedSnapshotAccessor, x => x.MyFile).Alias, publishedMedia.Url();
}
```
