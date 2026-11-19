---
description: Well-known Umbraco IDs and constants provided by the MCP Server SDK.
---

# Constants

The SDK exports well-known Umbraco IDs for media types, user groups, data types, and member types. These are hardcoded constants from the Umbraco source code, stable across all installations. Use them instead of hardcoding GUIDs in your tools.

## Available Constants

### General

- `BLANK_UUID` — a zero UUID, used as a placeholder or default value

### Media Types

IDs and display names for the standard Umbraco media types:

- `FOLDER_MEDIA_TYPE_ID`, `IMAGE_MEDIA_TYPE_ID`, `FILE_MEDIA_TYPE_ID`, `VIDEO_MEDIA_TYPE_ID`, `AUDIO_MEDIA_TYPE_ID`, `ARTICLE_MEDIA_TYPE_ID`, `VECTOR_GRAPHICS_MEDIA_TYPE_ID`
- `MEDIA_TYPE_FOLDER`, `MEDIA_TYPE_IMAGE`, `MEDIA_TYPE_FILE`, `MEDIA_TYPE_VIDEO`, `MEDIA_TYPE_AUDIO`, `MEDIA_TYPE_ARTICLE`, `MEDIA_TYPE_VECTOR_GRAPHICS`
- `STANDARD_MEDIA_TYPES` — a lookup map from display name to media type ID

### User Groups

- `TRANSLATORS_USER_GROUP_ID`, `WRITERS_USER_GROUP_ID`

### Data Types

- `TextString_DATA_TYPE_ID`, `MEDIA_PICKER_DATA_TYPE_ID`, `MEMBER_PICKER_DATA_TYPE_ID`, `TAG_DATA_TYPE_ID`

### Member Types

- `Default_Memeber_TYPE_ID`

## Usage

Import the constants you need from the SDK:

```typescript
import {
  IMAGE_MEDIA_TYPE_ID,
  MEDIA_TYPE_IMAGE,
  STANDARD_MEDIA_TYPES,
} from "@umbraco-cms/mcp-server-sdk";
```

Use them in your tool handlers instead of hardcoding GUIDs. For example, when filtering media by type:

```typescript
if (item.mediaType.id === IMAGE_MEDIA_TYPE_ID) {
  // Handle image-specific logic
}
```

Or look up a media type ID from its display name:

```typescript
const mediaTypeId = STANDARD_MEDIA_TYPES["Image"];
```
