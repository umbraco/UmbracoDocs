---
meta.Title: Default Data/Media Types
---

# Default Data/Media Types

On this page you will find the media types and Data Types in Umbraco. These types are not created automatically after an upgrade. If you want to use the new types, you can create them yourself.

## Data Types

### UploadArticle

The `UploadArticle` Data Type has the following configuration:

* Property editor: `FileUpload`
* Accepted file extensions: `pdf`, `docx`, `doc`

### UploadAudio

The `UploadAudio` Data Type has the following configuration:

* Property editor: `FileUpload`
* Accepted file extensions: `mp3`, `weba`, `oga`, `opus`

### UploadVectorGraphics

The `UploadVectorGraphics` Data Type has the following configuration:

* Property editor: `FileUpload`
* Accepted file extensions: `svg`

### UploadVideo

The `UploadVideo` Data Type has the following configuration:

* Property editor: `FileUpload`
* Accepted file extensions: `mp4`, `webm`, `ogv`

## Media Types

### UmbracoMediaArticle

The `UmbracoMediaArticle` media type has the following properties:

* `umbracoFile` - Upload File
* `umbracoExtension` - Label (string)
* `umbracoBytes` - Label (bigint)

![MediaArticle](images/umbraco-media-article-media-type.png)

### UmbracoMediaAudio

The `UmbracoMediaAudio` media type has the following properties:

* `umbracoFile` Upload Audio
* `umbracoExtension` Label (string)
* `umbracoBytes` Label (bigint)

![MediaAudio](images/umbraco-media-audio-media-type.png)

### UmbracoMediaVectorGraphics

The `UmbracoMediaVectorGraphics` media type has the following properties:

* `umbracoFile` - Upload Vector Graphics
* `umbracoExtension` Label (string)
* `umbracoBytes` Label (bigint)

![MediaVectorGraphics](images/umbraco-media-vector-graphicsmedia-type.png)

### UmbracoMediaVideo

The `UmbracoMediaVideo` media type has the following properties:

* `umbracoFile` - Upload Video
* `umbracoExtension` - Label (string)
* `umbracoBytes` - Label (bigint)

![MediaVideo](images/umbraco-media-video-media-type.png)
