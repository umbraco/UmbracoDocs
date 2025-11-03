---
description: Learn how to create media items in Umbraco using the Developer MCP server
---

# Creating Media

The Developer MCP server provides powerful tools for creating media items with AI agents. You can upload media from local files, remote URLs, or base64-encoded data, making it easy to automate media management tasks.

## Available Media Creation Tools

The MCP server provides two primary tools for creating media:

- **`create-media`** - Create a single media item
- **`create-media-multiple`** - Batch create up to 20 media items at once

These tools are available when the `media` tool collection is enabled.

## Supported Media Types

The Developer MCP server supports all standard Umbraco media types, plus any custom media types you've defined:

| Media Type        | Description                                      | 
|-------------------|--------------------------------------------------|
| Image             | Standard images with focal point and cropping    | 
| File              | Generic file storage                             | 
| Article           | Document files                                   | 
| Audio             | Audio files                                      | 
| Video             | Video files                                      |
| SVG               | Vector graphics (.svg)   | 

Custom media types created in your Umbraco installation are also supported and can be referenced by name.

## Source Types

You can create media from three different sources:

### File Path

Upload media from files on your local filesystem. This is the most efficient method for local files.

**Requirements:**
- The `UMBRACO_ALLOWED_MEDIA_PATHS` environment variable must be configured with allowed directories
- File paths must be absolute paths
- Files must exist within the allowed directories

**Example prompt:**
```
Upload the product image bicycle.jpg as "Product Photo"
to the Products media folder
```

**Security Note:** The MCP server validates all file paths to prevent directory traversal attacks and ensures files are only accessed from explicitly allowed directories.

### URL

Download and upload media from web URLs. The MCP server fetches the content and creates the media item.

**Requirements:**
- Valid HTTP/HTTPS URL
- Accessible resource (30-second timeout)
- Appropriate file extension or Content-Type header

**Example prompt:**
```
Download the image from https://example.com/images/hero.jpg and create
a media item called "Homepage Hero"
```

### Base64

Upload media from base64-encoded data. This method is suitable for small files (e.g svg) but should be used sparingly due to increased token usage.

**Best Practices:**
- Use only for small files (under 5KB recommended)
- Prefer file path or URL methods when possible
- Base64 encoding significantly increases the size of data sent

**Example prompt:**
```
Create an svg media item of a unicorn 
```

## Configuration

### Environment Variables

To use file path uploads, configure the allowed directories in your MCP server environment:

```json
{
  "umbraco-mcp": {
    "command": "npx",
    "args": ["@umbraco-cms/mcp-dev@beta"],
    "env": {
      "UMBRACO_CLIENT_ID": "your-client-id",
      "UMBRACO_CLIENT_SECRET": "your-client-secret",
      "UMBRACO_BASE_URL": "https://localhost:12345",
      "UMBRACO_ALLOWED_MEDIA_PATHS": "/users/username/downloads",
      "UMBRACO_INCLUDE_TOOL_COLLECTIONS": "media"
    }
  }
}
```

Multiple paths can be specified by separating them with commas.

## Advanced Features

### Automatic SVG Detection

The MCP server automatically detects SVG files and corrects the media type from "Image" to "SVG" if needed:

**Prompt:**
```
Upload /Users/username/icons/logo.svg as "Company Logo"
```

Even if you specify "Image" as the media type, the server will automatically use "SVG" for .svg files.

### Focal Point for Images

Image media items are automatically created with a center focal point (0.5, 0.5). Use the update media tool to change the focal point after creation.

### Missing File Extensions from URLs

When downloading from URLs without file extensions, the MCP server detects the file type from the Content-Type header:

**Prompt:**
```
Download the image from https://api.example.com/image/123 and create
a media item
```

The server adds the appropriate extension based on the response headers.


## Usage Examples & Common Scenarios

### Creating a Single Image

Upload a local image file to a specific media folder:

**Prompt:**
```
Upload the file team-photo as "Team Photo 2024"
to the Team Photos media folder
```

The MCP server will:
1. Validate the file path is allowed
2. Determine the appropriate media type (Image)
3. Upload the file to Umbraco's temporary storage
4. Create the media item with correct properties
5. Clean up temporary files

### Batch Creating Media

Upload multiple files at once (up to 20 files per batch):

**Prompt:**
```
Upload all images from the product-photos folder to the
Products media folder
```

The MCP server processes files sequentially and provides a summary of successes and failures. Individual file errors don't stop the batch processing.

### Creating Media from URLs

Download and upload media from remote sources:

**Prompt:**
```
Download these product images and upload them to the Products folder:
- https://cdn.example.com/products/item1.jpg as "Product 1"
- https://cdn.example.com/products/item2.jpg as "Product 2"
- https://cdn.example.com/products/item3.jpg as "Product 3"
```

### Creating Media with Specific Types

Explicitly specify the media type:

**Prompt:**
```
Upload the PDF from manual.pdf as "User Manual"
with media type "Bespoke Article" to the Documentation folder
```

### Migrating Media from External Sources

Import media files from an external system:

**Prompt:**
```
Download all images listed in this CSV file and upload them to Umbraco with
the specified names and folder structure
```

### Organizing Existing Downloads

Process files from your downloads folder:

**Prompt:**
```
Upload all PDF files from downloads to the Documents
media folder, using their filenames as media names
```

### Creating Product Media

Set up a new product catalog with images:

**Prompt:**
```
Create a "Product Catalog 2024" folder and upload all images from
/Users/username/products/ into it, organizing by subfolder names
``'