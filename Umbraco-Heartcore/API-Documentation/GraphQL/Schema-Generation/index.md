---
versionFrom: 8.0.0
meta.Title: "Umbraco Heartcore GraphQL Schema Generation"
meta.Description: "Documentation for Umbraco Heartcore GraphQL schema generation"
---

# Schema Generation

The GraphQL schema is generated from the Content Types upon creation, and it is generated when a Content Type or a Data Type is changed.

The type name is the Content Type's alias in Pascal Case, e.g. if a Content Type has an alias of `product` it's GraphQL type name would be `Product`.

## Types

The types generated depends on how the Content Types are configured.

If a Content Type is used as a [Composition](../../../../Getting-Started/Data/Defining-content/#creating-a-document-type) it will be generated as an interface

```graphql
interface NavigationBase {
  seoMetaDescription: String
  umbracoNavihide: Boolean
}
```

If the Document Type is marked as an Element Type it will implement the [Element](#element) interface

```graphql
type Feature implements Element {
  contentTypeAlias: String!
  featureName: String
  featureDescription: String
}
```

All other Content Types will implement either the [Content](#content) or the [Media](#media) interface, they will also implement all their Composition interfaces.

```graphql
type Product implements Content & NavigationBase {
  ancestors(...): ContentConnection!
  category: [String]
  children(...): ContentConnection!
  contentTypeAlias: String!
  createDate: DateTime!
  descendants(...): ContentConnection!
  description: String
  features: [Element]
  id: ID!
  level: Int!
  name: String
  parent: Content
  photos: Media
  price: Decimal
  productName: String
  sku: String
  sortOrder: Int!
  seoMetaDescription: String
  umbracoNavihide: Boolean
  updateDate: DateTime
  url: String
}
```

A Connection and an Edge type will also be generated, these are used when quering Content of a specific type.

```graphql
type ProductConnection {
  edges: [ProductEdge]
  pageInfo: PageInfo
}

type ProductEdge {
  cursor: String!
  node: Product
}
```

## Fields

All properties on a Content Type is generated as a field on the GraphQL type. See the [Property Editors](../Property-Editors) page for which types the editors are returning.

If a property is marked as [Allow varying by culture](../../../../Getting-Started/Backoffice/Variants/), a `culture` argument is added to that field. The argument is optional and will fallback to the parent fields culture or the default culture if none is specified.

```graphql
type Product implements Content & NavigationBase {
  ...
  productName(culture: String): String
  ...
}
```

## Root Query

The `Query` type is the entry to the GraphQL API. By default it contains two fields, one to get a single Content item by `ID` or `url` and one to get all Content.


```graphql
type Query {
  # Get Content by its unique identifier or url. Either id or url must be specified but not both.
  content(
    # The unique identifier of the content.
    id: ID,
    # The url of the content.
    url: String,
    # The culture to fetch the content in. If empty the default culture will be used.
    culture: String
  ): Content
  # Get all Content.
  allContent(
    # Specifies the number of edges to return starting from `after` or the first entry if `after` is not specified.
    first: Int,
    # Only look at connected edges with cursors greater than the value of `after`.
    after: String,
    # Specifies the number of edges to return counting reversely from `before`, or the last entry if `before` is not specified.
    last: Int,
    # Only look at connected edges with cursors smaller than the value of `before`.
    before: String,
    # The culture to fetch the value in. If empty the default culture will be used.
    culture: String,
  ): ContentConnection!
}
```

For each Document Type that is not used as a Composition or marked as an Element Type, two fields will be generated on the `Query` type. One for getting a single Content item by either it's `ID` or `url` and a field for getting all Content of that specific type.

```graphql
type Query {
  ...
  allProduct(first: Int, after: String, last: Int, before: String, culture: String): ProductConnection!
  product(culture: String, id: ID, url: String): Product
  ...
}
```

## Reserved Type Names and Property Aliases

GraphQL requires that type names are unique. If a Content Type will collide with one of the reserved names the type will be excluded from generation.

The same applies to Properties. If a Property alias is a reserved one it will also be excluded from generation.

### Reserved Type Names

List of reserved type names, these cannot be used as an `alias` for Content Types.

:::note
The GraphQL type name is the Content Type `alias` converted to Pascal Case.
:::

* BigInt
* Byte
* Content
* Date
* DateTime
* DateTimeOffset
* Decimal
* DecimalRange
* Element
* Guid
* HTML
* ImageCropAnchor
* ImageCropFormat
* ImageCropMode
* ImageCropper
* ImageCropperCrop
* ImageCropperCropCoordinates
* ImageCropperFocalPoint
* ImageCropRatioMode
* JSON
* Link
* LinkType
* Long
* Media
* Milliseconds
* PageInfo
* PickedColor
* Query
* SByte
* Seconds
* Short
* UInt
* ULong
* Uri
* UShort

### Reserved Element Type Property Names

List of reserved Element Type Property names, these cannot be used as a Property `alias` on an Element Type.

* contentTypeAlias

### Reserved Content Type Property Names

List of reserved Content Type Property names, these cannot be used as a Property `alias` on a Content Type.

* ancestors
* children
* contentTypeAlias
* createDate
* descendants
* id
* level
* name
* parent
* sortOrder
* updateDate
* url

### Reserved Media Type Property Names

List of reserved Media Type Property names, these cannot be used as a Property `alias` on a Media Type.

* ancestors
* children
* createDate
* descendants
* id
* level
* mediaTypeAlias
* name
* parent
* sortOrder
* updateDate
* url

## Built-in Custom Types

The Umbraco Heartcore GraphQL schema contains some default types, below you can find a list of these types.

The [Property Editors](../Property-Editors/) page contains a list of all the Property Editors and which GraphQL types they return.

### Decimal Range

```graphql
# Represents a range of decimals.
type DecimalRange {
  # Maximum value of the range.
  maximum: Decimal!
  # Minimum value of the range.
  minimum: Decimal!
}
```

**Query**:

```graphql
{
  product {
    durability {
      minimum
      maximum
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "product": {
      "durability": {
        "minimum": 7,
        "maximum": 10
      }
    }
  }
}
```

### HTML

```graphql
# A string containing HTML code.
scalar HTML
```

**Query**:

```graphql
{
  product {
    description
  }
}
```

**Output**:

```json
{
  "data": {
    "product": {
      "description": "<p>A nice leather jacket.</p>"
    }
  }
}
```

### Image Cropper

```graphql
type ImageCropper {
  # The predefined crops.
  crops: [ImageCropperCrop]!
  # The image url with crop parameters.
  cropUrl(
    # The crop alias.
    alias: String
    # Change background color of the image.
    backgroundColor: String
    # The width of the output image.
    width: Int
    # The height of the output image.
    height: Int
    # Quality percentage of the output image.
    quality: Int
    # The image crop mode.
    cropMode: ImageCropMode
    # The image crop anchor.
    cropAnchor: ImageCropAnchor
    # Use a dimension as a ratio.
    ratioMode: ImageCropRatioMode
    # The format of the output image.
    format: ImageCropFormat
    # Use focal point to generate an output image using the focal point instead of the predefined crop if there is one.
    preferFocalPoint: Boolean = false
    # If the image should be upscaled to requested dimensions.
    upscale: Boolean = false
  ): String
  # The focal point position.
  focalPoint: ImageCropperFocalPoint!
  # The focal point url template.
  focalPointUrlTemplate: String!
  # The image url.
  url: String!
}
```

**Query**:

```graphql
{
  product {
    photo {
      cropUrl(width: 1980, height: 430)
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "product": {
      "photo": {
        "cropUrl": "https://media.umbraco.io/demo-headless/8d76d2e84a24637/new-color-umbraco-stickers-1.jpg?anchor=center&mode=crop&width=1980&height=430&upscale=false"
      }
    }
  }
}
```

### Image Crop Anchor

```graphql
enum ImageCropAnchor {
  # Anchors the position of the image to the bottom of it's bounding container.
  BOTTOM
  # Anchors the position of the image to the bottom left side of it's bounding container.
  BOTTOM_LEFT
  # Anchors the position of the image to the bottom right side of it's bounding container.
  BOTTOM_RIGHT
  # Anchors the position of the image to the center of it's bounding container.
  CENTER
  # Anchors the position of the image to the left of it's bounding container.
  LEFT
  # Anchors the position of the image to the right of it's bounding container.
  RIGHT
  # Anchors the position of the image to the top of it's bounding container.
  TOP
  # Anchors the position of the image to the top left side of it's bounding container.
  TOP_LEFT
  # Anchors the position of the image to the top right side of it's bounding container.
  TOP_RIGHT
}
```

**Query**:

```graphql
{
  product {
    photo {
      cropUrl(width:1980, height: 430, cropAnchor: TOP_LEFT)
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "product": {
      "photo": {
        "cropUrl": "https://media.umbraco.io/demo-headless/8d76d2e84a24637/new-color-umbraco-stickers-1.jpg?anchor=topleft&mode=crop&width=1980&height=430&upscale=false"
      }
    }
  }
}
```

### Image Crop Format

```graphql
enum ImageCropFormat {
  PNG
  JPG
  GIF
  WEBP
}
```

**Query**:

```graphql
{
  product {
    photo {
      cropUrl(width:1980, height: 430, format: WEBP)
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "product": {
      "photo": {
        "cropUrl": "https://media.umbraco.io/demo-headless/8d76d2e84a24637/new-color-umbraco-stickers-1.jpg?anchor=center&mode=crop&width=1980&height=430&upscale=false&format=webp"
      }
    }
  }
}
```

### Image Crop Mode

```graphql
enum ImageCropMode {
  # When upscaling an image the image pixels themselves are not resized, rather the image is padded to fit the given dimensions.
  BOX_PAD
  # Resizes the image to the given dimensions. If the set dimensions do not match the aspect ratio of the original image then the output is cropped to match the new aspect ratio.
  CROP
  # Resizes the image to the given dimensions. If the set dimensions do not match the aspect ratio of the original image then the output is resized to the maximum possible value in each direction while maintaining the original aspect ratio.
  MAX
  # Resizes the image until the shortest side reaches the set given dimension. This will maintain the aspect ratio of the original image. Upscaling is disabled in this mode and the original image will be returned if attempted.
  MIN
  # Passing a single dimension will automatically preserve the aspect ratio of the original image. If the requested aspect ratio is different then the image will be padded to fit.
  PAD
  # Resizes the image to the given dimensions. If the set dimensions do not match the aspect ratio of the original image then the output is stretched to match the new aspect ratio.
  STRETCH
}
```

**Query**:

```graphql
{
  product {
    photo {
      cropUrl(width:1980, height: 430, cropMode: PAD)
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "product": {
      "photo": {
        "cropUrl": "https://media.umbraco.io/demo-headless/8d76d2e84a24637/new-color-umbraco-stickers-1.jpg?anchor=center&mode=pad&width=1980&height=430&upscale=false"
      }
    }
  }
}
```

### Image Crop Ratio Mode

```graphql
enum ImageCropRatioMode {
  # Calculate the image ratio based on the height.
  HEIGHT
  # Calculate the image ratio based on the width.
  WIDTH
}
```

**Query**:

```graphql
{
  product {
    photo {
      cropUrl(width:1980, height: 430, ratioMode: WIDTH)
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "product": {
      "photo": {
        "cropUrl": "https://media.umbraco.io/demo-headless/8d76d2e84a24637/new-color-umbraco-stickers-1.jpg?anchor=center&mode=crop&height=430&widthratio=4.6046511627906976744186046512&upscale=false"
      }
    }
  }
}
```


### Image Cropper Crop

```graphql
type ImageCropperCrop {
  # The crop alias.
  alias: String!
  # The crop coordinates.
  coordinates: ImageCropperCropCoordinates
  # The crop height.
  height: Int!
  # The crop width.
  width: Int!
}
```

**Query**:

```graphql
{
  product {
    photo {
      crops {
        alias
        height
        width
      }
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "product": {
      "photo": {
        "crops": {
          "alias": "Hero",
          "height": 600,
          "width": 1580
        }
      }
    }
  }
}
```

### Image Cropper Crop Coordinates

```graphql
type ImageCropperCropCoordinates {
  x1: Decimal!
  x2: Decimal!
  y1: Decimal!
  y2: Decimal!
}
```

**Query**:

```graphql
{
  product {
    photo {
      crops {
        coordinates {
          x1
          x2
          y1
          y2
        }
      }
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "product": {
      "photo": {
        "crops": {
          "coordinates": {
            "x1": 0.08901424149934925,
            "x2": 0.055992598445931165,
            "y1": 0.3183501211863771,
            "y2": 0.4660414375419126
          }
        }
      }
    }
  }
}
```

### Image Cropper Focal Point

```graphql
type ImageCropperFocalPoint {
  # The left position.
  left: Decimal!
  # The top position.
  top: Decimal!
}
```

**Query**:

```graphql
{
  product {
    photo {
      focalPoint {
        left
        top
      }
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "product": {
      "photo": {
        "focalPoint": {
          "left": 0.5,
          "top": 0.5
        }
      }
    }
  }
}
```

### JSON

```graphql
# The `JSON` scalar type
 represents JSON values as specified by [ECMA-404](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf).
scalar JSON
```

**Query**:

```graphql
{
  product {
    data
  }
}
```

**Output**:

```json
{
  "data": {
    "product": {
      "data": {
        "size": "100x100x100 mm",
        "weight": "300 g"
      }
    }
  }
}
```

### Link

```graphql
type Link {
  # The name of the Link.
  name: String!
  # The link target.
  target: String
  # The link type.
  type: LintType!
  # The link udi if type is CONTENT or MEDIA.
  udi: String
  # The url.
  url: String!
}
```

**Query**:

```graphql
{
  product {
    link {
      name
      target
      type
      udi
      url
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "product": {
      "link": {
        "name": "Umbraco",
        "target": "_blank",
        "type": "EXTERNAL",
        "udi": null,
        "url": "https://umbraco.com/"
      }
    }
  }
}
```

### Link Type

```graphql
enum LintType {
  # The link is a Content link.
  CONTENT
  # The link is an external link.
  EXTERNAL
  # The link is a media link.
  MEDIA
}
```

**Query**:

```graphql
{
  product {
    link {
      type
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "product": {
      "link": {
        "type": "CONTENT"
      }
    }
  }
}
```

### Page Info

```graphql
# Information about pagination in a connection.
type PageInfo {
  # When paginating forwards, the cursor to continue.
  endCursor: String
  # When paginating forwards, are there more items?
  hasNextPage: Boolean!
  # When paginating backwards, are there more items?
  hasPreviousPage: Boolean!
  # When paginating backwards, the cursor to continue.
  startCursor: String
}
```

**Query**:

```graphql
{
  allProduct(first: 2) {
    pageInfo {
      endCursor
      hasNextPage
      hasPreviousPage
      startCursor
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "allProduct": {
      "pageInfo": {
        "endCursor": "eyJ0cmVlUGF0aCI6WzYsMV19",
        "hasNextPage": true,
        "hasPreviousPage": false,
        "startCursor": "eyJ0cmVlUGF0aCI6WzYsMF19"
      }}
    }
  }
}
```

### Picked Color

```graphql
type PickedColor {
  # The color.
  color: String!
  # The label.
  label: String!
}
```

**Query**:

```graphql
{
  product {
    color
  }
}
```

**Output**:

```json
{
  "data": {
    "product": {
      "color": {
        "color": "ff0000",
        "label": "Red"
      }
    }
  }
}
```

### Element

```graphql
interface Element {
  #  The Content Type alias.
  contentTypeAlias: String!
}
```

**Query**:

```graphql
{
  product {
    features {
      contentTypeAlias
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "product": {
      "features": {
        "contentTypeAlias": "feature"
      }
    }
  }
}
```

### Content

```graphql
interface Content {
  #  The ancestors.
  ancestors(
    #  Specifies the number of edges to return starting from `after` or the first entry if `after` is not specified.
    first: Int
    #  Only look at connected edges with cursors greater than the value of `after`.
    after: String
    #  Specifies the number of edges to return counting reversely from `before`, or the last entry if `before` is not specified.
    last: Int
    #  Only look at connected edges with cursors smaller than the value of `before`.
    before: String
    #  The culture to fetch the value in. If empty the contents culture will be used.
    culture: String
  ): ContentConnection!
  #  The children.
  children(
    #  Specifies the number of edges to return starting from `after` or the first entry if `after` is not specified.
    first: Int
    #  Only look at connected edges with cursors greater than the value of `after`.
    after: String
    #  Specifies the number of edges to return counting reversely from `before`, or the last entry if `before` is not specified.
    last: Int
    #  Only look at connected edges with cursors smaller than the value of `before`.
    before: String
    #  The culture to fetch the value in. If empty the contents culture will be used.
    culture: String
  ): ContentConnection!
  #  The Content Type alias.
  contentTypeAlias: String!
  #  The create date.
  createDate: DateTime!
  #  The descendants.
  descendants(
    #  Specifies the number of edges to return starting from `after` or the first entry if `after` is not specified.
    first: Int
    #  Only look at connected edges with cursors greater than the value of `after`.
    after: String
    #  Specifies the number of edges to return counting reversely from `before`, or the last entry if `before` is not specified.
    last: Int
    #  Only look at connected edges with cursors smaller than the value of `before`.
    before: String
    #  The culture to fetch the value in. If empty the contents culture will be used.
    culture: String
  ): ContentConnection!
  #  The unique identifier.
  id: ID!
  #  The level.
  level: Int!
  #  The name.
  name(
    #  The culture to fetch the value in. If empty the contents culture will be used.
    culture: String
  ): String
  #  The parent Content, can be null if content is at root.
  parent(
    #  The culture to fetch the value in. If empty the contents culture will be used.
    culture: String
  ): Content
  #  The sort order.
  sortOrder: Int!
  #  The update date.
  updateDate(
    #  The culture to fetch the value in. If empty the contents culture will be used.
    culture: String
  ): DateTime
  #  The url.
  url(
    #  The culture to fetch the value in. If empty the contents culture will be used.
    culture: String
  ): String
}
```

### Content Connection

```graphql
#  A connection from an object to a list of objects of type `Content`.
type ContentConnection {
  #  A list of edges.
  edges: [ContentEdge]!
  # A list of all of the objects returned in the connection.
  # This is a convenience field provided for quickly exploring the API;
  # rather than querying for \"{ edges { node } }\" when no edge data is needed, this field can be used instead.
  # Note that when clients like Relay need to fetch the \"cursor\" field on the edge to enable efficient pagination,
  # this shortcut cannot be used, "and the full \"{ edges { node } } \" version should be used instead.
  items: [Content]!
  #  Information to aid in pagination.
  pageInfo: PageInfo!
}
```

### Content Edge

```graphql
#  An edge in a connection from an object to another object of type `Content`
type ContentEdge {
  #  A cursor for use in pagination.
  cursor: String!
  #  The item at the end of the edge.
  node: Content
}
```

### Media

```graphql
interface Media {
  #  The ancestors.
  ancestors(
    #  Specifies the number of edges to return starting from `after` or the first entry if `after` is not specified.
    first: Int
    #  Only look at connected edges with cursors greater than the value of `after`.
    after: String
    #  Specifies the number of edges to return counting reversely from `before`, or the last entry if `before` is not specified.
    last: Int
    #  Only look at connected edges with cursors smaller than the value of `before`.
    before: String
  ): MediaConnection!
  #  The children.
  children(
    #  Specifies the number of edges to return starting from `after` or the first entry if `after` is not specified.
    first: Int
    #  Only look at connected edges with cursors greater than the value of `after`.
    after: String
    #  Specifies the number of edges to return counting reversely from `before`, or the last entry if `before` is not specified.
    last: Int
    #  Only look at connected edges with cursors smaller than the value of `before`.
    before: String
  ): MediaConnection!
  #  The create date.
  createDate: DateTime!
  #  The descendants.
  descendants(
    #  Specifies the number of edges to return starting from `after` or the first entry if `after` is not specified.
    first: Int
    #  Only look at connected edges with cursors greater than the value of `after`.
    after: String
    #  Specifies the number of edges to return counting reversely from `before`, or the last entry if `before` is not specified.
    last: Int
    #  Only look at connected edges with cursors smaller than the value of `before`.
    before: String
  ): MediaConnection!
  #  The unique identifier.
  id: ID!
  #  The level.
  level: Int!
  #  The Media Type alias
  mediaTypeAlias: String!
  #  The name.
  name: String!
  #  The parent Content, can be null if content is at root.
  parent: Media
  #  The sort order.
  sortOrder: Int!
  #  The update date.
  updateDate: DateTime
  #  The url.
  url(
    #  Change the background color of the image.
    backgroundColor: String
    #  The width of the output image.
    width: Int
    #  The height of the output image.
    height: Int
    #  Quality percentage of the output image.
    quality: Int
    #  The image crop mode.
    cropMode: ImageCropMode
    #  The image crop anchor.
    cropAnchor: ImageCropAnchor
    #  Use a dimension as a ratio.
    ratioMode: ImageCropRatioMode
    #  If the image should be upscaled to requested dimensions.
    upscale: Boolean = false
    #  Change the format of the output image.
    format: ImageCropFormat
  ): String
}
```

### Media Connection

```graphql
#  A connection from an object to a list of objects of type `Media`.
type MediaConnection {
  #  A list of edges.
  edges: [MediaEdge]!
  # A list of all of the objects returned in the connection.
  # This is a convenience field provided for quickly exploring the API;
  # rather than querying for \"{ edges { node } }\" when no edge data is needed, this field can be used instead.
  # Note that when clients like Relay need to fetch the \"cursor\" field on the edge to enable efficient pagination,
  # this shortcut cannot be used, "and the full \"{ edges { node } } \" version should be used instead.
  items: [Media]!
  #  Information to aid in pagination.
  pageInfo: PageInfo!
}
```

### Media Edge

```graphql
#  An edge in a connection from an object to another object of type `Media`
type MediaEdge {
  #  A cursor for use in pagination.
  cursor: String!
  #  The item at the end of the edge.
  node: Media
}
```
