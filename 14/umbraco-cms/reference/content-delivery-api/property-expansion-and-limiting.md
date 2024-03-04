---
description: Using property expansion and limiting to shape the Delivery API output
---

# Property expansion and limiting

{% hint style="info" %}
This article explains the mechanics of property expansion and limiting in depth. If you haven't already, please read the [Getting started](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api) article first - in particular the "Concepts" section.
{% endhint %}

Property expansion and limiting applies only to select property editors. The following built-in property editors in Umbraco support expansion and limiting:

- Picker editors
  - Content Picker
  - Media Picker
  - Media Picker (legacy)
  - Multinode Treepicker
- Block-based editors
  - Block List
  - Block Grid
  - Rich Text Editor (with blocks)

{% hint style="info" %}
When working with property expansion and limiting in API queries, there are two rules of thumb to keep in mind:

1. Expandable properties are _not_ expanded by default. They must be expanded explicitly.
2. All properties are included in the API output by default. We can apply limiting to limit the included properties.
{% endhint %}

## Working with picker editors

In the following examples, we will be querying a content tree with blog posts and blog authors:

- All blog posts are located under a root content item called "Posts".
- All authors are located under a root content item called "Authors".

The blog post content type (`post`) contains two properties that support expansion and limiting:

- `author`: A content picker for picking the author of the post.
- `coverImage`: A media picker for picking an image for the post.

The author content type (`author`) contains a single property that supports expansion and limiting:

- `picture`: A media picker for picking a picture of the author.

When fetching a blog post, the `author` and `coverImage` properties are returned in their un-expanded representation by default. This representation does not contain any property data; the `properties` collections of `author` and `coverImage` are empty:

**Request**

```http
GET /umbraco/delivery/api/v2/content/item/set-your-content-free/
Start-Item: posts
```

**Response**

{% code title="Default Delivery API output" %}
```json
{
    "contentType": "post",
    "name": "Set your content free",
    "createDate": "2023-08-14T08:35:58.8397754",
    "updateDate": "2023-08-14T08:54:41.8018872",
    "route": {
        "path": "/set-your-content-free/",
        "startItem": {
            "id": "d88fefc3-da04-493d-9533-294a7264b27f",
            "path": "posts"
        }
    },
    "id": "5de65f2e-055e-4e6a-adc3-edb340dcd2e8",
    "properties": {
        "author": {
            "contentType": "author",
            "name": "Go Fish",
            "createDate": "2023-08-14T08:35:58.9245488",
            "updateDate": "2023-11-06T14:21:22.2160133",
            "route": {
                "path": "/go-fish/",
                "startItem": {
                    "id": "a0e500e2-295e-43e0-ab85-71a44e690c31",
                    "path": "authors"
                }
            },
            "id": "f5baeee9-fe8d-4e54-b5c8-fc0373df61cf",
            "properties": {}
        },
        "coverImage": [
            {
                "focalPoint": null,
                "crops": [],
                "id": "dbb62958-de31-465f-bdbe-5e9079b54b25",
                "name": "Arrows",
                "mediaType": "Image",
                "url": "/media/lyulnwzr/arrows.png",
                "extension": "png",
                "width": 1080,
                "height": 530,
                "bytes": 24069,
                "properties": {}
            }
        ],
        "excerpt": "Fusce ut mauris ornare, mollis felis ac, convallis neque. Aenean eu tortor ac dui dictum lacinia. Aliquam erat volutpat. Sed malesuada congue imperdiet. Sed dictum aliquam velit. Nunc non nibh dignissim, consequat quam ac, mattis turpis. ",
        "content": {
            "markup": "<p>Maecenas consectetur tellus ut aliquet gravida. Mauris at tortor et tellus ultrices tempor vitae nec sapien. Etiam in luctus justo. Praesent rutrum turpis nec maximus congue. Sed sed convallis dui, ut luctus magna. Cras eget diam et sem consequat dictum ut in diam.</p>\n<p>Donec feugiat, quam ut varius ultricies, erat purus luctus ex, at sagittis tellus ante vel orci. Nunc dapibus purus feugiat, rhoncus est non, feugiat metus. Vivamus vulputate mauris id urna ultrices sagittis non ut est. Mauris mauris diam, interdum nec lectus et, vehicula faucibus risus. Etiam varius sem erat, nec venenatis elit pellentesque sed. Interdum et malesuada fames ac ante ipsum primis in faucibus.</p>\n<p>Sed nibh arcu, feugiat eu arcu sed, posuere lacinia urna. Phasellus interdum euismod sagittis. Etiam vel erat sed erat posuere placerat. Sed pulvinar tincidunt suscipit.</p>\n<p>Curabitur molestie turpis elit, vitae bibendum mi convallis a. Etiam convallis, massa vitae sagittis consectetur, lacus odio condimentum felis, ac congue ligula odio eu tortor. Proin dignissim sit amet eros non lobortis. Sed blandit dolor id magna pulvinar auctor. Maecenas sed mi vel arcu pretium sodales in quis urna. Nunc lectus nunc, posuere efficitur dignissim congue, mollis at orci.</p>",
            "blocks": []
        },
        "tags": [
            "Content",
            "Awesome"
        ]
    },
    "cultures": {}
}
```
{% endcode %}

If we want to show the author's picture when rendering the blog post, we need to _expand_ the `author` property. By expanding the property, the author properties (including `picture`) are included in the output. We can achieve this by appending the `expand` parameter to our request.

The `expand` parameter syntax is as follows:

`expand=properties[propertyAlias1,propertyAlias2,propertyAlias3]`

Within the `properties` part of the `expand` parameter we can list the aliases of the properties we wish to expand. If we want to expand all expandable properties, we can use the operator `$all` instead:

`expand=properties[$all]`

**Request**

```http
GET /umbraco/delivery/api/v2/content/item/set-your-content-free/
    ?expand=properties[author]
Start-Item: posts
```

**Response**

{% code title="Delivery API output with property expansion" %}
```json
{
    "contentType": "post",
    "name": "Set your content free",
    "createDate": "2023-08-14T08:35:58.8397754",
    "updateDate": "2023-08-14T08:54:41.8018872",
    "route": {
        "path": "/set-your-content-free/",
        "startItem": {
            "id": "d88fefc3-da04-493d-9533-294a7264b27f",
            "path": "posts"
        }
    },
    "id": "5de65f2e-055e-4e6a-adc3-edb340dcd2e8",
    "properties": {
        "author": {
            "contentType": "author",
            "name": "Go Fish",
            "createDate": "2023-08-14T08:35:58.9245488",
            "updateDate": "2023-11-06T14:21:22.2160133",
            "route": {
                "path": "/go-fish/",
                "startItem": {
                    "id": "a0e500e2-295e-43e0-ab85-71a44e690c31",
                    "path": "authors"
                }
            },
            "id": "f5baeee9-fe8d-4e54-b5c8-fc0373df61cf",
            "properties": {
                "picture": [
                    {
                        "focalPoint": null,
                        "crops": [],
                        "id": "598c8ce5-1323-4926-98a4-0f3a395dae2d",
                        "name": "Fishtank",
                        "mediaType": "Image",
                        "url": "/media/2ogiywjd/fishtank.png",
                        "extension": "png",
                        "width": 1080,
                        "height": 1080,
                        "bytes": 26941,
                        "properties": {}
                    }
                ],
                "biography": "Cras fermentum enim vitae varius tristique. Suspendisse tempor quis lacus vitae facilisis. Ut eget mauris tempus dui pulvinar egestas vel eget nibh.\n\nDonec hendrerit sem eu diam sodales luctus non sed urna. Ut sapien ex, imperdiet non eleifend nec, venenatis et purus. Integer tincidunt cursus cursus.\n\nSuspendisse euismod sem nisi, aliquam dignissim sem dictum non. Ut et ex lacus. Fusce ac nisi mattis, ultrices nibh ac, facilisis leo. Aliquam faucibus, elit eu posuere scelerisque, mi enim accumsan lorem, quis rhoncus libero massa quis ligula.",
                "dateOfBirth": "1996-04-04T00:00:00Z"
            }
        },
        "coverImage": [
            {
                "focalPoint": null,
                "crops": [],
                "id": "dbb62958-de31-465f-bdbe-5e9079b54b25",
                "name": "Arrows",
                "mediaType": "Image",
                "url": "/media/lyulnwzr/arrows.png",
                "extension": "png",
                "width": 1080,
                "height": 530,
                "bytes": 24069,
                "properties": {}
            }
        ],
        "excerpt": "Fusce ut mauris ornare, mollis felis ac, convallis neque. Aenean eu tortor ac dui dictum lacinia. Aliquam erat volutpat. Sed malesuada congue imperdiet. Sed dictum aliquam velit. Nunc non nibh dignissim, consequat quam ac, mattis turpis. ",
        "content": {
            "markup": "<p>Maecenas consectetur tellus ut aliquet gravida. Mauris at tortor et tellus ultrices tempor vitae nec sapien. Etiam in luctus justo. Praesent rutrum turpis nec maximus congue. Sed sed convallis dui, ut luctus magna. Cras eget diam et sem consequat dictum ut in diam.</p>\n<p>Donec feugiat, quam ut varius ultricies, erat purus luctus ex, at sagittis tellus ante vel orci. Nunc dapibus purus feugiat, rhoncus est non, feugiat metus. Vivamus vulputate mauris id urna ultrices sagittis non ut est. Mauris mauris diam, interdum nec lectus et, vehicula faucibus risus. Etiam varius sem erat, nec venenatis elit pellentesque sed. Interdum et malesuada fames ac ante ipsum primis in faucibus.</p>\n<p>Sed nibh arcu, feugiat eu arcu sed, posuere lacinia urna. Phasellus interdum euismod sagittis. Etiam vel erat sed erat posuere placerat. Sed pulvinar tincidunt suscipit.</p>\n<p>Curabitur molestie turpis elit, vitae bibendum mi convallis a. Etiam convallis, massa vitae sagittis consectetur, lacus odio condimentum felis, ac congue ligula odio eu tortor. Proin dignissim sit amet eros non lobortis. Sed blandit dolor id magna pulvinar auctor. Maecenas sed mi vel arcu pretium sodales in quis urna. Nunc lectus nunc, posuere efficitur dignissim congue, mollis at orci.</p>\n<p>Aenean elit arcu, cursus sit amet vulputate eu, dignissim sit amet lorem. Nunc tempus rhoncus lorem, sit amet finibus mi scelerisque sollicitudin. Pellentesque auctor, nunc facilisis molestie ullamcorper, justo magna pellentesque dui, vel posuere est massa eget nibh. Sed dignissim eget purus vitae malesuada. Maecenas eu ultricies nunc. Sed porta pretium ligula, non auctor arcu blandit elementum. Nullam nibh metus, consequat non imperdiet et, scelerisque id urna. Vivamus mollis, dolor ac fringilla bibendum, leo turpis finibus libero, sit amet porttitor nunc magna non diam.</p>\n<p>Curabitur cursus ullamcorper mauris. Fusce porta turpis at metus fermentum, commodo rhoncus leo dignissim. Etiam eu eleifend elit, sit amet pulvinar nibh. In pharetra massa massa, sit amet convallis leo consectetur vitae. In id pharetra sapien, sit amet tincidunt enim.</p>\n<p>Duis velit lectus, mollis eu eros sed, dignissim scelerisque neque. Mauris blandit sit amet diam dignissim cursus.</p>\n<p>Integer ornare ultrices finibus. Nullam iaculis eget sapien in porttitor. Etiam sit amet viverra mauris. Vestibulum risus ligula, placerat eget tortor vel, mattis porta odio. Vestibulum non euismod lacus. Integer quis velit suscipit, commodo mi sed, rutrum metus. Donec auctor ex ut elit vehicula, quis tincidunt odio laoreet. Suspendisse pharetra sit amet ante quis consequat. Duis finibus pellentesque urna ac molestie.</p>",
            "blocks": []
        },
        "tags": [
            "Content",
            "Awesome"
        ]
    },
    "cultures": {}
}
```
{% endcode %}

Now we have the `picture` data in the `properties` collection of `author`. However, the rest of the author's properties (`biography` and `dateOfBirth`) are also present in our output, so we are slightly over-fetching. We will take care of that later.

First, we need to get the alt texts of our images (the blog post `coverImage` and the author `picture`). The alt text in this case is a text string property (`altText`) on the media type. Fetching the alt texts is possible because property expansion can be performed both across multiple properties and in a nested fashion.

For nested property expansion, the `expand` parameter syntax is as follows:

`expand=properties[propertyAlias[properties[nestedPropertyAlias1,nestedPropertyAlias2]]]`

Nested property expansion can also be combined with the `$all` operator:

`expand=properties[$all[properties[nestedPropertyAlias1,nestedPropertyAlias2]]]`

{% hint style="info" %}
There is no API limit to how "deep" the nesting can go. Eventually though, the total length of the request URL may become a hard limit to the size of the query.
{% endhint %}

Let's amend the `expand` parameter to accommodate expansion of the images:

**Request**

```http
GET /umbraco/delivery/api/v2/content/item/set-your-content-free/
    ?expand=properties[coverImage,author[properties[picture]]]
Start-Item: posts
```

**Response**

{% code title="Delivery API output with nested property expansion" %}
```json
{
    "contentType": "post",
    "name": "Set your content free",
    "createDate": "2023-08-14T08:35:58.8397754",
    "updateDate": "2023-08-14T08:54:41.8018872",
    "route": {
        "path": "/set-your-content-free/",
        "startItem": {
            "id": "d88fefc3-da04-493d-9533-294a7264b27f",
            "path": "posts"
        }
    },
    "id": "5de65f2e-055e-4e6a-adc3-edb340dcd2e8",
    "properties": {
        "author": {
            "contentType": "author",
            "name": "Go Fish",
            "createDate": "2023-08-14T08:35:58.9245488",
            "updateDate": "2023-11-06T14:21:22.2160133",
            "route": {
                "path": "/go-fish/",
                "startItem": {
                    "id": "a0e500e2-295e-43e0-ab85-71a44e690c31",
                    "path": "authors"
                }
            },
            "id": "f5baeee9-fe8d-4e54-b5c8-fc0373df61cf",
            "properties": {
                "picture": [
                    {
                        "focalPoint": null,
                        "crops": [],
                        "id": "598c8ce5-1323-4926-98a4-0f3a395dae2d",
                        "name": "Fishtank",
                        "mediaType": "Image",
                        "url": "/media/2ogiywjd/fishtank.png",
                        "extension": "png",
                        "width": 1080,
                        "height": 1080,
                        "bytes": 26941,
                        "properties": {
                            "altText": "An image of the author Fishtank"
                        }
                    }
                ],
                "biography": "Cras fermentum enim vitae varius tristique. Suspendisse tempor quis lacus vitae facilisis. Ut eget mauris tempus dui pulvinar egestas vel eget nibh.\n\nDonec hendrerit sem eu diam sodales luctus non sed urna. Ut sapien ex, imperdiet non eleifend nec, venenatis et purus. Integer tincidunt cursus cursus.\n\nSuspendisse euismod sem nisi, aliquam dignissim sem dictum non. Ut et ex lacus. Fusce ac nisi mattis, ultrices nibh ac, facilisis leo. Aliquam faucibus, elit eu posuere scelerisque, mi enim accumsan lorem, quis rhoncus libero massa quis ligula.",
                "dateOfBirth": "1996-04-04T00:00:00Z"
            }
        },
        "coverImage": [
            {
                "focalPoint": null,
                "crops": [],
                "id": "dbb62958-de31-465f-bdbe-5e9079b54b25",
                "name": "Arrows",
                "mediaType": "Image",
                "url": "/media/lyulnwzr/arrows.png",
                "extension": "png",
                "width": 1080,
                "height": 530,
                "bytes": 24069,
                "properties": {
                    "altText": "Some arrows pointing in different directions (but generally upwards)"
                }
            }
        ],
        "excerpt": "Fusce ut mauris ornare, mollis felis ac, convallis neque. Aenean eu tortor ac dui dictum lacinia. Aliquam erat volutpat. Sed malesuada congue imperdiet. Sed dictum aliquam velit. Nunc non nibh dignissim, consequat quam ac, mattis turpis. ",
        "content": {
            "markup": "<p>Maecenas consectetur tellus ut aliquet gravida. Mauris at tortor et tellus ultrices tempor vitae nec sapien. Etiam in luctus justo. Praesent rutrum turpis nec maximus congue. Sed sed convallis dui, ut luctus magna. Cras eget diam et sem consequat dictum ut in diam.</p>\n<p>Donec feugiat, quam ut varius ultricies, erat purus luctus ex, at sagittis tellus ante vel orci. Nunc dapibus purus feugiat, rhoncus est non, feugiat metus. Vivamus vulputate mauris id urna ultrices sagittis non ut est. Mauris mauris diam, interdum nec lectus et, vehicula faucibus risus. Etiam varius sem erat, nec venenatis elit pellentesque sed. Interdum et malesuada fames ac ante ipsum primis in faucibus.</p>\n<p>Sed nibh arcu, feugiat eu arcu sed, posuere lacinia urna. Phasellus interdum euismod sagittis. Etiam vel erat sed erat posuere placerat. Sed pulvinar tincidunt suscipit.</p>\n<p>Curabitur molestie turpis elit, vitae bibendum mi convallis a. Etiam convallis, massa vitae sagittis consectetur, lacus odio condimentum felis, ac congue ligula odio eu tortor. Proin dignissim sit amet eros non lobortis. Sed blandit dolor id magna pulvinar auctor. Maecenas sed mi vel arcu pretium sodales in quis urna. Nunc lectus nunc, posuere efficitur dignissim congue, mollis at orci.</p>\n<p>Aenean elit arcu, cursus sit amet vulputate eu, dignissim sit amet lorem. Nunc tempus rhoncus lorem, sit amet finibus mi scelerisque sollicitudin. Pellentesque auctor, nunc facilisis molestie ullamcorper, justo magna pellentesque dui, vel posuere est massa eget nibh. Sed dignissim eget purus vitae malesuada. Maecenas eu ultricies nunc. Sed porta pretium ligula, non auctor arcu blandit elementum. Nullam nibh metus, consequat non imperdiet et, scelerisque id urna. Vivamus mollis, dolor ac fringilla bibendum, leo turpis finibus libero, sit amet porttitor nunc magna non diam.</p>\n<p>Curabitur cursus ullamcorper mauris. Fusce porta turpis at metus fermentum, commodo rhoncus leo dignissim. Etiam eu eleifend elit, sit amet pulvinar nibh. In pharetra massa massa, sit amet convallis leo consectetur vitae. In id pharetra sapien, sit amet tincidunt enim.</p>\n<p>Duis velit lectus, mollis eu eros sed, dignissim scelerisque neque. Mauris blandit sit amet diam dignissim cursus.</p>\n<p>Integer ornare ultrices finibus. Nullam iaculis eget sapien in porttitor. Etiam sit amet viverra mauris. Vestibulum risus ligula, placerat eget tortor vel, mattis porta odio. Vestibulum non euismod lacus. Integer quis velit suscipit, commodo mi sed, rutrum metus. Donec auctor ex ut elit vehicula, quis tincidunt odio laoreet. Suspendisse pharetra sit amet ante quis consequat. Duis finibus pellentesque urna ac molestie.</p>",
            "blocks": []
        },
        "tags": [
            "Content",
            "Awesome"
        ]
    },
    "cultures": {}
}
```
{% endcode %}

As mentioned above we are slightly over-fetching. We don't need all the author data - we are only interested in the author's `picture`. To fix this we can apply property limiting by adding the `fields` parameter to our request.

The `fields` parameter allows us to limit the properties in the output to only those specified. The parameter uses the same syntax as the `expand` parameter.

Our ideal blog post output contains:

- All the properties of the blog post, including the `altText` of the post `coverImage`.
- Only the `picture` property of `author`, including the `altText` of the author `picture`.

As with property expansion, we can use the `$all` operator in the `fields` parameter. This will include everything at any given query level. We'll use this to include all the blog post properties in the output without having to specify each property explicitly:

**Request**

```http
GET /umbraco/delivery/api/v2/content/item/set-your-content-free/
    ?expand=properties[coverImage,author[properties[picture]]]
    &fields=properties[$all[properties[altText,picture[properties[altText]]]]]
Start-Item: posts
```

**Response**

{% code title="Delivery API output with property expansion and limiting" %}
```json
{
    "contentType": "post",
    "name": "Set your content free",
    "createDate": "2023-08-14T08:35:58.8397754",
    "updateDate": "2023-08-14T08:54:41.8018872",
    "route": {
        "path": "/set-your-content-free/",
        "startItem": {
            "id": "d88fefc3-da04-493d-9533-294a7264b27f",
            "path": "posts"
        }
    },
    "id": "5de65f2e-055e-4e6a-adc3-edb340dcd2e8",
    "properties": {
        "author": {
            "contentType": "author",
            "name": "Go Fish",
            "createDate": "2023-08-14T08:35:58.9245488",
            "updateDate": "2023-11-06T14:21:22.2160133",
            "route": {
                "path": "/go-fish/",
                "startItem": {
                    "id": "a0e500e2-295e-43e0-ab85-71a44e690c31",
                    "path": "authors"
                }
            },
            "id": "f5baeee9-fe8d-4e54-b5c8-fc0373df61cf",
            "properties": {
                "picture": [
                    {
                        "focalPoint": null,
                        "crops": [],
                        "id": "598c8ce5-1323-4926-98a4-0f3a395dae2d",
                        "name": "Fishtank",
                        "mediaType": "Image",
                        "url": "/media/2ogiywjd/fishtank.png",
                        "extension": "png",
                        "width": 1080,
                        "height": 1080,
                        "bytes": 26941,
                        "properties": {
                            "altText": "An image of the author Fishtank"
                        }
                    }
                ]
            }
        },
        "coverImage": [
            {
                "focalPoint": null,
                "crops": [],
                "id": "dbb62958-de31-465f-bdbe-5e9079b54b25",
                "name": "Arrows",
                "mediaType": "Image",
                "url": "/media/lyulnwzr/arrows.png",
                "extension": "png",
                "width": 1080,
                "height": 530,
                "bytes": 24069,
                "properties": {
                    "altText": "Some arrows pointing in different directions (but generally upwards)"
                }
            }
        ],
        "excerpt": "Fusce ut mauris ornare, mollis felis ac, convallis neque. Aenean eu tortor ac dui dictum lacinia. Aliquam erat volutpat. Sed malesuada congue imperdiet. Sed dictum aliquam velit. Nunc non nibh dignissim, consequat quam ac, mattis turpis. ",
        "content": {
            "markup": "<p>Maecenas consectetur tellus ut aliquet gravida. Mauris at tortor et tellus ultrices tempor vitae nec sapien. Etiam in luctus justo. Praesent rutrum turpis nec maximus congue. Sed sed convallis dui, ut luctus magna. Cras eget diam et sem consequat dictum ut in diam.</p>\n<p>Donec feugiat, quam ut varius ultricies, erat purus luctus ex, at sagittis tellus ante vel orci. Nunc dapibus purus feugiat, rhoncus est non, feugiat metus. Vivamus vulputate mauris id urna ultrices sagittis non ut est. Mauris mauris diam, interdum nec lectus et, vehicula faucibus risus. Etiam varius sem erat, nec venenatis elit pellentesque sed. Interdum et malesuada fames ac ante ipsum primis in faucibus.</p>\n<p>Sed nibh arcu, feugiat eu arcu sed, posuere lacinia urna. Phasellus interdum euismod sagittis. Etiam vel erat sed erat posuere placerat. Sed pulvinar tincidunt suscipit.</p>\n<p>Curabitur molestie turpis elit, vitae bibendum mi convallis a. Etiam convallis, massa vitae sagittis consectetur, lacus odio condimentum felis, ac congue ligula odio eu tortor. Proin dignissim sit amet eros non lobortis. Sed blandit dolor id magna pulvinar auctor. Maecenas sed mi vel arcu pretium sodales in quis urna. Nunc lectus nunc, posuere efficitur dignissim congue, mollis at orci.</p>\n<p>Aenean elit arcu, cursus sit amet vulputate eu, dignissim sit amet lorem. Nunc tempus rhoncus lorem, sit amet finibus mi scelerisque sollicitudin. Pellentesque auctor, nunc facilisis molestie ullamcorper, justo magna pellentesque dui, vel posuere est massa eget nibh. Sed dignissim eget purus vitae malesuada. Maecenas eu ultricies nunc. Sed porta pretium ligula, non auctor arcu blandit elementum. Nullam nibh metus, consequat non imperdiet et, scelerisque id urna. Vivamus mollis, dolor ac fringilla bibendum, leo turpis finibus libero, sit amet porttitor nunc magna non diam.</p>\n<p>Curabitur cursus ullamcorper mauris. Fusce porta turpis at metus fermentum, commodo rhoncus leo dignissim. Etiam eu eleifend elit, sit amet pulvinar nibh. In pharetra massa massa, sit amet convallis leo consectetur vitae. In id pharetra sapien, sit amet tincidunt enim.</p>\n<p>Duis velit lectus, mollis eu eros sed, dignissim scelerisque neque. Mauris blandit sit amet diam dignissim cursus.</p>\n<p>Integer ornare ultrices finibus. Nullam iaculis eget sapien in porttitor. Etiam sit amet viverra mauris. Vestibulum risus ligula, placerat eget tortor vel, mattis porta odio. Vestibulum non euismod lacus. Integer quis velit suscipit, commodo mi sed, rutrum metus. Donec auctor ex ut elit vehicula, quis tincidunt odio laoreet. Suspendisse pharetra sit amet ante quis consequat. Duis finibus pellentesque urna ac molestie.</p>",
            "blocks": []
        },
        "tags": [
            "Content",
            "Awesome"
        ]
    },
    "cultures": {}
}
```
{% endcode %}

Now the API output contains only the properties we need to render the blog post.

Property limiting is particularly useful when querying multiple items. For example, if we were building a condensed list of blog posts, we likely wouldn't need the author data nor the blog post content. By applying limiting to a filtered query, we can tailor the API output specifically to this scenario:

**Request**

```http
GET /umbraco/delivery/api/v2/content/
    ?filter=contentType:post
    &expand=properties[coverImage]
    &fields=properties[excerpt,tags,coverImage[properties[altText]]]
Start-Item: posts
```

**Response**

{% code title="Delivery API query output with property expansion and limiting" %}
```json
{
    "total": 6,
    "items": [
        {
            "contentType": "post",
            "name": "Set your content free",
            "createDate": "2023-08-14T08:35:58.8397754",
            "updateDate": "2023-08-14T08:54:41.8018872",
            "route": {
                "path": "/set-your-content-free/",
                "startItem": {
                    "id": "d88fefc3-da04-493d-9533-294a7264b27f",
                    "path": "posts"
                }
            },
            "id": "5de65f2e-055e-4e6a-adc3-edb340dcd2e8",
            "properties": {
                "coverImage": [
                    {
                        "focalPoint": null,
                        "crops": [],
                        "id": "dbb62958-de31-465f-bdbe-5e9079b54b25",
                        "name": "Arrows",
                        "mediaType": "Image",
                        "url": "/media/lyulnwzr/arrows.png",
                        "extension": "png",
                        "width": 1080,
                        "height": 530,
                        "bytes": 24069,
                        "properties": {
                            "altText": "Some arrows pointing in different directions (but generally upwards)"
                        }
                    }
                ],
                "excerpt": "Fusce ut mauris ornare, mollis felis ac, convallis neque. Aenean eu tortor ac dui dictum lacinia. Aliquam erat volutpat. Sed malesuada congue imperdiet. Sed dictum aliquam velit. Nunc non nibh dignissim, consequat quam ac, mattis turpis. ",
                "tags": [
                    "Content",
                    "Awesome"
                ]
            },
            "cultures": {}
        },
        {
            "contentType": "post",
            "name": "Building a community",
            "createDate": "2023-08-14T08:35:58.6755792",
            "updateDate": "2023-08-14T08:54:45.5526111",
            "route": {
                "path": "/building-a-community/",
                "startItem": {
                    "id": "d88fefc3-da04-493d-9533-294a7264b27f",
                    "path": "posts"
                }
            },
            "id": "6e1bc040-f382-402c-ac56-3328d5f424c7",
            "properties": {
                "coverImage": [
                    {
                        "focalPoint": null,
                        "crops": [],
                        "id": "9757a20c-3e98-49ef-8103-c7fa746856e7",
                        "name": "Community",
                        "mediaType": "Image",
                        "url": "/media/bkrfpf2y/community.png",
                        "extension": "png",
                        "width": 1080,
                        "height": 540,
                        "bytes": 25832,
                        "properties": {
                            "altText": "Two hands constructing a heart from coloured pieces"
                        }
                    }
                ],
                "excerpt": "Maecenas ipsum dui, lobortis non dui eleifend, dapibus bibendum dui. Pellentesque dolor felis, mollis nec diam eget, fermentum rutrum ipsum. Vestibulum condimentum urna id turpis tempus, id finibus sem facilisis. Nullam commodo felis quis ante posuere, dictum suscipit nisl suscipit.",
                "tags": [
                    "Community",
                    "Inspiration",
                    "Awesome"
                ]
            },
            "cultures": {}
        },
        ...
    ]
}
```
{% endcode %}

## Working with block-based editors

{% hint style="info" %}
If you are not familiar with block-based editors, please refer to [this article](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/block-editor) for the general concepts of these.
{% endhint %}

In the API output, a block has little value without its contained properties. Therefore, the content and settings properties of blocks are always included in the output. However, these properties are not expanded. As such, we can apply expansion and limiting to the contained properties.

In the following examples we'll request different types of articles, all of which are located under a root content item called "Articles":

- An article with a Block List property (`blockList`).
- An article with a Block Grid property (`blockGrid`).
- An article with a Rich Text Editor property (`richText`).

All these properties are configured with a "Featured Post" block which consists of:

- A content model (`featuredPost`) that contains:
  - `title`: A text string property.
  - `post`: A content picker property that allows for picking a blog post.
- A settings model (`featuredPostSettings`) that contains:
  - `backgroundColor`: An approved color property.
  - `showTags`: A toggle property.

The goal is once again to build a condensed list of blog posts. But this time we'll build the list from the "Featured Post" blocks within each block editor.

To build the list we need the block `title`, the `coverImage` and `excerpt` from the picked post, and the `backgroundColor` from the block settings. Thus, we need to:

- Expand the `post` property to retrieve the `altText` of the post `coverImage`.
- Limit both the block-level properties and the nested `post` properties, as to only output the properties relevant for building the condensed list.

{% hint style="info" %}
For comparison, the samples show both the default output and the output with expansion and limiting applied. Notice that:

- The `expand` and `fields` parameter syntax is the same for all editors, even though their rendered output is structurally different.
- The `expand` and `fields` parameters target both the content and settings parts of each block.
{% endhint %}

### Block List

Default output without expansion and limiting:

**Request**

```http
GET /umbraco/delivery/api/v2/content/item/article-with-block-list/
Start-Item: articles
```

**Response**

{% code title="Default Delivery API output" %}
```json
{
    "contentType": "articleWithBlockList",
    "name": "Article with Block List",
    "createDate": "2023-11-07T16:14:14.0913877",
    "updateDate": "2023-11-07T16:30:58.0572288",
    "route": {
        "path": "/article-with-block-list/",
        "startItem": {
            "id": "5c8823f6-6442-4d04-9c14-f3411bd41aa8",
            "path": "articles"
        }
    },
    "id": "c1d139df-c08d-4225-909f-f176d727dce6",
    "properties": {
        "blockList": {
            "items": [
                {
                    "content": {
                        "contentType": "featuredPost",
                        "id": "4d5931fb-ad3c-4759-9824-777a2f3c6a85",
                        "properties": {
                            "title": "Free your content with the Delivery API",
                            "post": {
                                "contentType": "post",
                                "name": "Set your content free",
                                "createDate": "2023-08-14T08:35:58.8397754",
                                "updateDate": "2023-08-14T08:54:41.8018872",
                                "route": {
                                    "path": "/set-your-content-free/",
                                    "startItem": {
                                        "id": "d88fefc3-da04-493d-9533-294a7264b27f",
                                        "path": "posts"
                                    }
                                },
                                "id": "5de65f2e-055e-4e6a-adc3-edb340dcd2e8",
                                "properties": {}
                            }
                        }
                    },
                    "settings": {
                        "contentType": "featuredPostSettings",
                        "id": "aff73d6b-cfd1-4471-92d8-68fc07fdb6fd",
                        "properties": {
                            "backgroundColor": "ce7e00",
                            "showTags": true
                        }
                    }
                },
                {
                    "content": {
                        "contentType": "featuredPost",
                        "id": "76dabfff-7e86-4404-9a89-1b8274ac4f8e",
                        "properties": {
                            "title": "Community is key",
                            "post": {
                                "contentType": "post",
                                "name": "Building a community",
                                "createDate": "2023-08-14T08:35:58.6755792",
                                "updateDate": "2023-08-14T08:54:45.5526111",
                                "route": {
                                    "path": "/building-a-community/",
                                    "startItem": {
                                        "id": "d88fefc3-da04-493d-9533-294a7264b27f",
                                        "path": "posts"
                                    }
                                },
                                "id": "6e1bc040-f382-402c-ac56-3328d5f424c7",
                                "properties": {}
                            }
                        }
                    },
                    "settings": {
                        "contentType": "featuredPostSettings",
                        "id": "175325ab-b4a0-489d-a196-c1cf32b41ca1",
                        "properties": {
                            "backgroundColor": "6fa8dc",
                            "showTags": false
                        }
                    }
                }
            ]
        }
    },
    "cultures": {}
}
```
{% endcode %}

Output with property expansion and limiting:

**Request**

```http
GET /umbraco/delivery/api/v2/content/item/article-with-block-list/
    ?expand=properties[blockList[properties[post[properties[coverImage]]]]]
    &fields=properties[blockList[properties[title,post[properties[excerpt,coverImage]],backgroundColor]]]
Start-Item: articles
```

**Response**

{% code title="Delivery API output with expansion and limiting" %}
```json
{
    "contentType": "articleWithBlockList",
    "name": "Article with Block List",
    "createDate": "2023-11-07T16:14:14.0913877",
    "updateDate": "2023-11-07T16:34:45.6079582",
    "route": {
        "path": "/article-with-block-list/",
        "startItem": {
            "id": "5c8823f6-6442-4d04-9c14-f3411bd41aa8",
            "path": "articles"
        }
    },
    "id": "c1d139df-c08d-4225-909f-f176d727dce6",
    "properties": {
        "blockList": {
            "items": [
                {
                    "content": {
                        "contentType": "featuredPost",
                        "id": "4d5931fb-ad3c-4759-9824-777a2f3c6a85",
                        "properties": {
                            "title": "Free your content with the Delivery API",
                            "post": {
                                "contentType": "post",
                                "name": "Set your content free",
                                "createDate": "2023-08-14T08:35:58.8397754",
                                "updateDate": "2023-08-14T08:54:41.8018872",
                                "route": {
                                    "path": "/set-your-content-free/",
                                    "startItem": {
                                        "id": "d88fefc3-da04-493d-9533-294a7264b27f",
                                        "path": "posts"
                                    }
                                },
                                "id": "5de65f2e-055e-4e6a-adc3-edb340dcd2e8",
                                "properties": {
                                    "coverImage": [
                                        {
                                            "focalPoint": null,
                                            "crops": [],
                                            "id": "dbb62958-de31-465f-bdbe-5e9079b54b25",
                                            "name": "Arrows",
                                            "mediaType": "Image",
                                            "url": "/media/lyulnwzr/arrows.png",
                                            "extension": "png",
                                            "width": 1080,
                                            "height": 530,
                                            "bytes": 24069,
                                            "properties": {
                                                "altText": "Some arrows pointing in different directions (but generally upwards)"
                                            }
                                        }
                                    ],
                                    "excerpt": "Fusce ut mauris ornare, mollis felis ac, convallis neque. Aenean eu tortor ac dui dictum lacinia. Aliquam erat volutpat. Sed malesuada congue imperdiet. Sed dictum aliquam velit. Nunc non nibh dignissim, consequat quam ac, mattis turpis. "
                                }
                            }
                        }
                    },
                    "settings": {
                        "contentType": "featuredPostSettings",
                        "id": "aff73d6b-cfd1-4471-92d8-68fc07fdb6fd",
                        "properties": {
                            "backgroundColor": "ce7e00"
                        }
                    }
                },
                {
                    "content": {
                        "contentType": "featuredPost",
                        "id": "76dabfff-7e86-4404-9a89-1b8274ac4f8e",
                        "properties": {
                            "title": "Community is key",
                            "post": {
                                "contentType": "post",
                                "name": "Building a community",
                                "createDate": "2023-08-14T08:35:58.6755792",
                                "updateDate": "2023-08-14T08:54:45.5526111",
                                "route": {
                                    "path": "/building-a-community/",
                                    "startItem": {
                                        "id": "d88fefc3-da04-493d-9533-294a7264b27f",
                                        "path": "posts"
                                    }
                                },
                                "id": "6e1bc040-f382-402c-ac56-3328d5f424c7",
                                "properties": {
                                    "coverImage": [
                                        {
                                            "focalPoint": null,
                                            "crops": [],
                                            "id": "9757a20c-3e98-49ef-8103-c7fa746856e7",
                                            "name": "Community",
                                            "mediaType": "Image",
                                            "url": "/media/bkrfpf2y/community.png",
                                            "extension": "png",
                                            "width": 1080,
                                            "height": 540,
                                            "bytes": 25832,
                                            "properties": {
                                                "altText": "Two hands constructing a heart from coloured pieces"
                                            }
                                        }
                                    ],
                                    "excerpt": "Maecenas ipsum dui, lobortis non dui eleifend, dapibus bibendum dui. Pellentesque dolor felis, mollis nec diam eget, fermentum rutrum ipsum. Vestibulum condimentum urna id turpis tempus, id finibus sem facilisis. Nullam commodo felis quis ante posuere, dictum suscipit nisl suscipit."
                                }
                            }
                        }
                    },
                    "settings": {
                        "contentType": "featuredPostSettings",
                        "id": "175325ab-b4a0-489d-a196-c1cf32b41ca1",
                        "properties": {
                            "backgroundColor": "6fa8dc"
                        }
                    }
                }
            ]
        }
    },
    "cultures": {}
}
```
{% endcode %}

### Block Grid

Default output without expansion and limiting:

**Request**

```http
GET /umbraco/delivery/api/v2/content/item/article-with-block-grid/
Start-Item: articles
```

**Response**

{% code title="Default Delivery API output" %}
```json
{
    "contentType": "articleWithBlockGrid",
    "name": "Article with Block Grid",
    "createDate": "2023-11-07T16:34:19.1629081",
    "updateDate": "2023-11-07T16:34:36.3701542",
    "route": {
        "path": "/article-with-block-grid/",
        "startItem": {
            "id": "5c8823f6-6442-4d04-9c14-f3411bd41aa8",
            "path": "articles"
        }
    },
    "id": "17ed80d1-79e0-43b9-9ad6-7dad6a78e220",
    "properties": {
        "blockGrid": {
            "gridColumns": 12,
            "items": [
                {
                    "rowSpan": 1,
                    "columnSpan": 12,
                    "areaGridColumns": 12,
                    "areas": [
                        {
                            "alias": "left",
                            "rowSpan": 1,
                            "columnSpan": 6,
                            "items": [
                                {
                                    "rowSpan": 1,
                                    "columnSpan": 6,
                                    "areaGridColumns": 12,
                                    "areas": [],
                                    "content": {
                                        "contentType": "featuredPost",
                                        "id": "8a509b3d-20f1-4b92-b74c-c74a309baec8",
                                        "properties": {
                                            "title": "Free your content with the Delivery API",
                                            "post": {
                                                "contentType": "post",
                                                "name": "Set your content free",
                                                "createDate": "2023-08-14T08:35:58.8397754",
                                                "updateDate": "2023-08-14T08:54:41.8018872",
                                                "route": {
                                                    "path": "/set-your-content-free/",
                                                    "startItem": {
                                                        "id": "d88fefc3-da04-493d-9533-294a7264b27f",
                                                        "path": "posts"
                                                    }
                                                },
                                                "id": "5de65f2e-055e-4e6a-adc3-edb340dcd2e8",
                                                "properties": {}
                                            }
                                        }
                                    },
                                    "settings": {
                                        "contentType": "featuredPostSettings",
                                        "id": "81e51973-5107-4e9d-a1aa-71752ea7a9f4",
                                        "properties": {
                                            "backgroundColor": "ce7e00",
                                            "showTags": true
                                        }
                                    }
                                }
                            ]
                        },
                        {
                            "alias": "right",
                            "rowSpan": 1,
                            "columnSpan": 6,
                            "items": [
                                {
                                    "rowSpan": 1,
                                    "columnSpan": 6,
                                    "areaGridColumns": 12,
                                    "areas": [],
                                    "content": {
                                        "contentType": "featuredPost",
                                        "id": "de53752f-f3f1-4d17-a0f3-14ea62456fba",
                                        "properties": {
                                            "title": "Community is key",
                                            "post": {
                                                "contentType": "post",
                                                "name": "Building a community",
                                                "createDate": "2023-08-14T08:35:58.6755792",
                                                "updateDate": "2023-08-14T08:54:45.5526111",
                                                "route": {
                                                    "path": "/building-a-community/",
                                                    "startItem": {
                                                        "id": "d88fefc3-da04-493d-9533-294a7264b27f",
                                                        "path": "posts"
                                                    }
                                                },
                                                "id": "6e1bc040-f382-402c-ac56-3328d5f424c7",
                                                "properties": {}
                                            }
                                        }
                                    },
                                    "settings": {
                                        "contentType": "featuredPostSettings",
                                        "id": "6471bae6-1341-4bbd-9e19-e61e8df4446d",
                                        "properties": {
                                            "backgroundColor": "6fa8dc",
                                            "showTags": false
                                        }
                                    }
                                }
                            ]
                        }
                    ],
                    "content": {
                        "contentType": "twoColumnLayout",
                        "id": "40d5cf9c-809c-41ed-8639-84d894c2e663",
                        "properties": {}
                    },
                    "settings": null
                }
            ]
        }
    },
    "cultures": {}
}
```
{% endcode %}

Output with property expansion and limiting:

**Request**

```http
GET /umbraco/delivery/api/v2/content/item/article-with-block-grid/
    ?expand=properties[blockGrid[properties[post[properties[coverImage]]]]]
    &fields=properties[blockGrid[properties[title,post[properties[excerpt,coverImage]],backgroundColor]]]
Start-Item: articles
```

**Response**

{% code title="Delivery API output with expansion and limiting" %}
```json
{
    "contentType": "articleWithBlockGrid",
    "name": "Article with Block Grid",
    "createDate": "2023-11-07T16:34:19.1629081",
    "updateDate": "2023-11-07T16:34:36.3701542",
    "route": {
        "path": "/article-with-block-grid/",
        "startItem": {
            "id": "5c8823f6-6442-4d04-9c14-f3411bd41aa8",
            "path": "articles"
        }
    },
    "id": "17ed80d1-79e0-43b9-9ad6-7dad6a78e220",
    "properties": {
        "blockGrid": {
            "gridColumns": 12,
            "items": [
                {
                    "rowSpan": 1,
                    "columnSpan": 12,
                    "areaGridColumns": 12,
                    "areas": [
                        {
                            "alias": "left",
                            "rowSpan": 1,
                            "columnSpan": 6,
                            "items": [
                                {
                                    "rowSpan": 1,
                                    "columnSpan": 6,
                                    "areaGridColumns": 12,
                                    "areas": [],
                                    "content": {
                                        "contentType": "featuredPost",
                                        "id": "8a509b3d-20f1-4b92-b74c-c74a309baec8",
                                        "properties": {
                                            "title": "Free your content with the Delivery API",
                                            "post": {
                                                "contentType": "post",
                                                "name": "Set your content free",
                                                "createDate": "2023-08-14T08:35:58.8397754",
                                                "updateDate": "2023-08-14T08:54:41.8018872",
                                                "route": {
                                                    "path": "/set-your-content-free/",
                                                    "startItem": {
                                                        "id": "d88fefc3-da04-493d-9533-294a7264b27f",
                                                        "path": "posts"
                                                    }
                                                },
                                                "id": "5de65f2e-055e-4e6a-adc3-edb340dcd2e8",
                                                "properties": {
                                                    "coverImage": [
                                                        {
                                                            "focalPoint": null,
                                                            "crops": [],
                                                            "id": "dbb62958-de31-465f-bdbe-5e9079b54b25",
                                                            "name": "Arrows",
                                                            "mediaType": "Image",
                                                            "url": "/media/lyulnwzr/arrows.png",
                                                            "extension": "png",
                                                            "width": 1080,
                                                            "height": 530,
                                                            "bytes": 24069,
                                                            "properties": {
                                                                "altText": "Some arrows pointing in different directions (but generally upwards)"
                                                            }
                                                        }
                                                    ],
                                                    "excerpt": "Fusce ut mauris ornare, mollis felis ac, convallis neque. Aenean eu tortor ac dui dictum lacinia. Aliquam erat volutpat. Sed malesuada congue imperdiet. Sed dictum aliquam velit. Nunc non nibh dignissim, consequat quam ac, mattis turpis. "
                                                }
                                            }
                                        }
                                    },
                                    "settings": {
                                        "contentType": "featuredPostSettings",
                                        "id": "81e51973-5107-4e9d-a1aa-71752ea7a9f4",
                                        "properties": {
                                            "backgroundColor": "ce7e00"
                                        }
                                    }
                                }
                            ]
                        },
                        {
                            "alias": "right",
                            "rowSpan": 1,
                            "columnSpan": 6,
                            "items": [
                                {
                                    "rowSpan": 1,
                                    "columnSpan": 6,
                                    "areaGridColumns": 12,
                                    "areas": [],
                                    "content": {
                                        "contentType": "featuredPost",
                                        "id": "de53752f-f3f1-4d17-a0f3-14ea62456fba",
                                        "properties": {
                                            "title": "Community is key",
                                            "post": {
                                                "contentType": "post",
                                                "name": "Building a community",
                                                "createDate": "2023-08-14T08:35:58.6755792",
                                                "updateDate": "2023-08-14T08:54:45.5526111",
                                                "route": {
                                                    "path": "/building-a-community/",
                                                    "startItem": {
                                                        "id": "d88fefc3-da04-493d-9533-294a7264b27f",
                                                        "path": "posts"
                                                    }
                                                },
                                                "id": "6e1bc040-f382-402c-ac56-3328d5f424c7",
                                                "properties": {
                                                    "coverImage": [
                                                        {
                                                            "focalPoint": null,
                                                            "crops": [],
                                                            "id": "9757a20c-3e98-49ef-8103-c7fa746856e7",
                                                            "name": "Community",
                                                            "mediaType": "Image",
                                                            "url": "/media/bkrfpf2y/community.png",
                                                            "extension": "png",
                                                            "width": 1080,
                                                            "height": 540,
                                                            "bytes": 25832,
                                                            "properties": {
                                                                "altText": "Two hands constructing a heart from coloured pieces"
                                                            }
                                                        }
                                                    ],
                                                    "excerpt": "Maecenas ipsum dui, lobortis non dui eleifend, dapibus bibendum dui. Pellentesque dolor felis, mollis nec diam eget, fermentum rutrum ipsum. Vestibulum condimentum urna id turpis tempus, id finibus sem facilisis. Nullam commodo felis quis ante posuere, dictum suscipit nisl suscipit."
                                                }
                                            }
                                        }
                                    },
                                    "settings": {
                                        "contentType": "featuredPostSettings",
                                        "id": "6471bae6-1341-4bbd-9e19-e61e8df4446d",
                                        "properties": {
                                            "backgroundColor": "6fa8dc"
                                        }
                                    }
                                }
                            ]
                        }
                    ],
                    "content": {
                        "contentType": "twoColumnLayout",
                        "id": "40d5cf9c-809c-41ed-8639-84d894c2e663",
                        "properties": {}
                    },
                    "settings": null
                }
            ]
        }
    },
    "cultures": {}
}
```
{% endcode %}

### Rich Text Editor (with blocks)

**Request**

```http
GET /umbraco/delivery/api/v2/content/item/article-with-rich-text/
Start-Item: articles
```

**Response**

{% code title="Default Delivery API output" %}
```json
{
    "contentType": "articleWithRichText",
    "name": "Article with Rich Text",
    "createDate": "2023-11-07T16:33:51.5326056",
    "updateDate": "2023-11-07T16:34:11.0504555",
    "route": {
        "path": "/article-with-rich-text/",
        "startItem": {
            "id": "5c8823f6-6442-4d04-9c14-f3411bd41aa8",
            "path": "articles"
        }
    },
    "id": "785a7731-4312-4ed6-b11c-2f82db85c930",
    "properties": {
        "richText": {
            "markup": "<p>Proin mattis enim arcu, ac maximus magna auctor a. Proin sed porttitor nibh, eget venenatis felis. Pellentesque mattis feugiat ultrices. Duis libero velit, sagittis eu nunc euismod, lacinia aliquam elit.</p>\n<umb-rte-block data-content-id=\"a42d825e-383c-4699-ae7f-eb851c0a5b13\"></umb-rte-block>\n<p>Nulla quis fringilla sem. Integer id lacus sit amet ante gravida ullamcorper ac in neque. Etiam at ipsum a augue laoreet commodo. Vestibulum bibendum viverra diam, vel dignissim nunc suscipit id.&nbsp;</p>\n<umb-rte-block data-content-id=\"724ecae7-3118-46a8-8dc2-a9bf9e10efdb\"></umb-rte-block>\n<p>&nbsp;</p>",
            "blocks": [
                {
                    "content": {
                        "contentType": "featuredPost",
                        "id": "a42d825e-383c-4699-ae7f-eb851c0a5b13",
                        "properties": {
                            "title": "Free your content with the Delivery API",
                            "post": {
                                "contentType": "post",
                                "name": "Set your content free",
                                "createDate": "2023-08-14T08:35:58.8397754",
                                "updateDate": "2023-08-14T08:54:41.8018872",
                                "route": {
                                    "path": "/set-your-content-free/",
                                    "startItem": {
                                        "id": "d88fefc3-da04-493d-9533-294a7264b27f",
                                        "path": "posts"
                                    }
                                },
                                "id": "5de65f2e-055e-4e6a-adc3-edb340dcd2e8",
                                "properties": {}
                            }
                        }
                    },
                    "settings": {
                        "contentType": "featuredPostSettings",
                        "id": "109e1f19-93b9-4f5a-9ab2-315aa618c42a",
                        "properties": {
                            "backgroundColor": "ce7e00",
                            "showTags": true
                        }
                    }
                },
                {
                    "content": {
                        "contentType": "featuredPost",
                        "id": "724ecae7-3118-46a8-8dc2-a9bf9e10efdb",
                        "properties": {
                            "title": "Community is key",
                            "post": {
                                "contentType": "post",
                                "name": "Building a community",
                                "createDate": "2023-08-14T08:35:58.6755792",
                                "updateDate": "2023-08-14T08:54:45.5526111",
                                "route": {
                                    "path": "/building-a-community/",
                                    "startItem": {
                                        "id": "d88fefc3-da04-493d-9533-294a7264b27f",
                                        "path": "posts"
                                    }
                                },
                                "id": "6e1bc040-f382-402c-ac56-3328d5f424c7",
                                "properties": {}
                            }
                        }
                    },
                    "settings": {
                        "contentType": "featuredPostSettings",
                        "id": "82b60071-38f6-49e8-896c-da7094895556",
                        "properties": {
                            "backgroundColor": "6fa8dc",
                            "showTags": false
                        }
                    }
                }
            ]
        }
    },
    "cultures": {}
}
```
{% endcode %}

Output with property expansion and limiting:

**Request**

```http
GET /umbraco/delivery/api/v2/content/item/article-with-rich-text/
    ?expand=properties[richText[properties[post[properties[coverImage]]]]]
    &fields=properties[richText[properties[title,post[properties[excerpt,coverImage]],backgroundColor]]]
Start-Item: articles
```

**Response**

{% code title="Delivery API output with expansion and limiting" %}
```json
{
    "contentType": "articleWithRichText",
    "name": "Article with Rich Text",
    "createDate": "2023-11-07T16:33:51.5326056",
    "updateDate": "2023-11-07T16:34:11.0504555",
    "route": {
        "path": "/article-with-rich-text/",
        "startItem": {
            "id": "5c8823f6-6442-4d04-9c14-f3411bd41aa8",
            "path": "articles"
        }
    },
    "id": "785a7731-4312-4ed6-b11c-2f82db85c930",
    "properties": {
        "richText": {
            "markup": "<p>Proin mattis enim arcu, ac maximus magna auctor a. Proin sed porttitor nibh, eget venenatis felis. Pellentesque mattis feugiat ultrices. Duis libero velit, sagittis eu nunc euismod, lacinia aliquam elit.</p>\n<umb-rte-block data-content-id=\"a42d825e-383c-4699-ae7f-eb851c0a5b13\"></umb-rte-block>\n<p>Nulla quis fringilla sem. Integer id lacus sit amet ante gravida ullamcorper ac in neque. Etiam at ipsum a augue laoreet commodo. Vestibulum bibendum viverra diam, vel dignissim nunc suscipit id.&nbsp;</p>\n<umb-rte-block data-content-id=\"724ecae7-3118-46a8-8dc2-a9bf9e10efdb\"></umb-rte-block>\n<p>&nbsp;</p>",
            "blocks": [
                {
                    "content": {
                        "contentType": "featuredPost",
                        "id": "a42d825e-383c-4699-ae7f-eb851c0a5b13",
                        "properties": {
                            "title": "Free your content with the Delivery API",
                            "post": {
                                "contentType": "post",
                                "name": "Set your content free",
                                "createDate": "2023-08-14T08:35:58.8397754",
                                "updateDate": "2023-08-14T08:54:41.8018872",
                                "route": {
                                    "path": "/set-your-content-free/",
                                    "startItem": {
                                        "id": "d88fefc3-da04-493d-9533-294a7264b27f",
                                        "path": "posts"
                                    }
                                },
                                "id": "5de65f2e-055e-4e6a-adc3-edb340dcd2e8",
                                "properties": {
                                    "coverImage": [
                                        {
                                            "focalPoint": null,
                                            "crops": [],
                                            "id": "dbb62958-de31-465f-bdbe-5e9079b54b25",
                                            "name": "Arrows",
                                            "mediaType": "Image",
                                            "url": "/media/lyulnwzr/arrows.png",
                                            "extension": "png",
                                            "width": 1080,
                                            "height": 530,
                                            "bytes": 24069,
                                            "properties": {
                                                "altText": "Some arrows pointing in different directions (but generally upwards)"
                                            }
                                        }
                                    ],
                                    "excerpt": "Fusce ut mauris ornare, mollis felis ac, convallis neque. Aenean eu tortor ac dui dictum lacinia. Aliquam erat volutpat. Sed malesuada congue imperdiet. Sed dictum aliquam velit. Nunc non nibh dignissim, consequat quam ac, mattis turpis. "
                                }
                            }
                        }
                    },
                    "settings": {
                        "contentType": "featuredPostSettings",
                        "id": "109e1f19-93b9-4f5a-9ab2-315aa618c42a",
                        "properties": {
                            "backgroundColor": "ce7e00"
                        }
                    }
                },
                {
                    "content": {
                        "contentType": "featuredPost",
                        "id": "724ecae7-3118-46a8-8dc2-a9bf9e10efdb",
                        "properties": {
                            "title": "Community is key",
                            "post": {
                                "contentType": "post",
                                "name": "Building a community",
                                "createDate": "2023-08-14T08:35:58.6755792",
                                "updateDate": "2023-08-14T08:54:45.5526111",
                                "route": {
                                    "path": "/building-a-community/",
                                    "startItem": {
                                        "id": "d88fefc3-da04-493d-9533-294a7264b27f",
                                        "path": "posts"
                                    }
                                },
                                "id": "6e1bc040-f382-402c-ac56-3328d5f424c7",
                                "properties": {
                                    "coverImage": [
                                        {
                                            "focalPoint": null,
                                            "crops": [],
                                            "id": "9757a20c-3e98-49ef-8103-c7fa746856e7",
                                            "name": "Community",
                                            "mediaType": "Image",
                                            "url": "/media/bkrfpf2y/community.png",
                                            "extension": "png",
                                            "width": 1080,
                                            "height": 540,
                                            "bytes": 25832,
                                            "properties": {
                                                "altText": "Two hands constructing a heart from coloured pieces"
                                            }
                                        }
                                    ],
                                    "excerpt": "Maecenas ipsum dui, lobortis non dui eleifend, dapibus bibendum dui. Pellentesque dolor felis, mollis nec diam eget, fermentum rutrum ipsum. Vestibulum condimentum urna id turpis tempus, id finibus sem facilisis. Nullam commodo felis quis ante posuere, dictum suscipit nisl suscipit."
                                }
                            }
                        }
                    },
                    "settings": {
                        "contentType": "featuredPostSettings",
                        "id": "82b60071-38f6-49e8-896c-da7094895556",
                        "properties": {
                            "backgroundColor": "6fa8dc"
                        }
                    }
                }
            ]
        }
    },
    "cultures": {}
}
```
{% endcode %}

## Closing remarks

Property expansion and limiting is a powerful feature that can boost our application performance. With this, we can prevent additional requests to obtain data for linked items, and we can tailor the output to specific use cases.

However, it is also a complex feature. The query syntax quickly gets complicated, particularly when targeting block editors. You will likely need to experiment to get the query exactly right. Hopefully, the examples in this article will guide you in applying expansion and limiting to your own content.
