---
description: Documentation for Umbraco Heartcore GraphQL schema generation
---

# Schema Generation

The GraphQL schema is generated from the Content Types upon creation, and it is generated when a Content Type or a Data Type is changed.

The type name is the Content Type's alias in Pascal Case, e.g. if a Content Type has an alias of `product` it's GraphQL type name would be `Product`.

## Table of Contents

* [Types](schema-generation.md#types)
* [Fields](schema-generation.md#fields)
* [Root Query](schema-generation.md#root-query)
* [Reserved Type Names and Property Aliases](schema-generation.md#reserved-type-names-and-property-aliases)
* [Built-in Custom Types](schema-generation.md#built-in-custom-types)
* [Filtering](schema-generation.md#filtering)
* [Ordering](schema-generation.md#ordering)

## Types

The types generated depends on how the Content Types are configured.

If a Content Type is inherited from or used as a [Composition](https://docs.umbraco.com/umbraco-cms/fundamentals/data/defining-content#creating-a-document-type) it will be generated as an interface

```graphql
interface NavigationBase {
  seoMetaDescription: String
  umbracoNavihide: Boolean
}
```

If the Document Type is marked as an Element Type it will implement the [Element](schema-generation.md#element) interface

```graphql
type Feature implements Element {
  contentTypeAlias: String!
  featureName: String
  featureDescription: String
}
```

All other Content Types will implement either the [Content](schema-generation.md#content) or the [Media](schema-generation.md#media) interface, they will also implement all their Composition interfaces.

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

All properties on a Content Type is generated as a field on the GraphQL type. See the [Property Editors](property-editors.md) page for which types the editors are returning.

If a property is marked as [Allow varying by culture](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/variants), a `culture` argument is added to that field. The argument is optional and will fallback to the parent fields culture or the default culture if none is specified.

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
  """
  Get Content by its unique identifier or url. Either id or url must be specified but not both.
  """
  content(
    """
    The unique identifier of the content.
    """
    id: ID,
    """
    The url of the content.
    """
    url: String,
    """
    The culture to fetch the content in. If empty the default culture will be used.
    """
    culture: String
    """
    Specifies if draft content should be returned. Requires the request to be authenticated.
    """
    preview: Boolean
  ): Content
  """
  Get all Content.
  """
  allContent(
    """
    Specifies the number of edges to return starting from `after` or the first entry if `after` is not specified.
    """
    first: Int,
    """
    Only look at connected edges with cursors greater than the value of `after`.
    """
    after: String,
    """
    Specifies the number of edges to return counting reversely from `before`, or the last entry if `before` is not specified.
    """
    last: Int,
    """
    Only look at connected edges with cursors smaller than the value of `before`.
    """
    before: String,
    """
    The culture to fetch the value in. If empty the default culture will be used.
    """
    culture: String,
    """
    Specifies if draft content should be returned. Requires the request to be authenticated.
    """
    preview: Boolean
    """
    Filter the returned data.
    """
    where: ContentFilterInput,
    """
    Sort the returned data.
    """
    orderBy: [ContentOrderByInput]
  ): ContentConnection!
}
```

For each Document Type that is not used as a Composition or marked as an Element Type, two fields will be generated on the `Query` type. One for getting a single Content item by either it's `ID` or `url` and a field for getting all Content of that specific type.

```graphql
type Query {
  ...
  allProduct(first: Int, after: String, last: Int, before: String, culture: String, preview: Boolean, where: ProductFilterInput, orderBy: [ProductOrderByInput]): ProductConnection!
  product(culture: String, id: ID, url: String, preview: Boolean): Product
  ...
}
```

## Reserved Type Names and Property Aliases

GraphQL requires that type names are unique. If a Content Type will collide with one of the reserved names the type will be excluded from generation.

The same applies to Properties. If a Property alias is a reserved one it will also be excluded from generation.

### Reserved Type Names

List of reserved type names, these cannot be used as an `alias` for Content Types.

{% hint style="info" %}
The GraphQL type name is the Content Type `alias` converted to Pascal Case.
{% endhint %}

* BigInt
* BlockGrid
* BlockGridArea
* BlockGridItem
* BlockListItem
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
* MediaConnection
* MediaEdge
* Milliseconds
* OurUmbracoGMaps
* OurUmbracoGMapsAddress
* OurUmbracoGMapsCoordinate
* OurUmbracoGMapsMapConfig
* OurUmbracoGMapsMapType
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
* content
* parentId
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

The [Property Editors](property-editors.md) page contains a list of all the Property Editors and which GraphQL types they return.

### Block List Item

```graphql
type BlockListItem {
    """
    The content.
    """
    content: Element!

    """
    The settings.
    """
    settings: Element
}
```

**Query**

```graphql
{
  textPage {
    elements {
      content {
        title
      }
      settings {
        showLargeImage
      }
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "textPage": {
      "elements": [{
        "content": {
          "title": "Why use Umbraco Heartcore?"
        },
        "settings" {
          "showLargeImage": true
        }
      }]
    }
  }
}
```

### Decimal Range

```graphql
# Represents a range of decimals.
type DecimalRange {
  """
  Maximum value of the range.
  """
  maximum: Decimal!
  """
  Minimum value of the range.
  """
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
"""
A string containing HTML code.
"""
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
  """
  The predefined crops.
  """
  crops: [ImageCropperCrop]!
  """
  The image url with crop parameters.
  """
  cropUrl(
    """
    The crop alias.
    """
    alias: String
    """
    Change background color of the image.
    """
    backgroundColor: String
    """
    The width of the output image.
    """
    width: Int
    """
    The height of the output image.
    """
    height: Int
    """
    Quality percentage of the output image.
    """
    quality: Int
    """
    The image crop mode.
    """
    cropMode: ImageCropMode
    """
    The image crop anchor.
    """
    cropAnchor: ImageCropAnchor
    """
    Use a dimension as a ratio.
    """
    ratioMode: ImageCropRatioMode
    """
    The format of the output image.
    """
    format: ImageCropFormat
    """
    Use focal point to generate an output image using the focal point instead of the predefined crop if there is one.
    """
    preferFocalPoint: Boolean = false
    """
    If the image should be upscaled to requested dimensions.
    """
    upscale: Boolean = false
  ): String
  """
  The focal point position.
  """
  focalPoint: ImageCropperFocalPoint!
  """
  The focal point url template.
   """
  focalPointUrlTemplate: String!
  """
  The image url.
  """
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
  """
  Anchors the position of the image to the bottom of it's bounding container.
  """
  BOTTOM
  """
  Anchors the position of the image to the bottom left side of it's bounding container.
  """
  BOTTOM_LEFT
  """
  Anchors the position of the image to the bottom right side of it's bounding container.
  """
  BOTTOM_RIGHT
  """
  Anchors the position of the image to the center of it's bounding container.
  """
  CENTER
  """
  Anchors the position of the image to the left of it's bounding container.
  """
  LEFT
  """
  Anchors the position of the image to the right of it's bounding container.
  """
  RIGHT
  """
  Anchors the position of the image to the top of it's bounding container.
  """
  TOP
  """
  Anchors the position of the image to the top left side of it's bounding container.
  """
  TOP_LEFT
  """
  Anchors the position of the image to the top right side of it's bounding container.
  """
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
  """
  When upscaling an image the image pixels themselves are not resized, rather the image is padded to fit the given dimensions.
  """
  BOX_PAD
  """
  Resizes the image to the given dimensions. If the set dimensions do not match the aspect ratio of the original image then the output is cropped to match the new aspect ratio.
  """
  CROP
  """
  Resizes the image to the given dimensions. If the set dimensions do not match the aspect ratio of the original image then the output is resized to the maximum possible value in each direction while maintaining the original aspect ratio.
  """
  MAX
  """
  Resizes the image until the shortest side reaches the set given dimension. This will maintain the aspect ratio of the original image. Upscaling is disabled in this mode and the original image will be returned if attempted.
  """
  MIN
  """
  Passing a single dimension will automatically preserve the aspect ratio of the original image. If the requested aspect ratio is different then the image will be padded to fit.
  """
  PAD
  """
  Resizes the image to the given dimensions. If the set dimensions do not match the aspect ratio of the original image then the output is stretched to match the new aspect ratio.
  """
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
  """
  Calculate the image ratio based on the height.
  """
  HEIGHT
  """
  Calculate the image ratio based on the width.
  """
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
  """
  The crop alias.
  """
  alias: String!
  """
  The crop coordinates.
  """
  coordinates: ImageCropperCropCoordinates
  """
  The crop height.
  """
  height: Int!
  """
  The crop width.
  """
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
  """
  The left position.
  """
  left: Decimal!
  """
  The top position.
  """
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
"""
The `JSON` scalar type represents JSON values as specified by [ECMA-404](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf).
"""
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
  """
  The name of the Link.
  """
  name: String!
  """
  The link target.
  """
  target: String
  """
  The link type.
  """
  type: LintType!
  """
  The link udi if type is CONTENT or MEDIA.
  """
  udi: String
  """
  The url.
  """
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
  """
  The link is a Content link.
  """
  CONTENT
  """
  The link is an external link.
  """
  EXTERNAL
  """
  The link is a media link.
  """
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

### Media With Crops

```graphql
type MediaWithCrops {
  """
  The predefined crops.
  """
  crops: [ImageCropperCrop]!
  """
  The image url with crop parameters.
  """
  cropUrl(
    """
    The crop alias.
    """
    alias: String
    """
    Change background color of the image.
    """
    backgroundColor: String
    """
    The width of the output image.
    """
    width: Int
    """
    The height of the output image.
    """
    height: Int
    """
    Quality percentage of the output image.
    """
    quality: Int
    """
    The image crop mode.
    """
    cropMode: ImageCropMode
    """
    The image crop anchor.
    """
    cropAnchor: ImageCropAnchor
    """
    Use a dimension as a ratio.
    """
    ratioMode: ImageCropRatioMode
    """
    The format of the output image.
    """
    format: ImageCropFormat
    """
    Use focal point to generate an output image using the focal point instead of the predefined crop if there is one.
    """
    preferFocalPoint: Boolean = false
    """
    If the image should be upscaled to requested dimensions.
    """
    upscale: Boolean = false
  ): String
  """
  The focal point position.
  """
  focalPoint: ImageCropperFocalPoint!
  """
  The focal point url template.
  """
  focalPointUrlTemplate: String!
  """
  The media
  """
  media: Media!
  """
  The image url.
  """
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

### Our Umbraco GMaps

```graphql
type OurUmbracoGMaps {
  address: OurUmbracoGMapsAddress
  mapconfig: OurUmbracoGMapsMapConfig
}
```

**Query**:

```graphql
{
  frontpage {
    location {
      address {
        coordinates {
          lat
          lng
        }
      }
      mapconfig {
        zoom
      }
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "frontpage": {
      "location": {
        "address": {
          "lat": 55.4063759,
          "lng": 10.3887197
        },
        "mapconfig": {
          "zoom": 19
        }
      }
    }
  }
}
```

### Our Umbraco GMaps Address

```graphql
type OurUmbracoGMapsAddress {
  coordinates: OurUmbracoGMapsCoordinate
}
```

**Query**:

```graphql
{
  frontpage {
    location {
      address {
        coordinates {
          lat
          lng
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
    "frontpage": {
      "location": {
        "address": {
          "lat": 55.4063759,
          "lng": 10.3887197
        }
      }
    }
  }
}
```

### Our Umbraco GMaps Config

```graphql
type OurUmbracoGMapsMapConfig {
  apikey: String
  zoom: Int
  centerCoordinates: OurUmbracoGMapsCoordinate
  maptype: OurUmbracoGMapsMapType
  mapstyle: JSON
}
```

**Query**:

```graphql
{
  frontpage {
    location {
      mapconfig {
        apikey
        zoom
        centerCoordinates {
          lat
          lng
        }
        maptype
      }
    }
  }
}
```

**Output**:

```json
{
  "data": {
    "frontpage": {
      "location": {
        "mapconfig": {
          "apikey": "my-api-key",
          "zoom": 19,
          "centerCoordinates": {
            "lat": 55.4063759,
            "lng": 10.3887197
          },
          "maptype": "satellite"
        }
      }
    }
  }
}
```

### Our Umbraco GMaps Coordinate

```graphql
type OurUmbracoGMapsCoordinate {
  coordinates: String
  lat: Decimal
  lng: Decimal
  isEmpty: Boolean
}
```

**Query**:

```graphql
{
  frontpage {
    location {
      address {
        coordinates {
          coordinates
          lat
          lng
          isEmpty
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
    "frontpage": {
      "location": {
        "address": {
          "coordinates": "55.4063759,10.3887197",
          "lat": 55.4063759,
          "lng": 10.3887197,
          "isEmpty": false
        }
      }
    }
  }
}
```

### Our Umbraco GMaps Map Type

```graphql
enum OurUmbracoGMapsMapType {
  roadmap
  satellite
  hybrid
  terrain
  styled_map
}
```

### Page Info

```graphql
"""
Information about pagination in a connection.
"""
type PageInfo {
  """
  When paginating forwards, the cursor to continue.
  """
  endCursor: String
  """
  When paginating forwards, are there more items?
  """
  hasNextPage: Boolean!
  """
  When paginating backwards, are there more items?
  """
  hasPreviousPage: Boolean!
  """
  When paginating backwards, the cursor to continue.
  """
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
  """
  The color.
  """
  color: String!
  """
  The label.
  """
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
  """
  The Content Type alias.
  """
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
    """
    The ancestors.
    """
    ancestors(
        """
        Specifies the number of edges to return starting from `after` or the first entry if `after` is not specified.
        """
        first: Int,
        """
        Only look at connected edges with cursors greater than the value of `after`.
        """
        after: String,
        """
        Specifies the number of edges to return counting reversely from `before`, or the last entry if `before` is not specified.
        """
        last: Int,
        """
        Only look at connected edges with cursors smaller than the value of `before`.
        """
        before: String
        """
        The culture to fetch the value in. If empty the contents culture will be used.
        """
        culture: String
        """
        Filter the returned data.
        """
        where: ContentFilterInput,
        """
        Sort the returned data.
        """
        orderBy: [ContentOrderByInput],
    ): ContentConnection!
    """
    The children.
    """
    children(
        """
        Specifies the number of edges to return starting from `after` or the first entry if `after` is not specified.
        """
        first: Int,
        """
        Only look at connected edges with cursors greater than the value of `after`.
        """
        after: String,
        """
        Specifies the number of edges to return counting reversely from `before`, or the last entry if `before` is not specified.
        """
        last: Int,
        """
        Only look at connected edges with cursors smaller than the value of `before`.
        """
        before: String
        """
        The culture to fetch the value in. If empty the contents culture will be used.
        """
        culture: String
        """
        Filter the returned data.
        """
        where: ContentFilterInput,
        """
        Sort the returned data.
        """
        orderBy: [ContentOrderByInput],
    ): ContentConnection!
    """
    The Content Type alias.
    """
    contentTypeAlias: String!
    """
    The create date.
    """
    createDate: DateTime!
    """
    The descendants.
    """
    descendants(
        """
        Specifies the number of edges to return starting from `after` or the first entry if `after` is not specified.
        """
        first: Int,
        """
        Only look at connected edges with cursors greater than the value of `after`.
        """
        after: String,
        """
        Specifies the number of edges to return counting reversely from `before`, or the last entry if `before` is not specified.
        """
        last: Int,
        """
        Only look at connected edges with cursors smaller than the value of `before`.
        """
        before: String
        """
        The culture to fetch the value in. If empty the contents culture will be used.
        """
        culture: String
        """
        Filter the returned data.
        """
        where: ContentFilterInput,
        """
        Sort the returned data.
        """
        orderBy: [ContentOrderByInput],
    ): ContentConnection!
    """
    The unique identifier.
    """
    id: ID!
    """
    The level.
    """
    level: Int!
    """
    The name.
    """
    name(
        """
        The culture to fetch the value in. If empty the contents culture will be used.
        """
        culture: String
    ): String
    """
    The parent Content, can be null if content is at root.
    """
    parent(
        """
        The culture to fetch the value in. If empty the contents culture will be used.
        """
        culture: String
    ): Content
    """
    The sort order.
    """
    sortOrder: Int!
    """
    The update date.
    """
    updateDate(
        """
        The culture to fetch the value in. If empty the contents culture will be used.
        """
        culture: String
    ): DateTime
    """
    The url.
    """
    url(
        """
        The culture to fetch the value in. If empty the contents culture will be used.
        """
        culture: String
    ): String
}
```

### Content Connection

```graphql
"""
A connection from an object to a list of objects of type `Content`.
"""
type ContentConnection {
  """
  A list of all of the objects returned in the connection.
  This is a convenience field provided for quickly exploring the API;
  rather than querying for \"{ edges { node } }\" when no edge data is needed, this field can be used instead.
  Note that when clients like Relay need to fetch the \"cursor\" field on the edge to enable efficient pagination,
  this shortcut cannot be used, "and the full \"{ edges { node } } \" version should be used instead.
  """
  items: [Content]!
  """
  A list of edges.
  """
  edges: [ContentEdge]!
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
}
```

### Content Edge

```graphql
"""
An edge in a connection from an object to another object of type `Content`
"""
type ContentEdge {
  """
  A cursor for use in pagination.
  """
  cursor: String!
  """
  The item at the end of the edge.
  """
  node: Content
}
```

### Media

```graphql
interface Media {
  """
  The ancestors.
  """
  ancestors(
      """
      Specifies the number of edges to return starting from `after` or the first entry if `after` is not specified.
      """
      first: Int,
      """
      Only look at connected edges with cursors greater than the value of `after`.
      """
      after: String,
      """
      Specifies the number of edges to return counting reversely from `before`, or the last entry if `before` is not specified.
      """
      last: Int,
      """
      Only look at connected edges with cursors smaller than the value of `before`.
      """
      before: String
  ): MediaConnection!
  """
  The children.
  """
  children(
    """
    Specifies the number of edges to return starting from `after` or the first entry if `after` is not specified.
    """
    first: Int,
    """
    Only look at connected edges with cursors greater than the value of `after`.
    """
    after: String,
    """
    Specifies the number of edges to return counting reversely from `before`, or the last entry if `before` is not specified.
    """
    last: Int,
    """
    Only look at connected edges with cursors smaller than the value of `before`.
    """
    before: String
  ): MediaConnection!
  """
  The create date.
  """
  createDate: DateTime!
  """
  The descendants.
  """
  descendants(
    """
    Specifies the number of edges to return starting from `after` or the first entry if `after` is not specified.
    """
    first: Int,
    """
    Only look at connected edges with cursors greater than the value of `after`.
    """
    after: String,
    """
    Specifies the number of edges to return counting reversely from `before`, or the last entry if `before` is not specified.
    """
    last: Int,
    """
    Only look at connected edges with cursors smaller than the value of `before`.
    """
    before: String
  ): MediaConnection!
  """
  The unique identifier.
  """
  id: ID!
  """
  The level.
  """
  level: Int!
  """
  The Media Type alias
  """
  mediaTypeAlias: String!
  """
  The name.
  """
  name: String!
  """
  The parent Content, can be null if content is at root.
  """
  parent: Media
  """
  The sort order.
  """
  sortOrder: Int!
  """
  The update date.
  """
  updateDate: DateTime
  """
  The url.
  """
  url(
    """
    Change the background color of the image.
    """
    backgroundColor: String,
    """
    The width of the output image.
    """
    width: Int,
    """
    The height of the output image.
    """
    height: Int,
    """
    Quality percentage of the output image.
    """
    quality: Int,
    """
    The image crop mode.
    """
    cropMode: ImageCropMode,
    """
    The image crop anchor.
    """
    cropAnchor: ImageCropAnchor,
    """
    Use a dimension as a ratio.
    """
    ratioMode: ImageCropRatioMode,
    """
    If the image should be upscaled to requested dimensions.
    """
    upscale: Boolean = false,
    """
    Change the format of the output image.
    """
    format: ImageCropFormat
  ): String
}
```

### Media Connection

```graphql
"""
A connection from an object to a list of objects of type `Media`.
"""
type MediaConnection {
  """
  A list of all of the objects returned in the connection.
  This is a convenience field provided for quickly exploring the API;
  rather than querying for \"{ edges { node } }\" when no edge data is needed, this field can be used instead.
  Note that when clients like Relay need to fetch the \"cursor\" field on the edge to enable efficient pagination,
  this shortcut cannot be used, "and the full \"{ edges { node } } \" version should be used instead.
  """
  items: [Media]!
  """
  A list of edges.
  """
  edges: [MediaEdge]!
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
}
```

### Media Edge

```graphql
"""
An edge in a connection from an object to another object of type `Media`
"""
type MediaEdge {
  """
  A cursor for use in pagination.
  """
  cursor: String!
  """
  The item at the end of the edge.
  """
  node: Media
}
```

## Filtering

For all Document Types a `FilterInput` type is generated. The name is the type name postfixed by `FilterInput` e.g. given a type named `Product` the name will be `ProductFilterInput`.

### Default Filter Fields

To filter the `allContent` field, `ancestors`, `children` and `descendants` connections the `ContentFilterInput` is used.

{% hint style="info" %}
All filter inputs for Content Types will also have the default fields.
{% endhint %}

```graphql
"""
A filter input for the type `Content`.
"""
input ContentFilterInput {
  """
  All of the filters must match.
  """
  AND: [ContentFilterInput]
  """
  Some of the filters must match.
  """
  OR: [ContentFilterInput]
  """
  None of the filters must match.
  """
  NOT: [ContentFilterInput]
  """
  Field must equal value.
  """
  contentTypeAlias: String
  """
  Field must match any of the values.
  """
  contentTypeAlias_any: [String]
  """
  Field must start with the value.
  """
  contentTypeAlias_starts_with: String
  """
  Field must end with the value.
  """
  contentTypeAlias_ends_with: String
  """
  Field must contain the value.
  """
  contentTypeAlias_contains: String
  """
  Field must equal value.
  """
  createDate: DateTime
  """
  Field must be greater than the value.
  """
  createDate_gt: DateTime
  """
  Field must be greater than or equal the value.
  """
  createDate_gte: DateTime
  """
  Field must be less than the value.
  """
  createDate_lt: DateTime
  """
  Field must be less than or equal the value.
  """
  createDate_lte: DateTime
  """
  Field must equal value.
  """
  id: ID
  """
  Field must match any of the values.
  """
  id_any: [ID]
  """
  Field must equal value.
  """
  level: Int
  """
  Field must be greater than the value.
  """
  level_gt: Int
  """
  Field must be greater than or equal the value.
  """
  level_gte: Int
  """
  Field must be less than the value.
  """
  level_lt: Int
  """
  Field must be less than or equal the value.
  """
  level_lte: Int
  """
  Field must match any of the values.
  """
  level_any: [Int]
  """
  Field must equal value.
  """
  name: String
  """
  Field must match any of the values.
  """
  name_any: [String]
  """
  Field must start with the value.
  """
  name_starts_with: String
  """
  Field must end with the value.
  """
  name_ends_with: String
  """
  Field must contain the value.
  """
  name_contains: String
  """
  Field must equal value.
  """
  sortOrder: Int
  """
  Field must be greater than the value.
  """
  sortOrder_gt: Int
  """
  Field must be greater than or equal the value.
  """
  sortOrder_gte: Int
  """
  Field must be less than the value.
  """
  sortOrder_lt: Int
  """
  Field must be less than or equal the value.
  """
  sortOrder_lte: Int
  """
  Field must match any of the values.
  """
  sortOrder_any: [Int]
  """
  Field must equal value.
  """
  updateDate: DateTime
  """
  Field must be greater than the value.
  """
  updateDate_gt: DateTime
  """
  Field must be greater than or equal the value.
  """
  updateDate_gte: DateTime
  """
  Field must be less than the value.
  """
  updateDate_lt: DateTime
  """
  Field must be less than or equal the value.
  """
  updateDate_lte: DateTime
}
```

{% hint style="info" %}
Filtering is possible only on non-complex Property Editors like Text Area and Label. Filtering on more complex types like Content Picker and Multi-node Tree Picker has to be done client-side.
{% endhint %}

### Strings

For fields returning `String` the following filter fields are generated.

Given the following type:

```graphql
Product implements Content {
...
  sku: String
...
}
```

The following type will be generated, incl. the fields from the `ContentFilterInput`.

```graphql
"""
A filter input for the type `Product`.
"""
input ProductFilterInput {
  """
  All of the filters must match.
  """
  AND: [ProductFilterInput]
  """
  Some of the filters must match.
  """
  OR: [ProductFilterInput]
  """
  None of the filters must match.
  """
  NOT: [ProductFilterInput]
...
  """
  Field must equal value.
  """
  sku: String
  """
  Field must match any of the values.
  """
  sku_any: [String]
  """
  Field must start with the value.
  """
  sku_starts_with: String
  """
  Field must end with the value.
  """
  sku_ends_with: String
  """
  Field must contain the value.
  """
  sku_contains: String
...
}
```

### Ints

For fields returning `Int` or `Decimal` the following filters are generated.

{% hint style="info" %}
The type is either `Int` or `Decimal` depending on the output type.
{% endhint %}

Given the following type:

```graphql
Product implements Content {
...
  price: Decimal
...
}
```

The following type will be generated, incl. the fields from the `ContentFilterInput`.

```graphql
"""
A filter input for the type `Product`.
"""
input ProductFilterInput {
  """
  All of the filters must match.
  """
  AND: [ProductFilterInput]
  """
  Some of the filters must match.
  """
  OR: [ProductFilterInput]
  """
  None of the filters must match.
  """
  NOT: [ProductFilterInput]
...
  """
  Field must equal value.
  """
  price: Decimal
  """
  Field must be greater than the value.
  """
  price_gt: Decimal
  """
  Field must be greater than or equal to the value.
  """
  price_gte: Decimal
  """
  Field must be less than the value.
  """
  price_lt: Decimal
  """
  Field must be less than or equal to the value.
  """
  price_lte: Decimal
  """
  Field must match any of the values.
  """
  price_any: [Decimal]
...
}
```

### Boolean

For types returning `Boolean` the following filters are generated.

Given the following type:

```graphql
Product implements Content {
...
  purchase: Boolean
...
}
```

The following type will be generated, incl. the fields from the `ContentFilterInput`.

```graphql
"""
A filter input for the type `Product`.
"""
input ProductFilterInput {
  """
  All of the filters must match.
  """
  AND: [ProductFilterInput]
  """
  Some of the filters must match.
  """
  OR: [ProductFilterInput]
  """
  None of the filters must match.
  """
  NOT: [ProductFilterInput]
....
  # Field must equal value.
  purchase: Boolean
...
}
```

### Content

For types returning `Content` the [ContentFilterInput](schema-generation.md#default\_filter\_fields) is used.

### Dates

For types returning `DateTime` the following filters are generated.

Given the following type:

```graphql
Product implements Content {
  availableDate: DateTime
...
}
```

The following type will be generated, incl. the fields from the `ContentFilterInput`.

```graphql
"""
A filter input for the type `Product`.
"""
input ProductFilterInput {
  """
  All of the filters must match.
  """
  AND: [ProductFilterInput]
  """
  Some of the filters must match.
  """
  OR: [ProductFilterInput]
  """
  None of the filters must match.
  """
  NOT: [ProductFilterInput]
...
  """
  Field must equal value.
  """
  availableDate: DateTime
  """
  Field must be greater than the value.
  """
  availableDate_gt: DateTime
  """
  Field must be greater than or equal to the value.
  """
  availableDate_gte: DateTime
  """
  Field must be less than the value.
  """
  availableDate_lt: DateTime
  """
  Field must be less than or equal to the value.
  """
  availableDate_lte: DateTime
...
}
```

### Media

For types returning `Media` the `MediaFilterInput` is used.

```graphql
"""
A filter input for the type `Media`.
"""
input MediaFilterInput {
  """
  All of the filters must match.
  """
  AND: [MediaFilterInput]
  """
  Some of the filters must match.
  """
  OR: [MediaFilterInput]
  """
  None of the filters must match.
  """
  NOT: [MediaFilterInput]
  """
  Field must equal value.
  """
  mediaTypeAlias: String
  """
  Field must match any of the values.
  """
  mediaTypeAlias_any: [String]
  """
  Field must start with the value.
  """
  mediaTypeAlias_starts_with: String
  """
  Field must end with the value.
  """
  mediaTypeAlias_ends_with: String
  """
  Field must contain the value.
  """
  mediaTypeAlias_contains: String
  """
  Field must equal value.
  """
  createDate: DateTime
  """
  Field must be greater than the value.
  """
  createDate_gt: DateTime
  """
  Field must be greater than or equal the value.
  """
  createDate_gte: DateTime
  """
  Field must be less than the value.
  """
  createDate_lt: DateTime
  """
  Field must be less than or equal the value.
  """
  createDate_lte: DateTime
  """
  Field must equal value.
  """
  id: ID
  """
  Field must match any of the values.
  """
  id_any: [ID]
  """
  Field must equal value.
  """
  level: Int
  """
  Field must be greater than the value.
  """
  level_gt: Int
  """
  Field must be greater than or equal the value.
  """
  level_gte: Int
  """
  Field must be less than the value.
  """
  level_lt: Int
  """
  Field must be less than or equal the value.
  """
  level_lte: Int
  """
  Field must match any of the values.
  """
  level_any: [Int]
  """
  Field must equal value.
  """
  name: String
  """
  Field must match any of the values.
  """
  name_any: [String]
  """
  Field must start with the value.
  """
  name_starts_with: String
  """
  Field must end with the value.
  """
  name_ends_with: String
  """
  Field must contain the value.
  """
  name_contains: String
  """
  Field must equal value.
  """
  sortOrder: Int
  """
  Field must be greater than the value.
  """
  sortOrder_gt: Int
  """
  Field must be greater than or equal the value.
  """
  sortOrder_gte: Int
  """
  Field must be less than the value.
  """
  sortOrder_lt: Int
  """
  Field must be less than or equal the value.
  """
  sortOrder_lte: Int
  """
  Field must match any of the values.
  """
  sortOrder_any: [Int]
  """
  Field must equal value.
  """
  updateDate: DateTime
  """
  Field must be greater than the value.
  """
  updateDate_gt: DateTime
  """
  Field must be greater than or equal the value.
  """
  updateDate_gte: DateTime
  """
  Field must be less than the value.
  """
  updateDate_lt: DateTime
  """
  Field must be less than or equal the value.
  """
  updateDate_lte: DateTime
}
```

### Lists

For types returning `[Decimal]`, `[Int]` or `[String]` the following filters are generated.

{% hint style="info" %}
The type is `[Decimal]`, `[Int]` or `[String]` depending on the output type
{% endhint %}

Given the following type:

```graphql
Product implements Content {
...
  tags: [String]
...
}
```

The following type will be generated, incl. the fields from the `ContentFilterInput`.

```graphql
# A filter input for the type `Product`.
input ProductFilterInput {
  """
  All of the filters must match.
  """
  AND: [ProductFilterInput]
  """
  Some of the filters must match.
  """
  OR: [ProductFilterInput]
  """
  None of the filters must match.
  """
  NOT: [ProductFilterInput]
...
  """
  Field must match all of the values.
  """
  tags_all: [String]
  """
  Field must match any of the values.
  """
  tags_some: [String]
...
}
```

## Ordering

The result can be ordered by specifying a value for the `orderBy` argument.

An `OrderBy` type is generated for all Document Types. The name is the type name postfixed by `OrderByInput` e.g. given a type named `Product` the name will be `ProductOrderByInput`.

Fields returning `DateTime`, `Decimal`, `Boolean`, `Int` or `String` can be used to order by.

### Default OrderBy Fields

To filter the `allContent` field, `ancestors`, `children` and `descendants` connections the `ContentOrderBy` is used.

{% hint style="info" %}
All order by inputs for Content Types will also have the default fields.
{% endhint %}

````graphql
``"""
An order input for the type `Content`.
"""
enum ContentOrderByInput {
  """
  Order by `contentTypeAlias` in ascending order.
  """
  contentTypeAlias_ASC
  """
  Order by `contentTypeAlias` in descending order.
  """
  contentTypeAlias_DESC
  """
  Order by `createDate` in ascending order.
  """
  createDate_ASC
  """
  Order by `createDate` in descending order.
  """
  createDate_DESC
  """
  Order by `level` in ascending order.
  """
  level_ASC
  """
  Order by `level` in descending order.
  """
  level_DESC
  """
  Order by `name` in ascending order.
  """
  name_ASC
  """
  Order by `name` in descending order.
  """
  name_DESC
  """
  Order by `path` in ascending order.
  """
  path_ASC
  """
  Order by `path` in descending order.
  """
  path_DESC
  """
  Order by `sortOrder` in ascending order.
  """
  sortOrder_ASC
  """
  Order by `sortOrder` in descending order.
  """
  sortOrder_DESC
  """
  Order by `updateDate` in ascending order.
  """
  updateDate_ASC
  """
  Order by `updateDate` in descending order.
  """
  updateDate_DESC
}`

### Custom OrderBy Fields

Given the following type:

```graphql
Product implements Content {
...
  price: Decimal
  sku: String
...
}
````

The following type will be generated, incl. the fields from the `ContentOrderByInput`.

```graphql
"""
An order by input for the type `Product`.
"""
enum ProductOrderByInput {
...
  """
  Order by `price` in ascending order.
  """
  price_ASC
  """
  Order by `price` in descending order.
  """
  price_DESC
  """
  Order by `sku` in ascending order.
  """
  sku_ASC
  # Order by `sku` in descending order.
  sku_DESC
...
}
```

### Default ordering

If you don't specify any order the data returned will be ordered by the path they appear in, in the Umbraco Backoffice tree.
