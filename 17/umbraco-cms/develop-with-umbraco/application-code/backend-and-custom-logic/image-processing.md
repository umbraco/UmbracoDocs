---
description: >-
  Learn how Umbraco processes images, how to switch to ImageSharp 2, and when your project needs an ImageSharp license key.
---

# Image Processing

Umbraco resizes, crops, and converts images through an image processing abstraction. The default implementation uses [ImageSharp](https://sixlabors.com/products/imagesharp/) and [ImageSharp.Web](https://sixlabors.com/products/imagesharp-web/) from Six Labors.

This article covers:

* How Umbraco connects to the image processor.
* Why and how to switch to the ImageSharp 2 implementation, which uses the Apache 2.0 license.
* When your project needs a license key from Six Labors.

## How image processing works

Umbraco's core code does not depend on ImageSharp. It uses two abstractions instead:

* `IImageUrlGenerator` builds image URLs with processing commands, such as width, height, and crop. Methods like `GetCropUrl()` use this interface.
* `IImageDimensionExtractor` reads the width and height of uploaded images.

An imaging package provides implementations of these interfaces. The package also adds the middleware that processes image requests. A composer registers everything by calling `AddUmbracoImageSharp()`, so no setup is needed in your own code.

Umbraco ships two imaging packages:

| Package | Six Labors versions | Notes |
| --- | --- | --- |
| `Umbraco.Cms.Imaging.ImageSharp` | ImageSharp 3.x and ImageSharp.Web 3.x | The default. Included in the `Umbraco.Cms` package. |
| `Umbraco.Cms.Imaging.ImageSharp2` | ImageSharp 2.x and ImageSharp.Web 2.x | Uses the Apache 2.0 licensed versions of ImageSharp. |

Both packages use the same namespace, so your code does not need to change when you switch between them.

For the configuration options, see the [Imaging Settings](../../configuration/imagingsettings.md) article. For examples of generating crop URLs, see the [Image Cropper](../../../model-your-content/property-editors/built-in-umbraco-property-editors/image-cropper.md) article.

## Switching to ImageSharp 2

From version 3, ImageSharp and ImageSharp.Web use the [Six Labors Split License](https://sixlabors.com/posts/license-changes/). Under this license, some organizations need a commercial license from Six Labors.

Whether you need one depends on how you use the libraries. Factors include direct or transitive use, your project's license, and your organization's revenue. Review the Six Labors license terms to decide which version suits your project.

ImageSharp 2.x and ImageSharp.Web 2.x use the Apache 2.0 license. Use `Umbraco.Cms.Imaging.ImageSharp2` to stay on these versions. The package also helps when your project or one of its packages depends on ImageSharp 2.x.

{% hint style="warning" %}
The ImageSharp 2 package does not support the `HMACSecretKey` setting. Image URLs are not signed, so anyone can request images with any processing commands. For more information, see the [HMAC secret key](../../configuration/imagingsettings.md#hash-based-message-authentication-code-hmac-secret-key) section.
{% endhint %}

The `Umbraco.Cms` package always includes the default ImageSharp 3 package. To use ImageSharp 2, replace `Umbraco.Cms` with `Umbraco.Cms.Targets` and the other packages that `Umbraco.Cms` includes.

1. Remove the `Umbraco.Cms` package reference from your project file.
2. Add the following package references. Use the same version as the rest of your Umbraco packages.

{% code title="MyProject.csproj" %}
```xml
<ItemGroup>
  <PackageReference Include="Umbraco.Cms.Targets" Version="17.8.0" />
  <PackageReference Include="Umbraco.Cms.Imaging.ImageSharp2" Version="17.8.0" />
  <PackageReference Include="Umbraco.Cms.Persistence.Sqlite" Version="17.8.0" />
  <PackageReference Include="Umbraco.Cms.Persistence.SqlServer" Version="17.8.0" />
  <PackageReference Include="Umbraco.Cms.Persistence.EFCore.Sqlite" Version="17.8.0" />
  <PackageReference Include="Umbraco.Cms.Persistence.EFCore.SqlServer" Version="17.8.0" />
</ItemGroup>
```
{% endcode %}

3. Delete the contents of the media cache folder. The default location is `~/umbraco/Data/TEMP/MediaCache`.
4. Build and run your project.

To switch back to ImageSharp 3, replace these package references with `Umbraco.Cms` and clear the media cache folder again.

## ImageSharp license check

From Umbraco 17.8, the default imaging package uses `SixLabors.ImageSharp` 3.2.0 and `SixLabors.ImageSharp.Web` 3.3.0 or later. These versions include a build-time license check from Six Labors.

Whether your project needs a license key depends on how it references ImageSharp:

* **ImageSharp comes in only through Umbraco or another package**: No license key is needed.
* **Your project has a direct `PackageReference` to `SixLabors.ImageSharp` or `SixLabors.ImageSharp.Web`**: Release builds fail with "No Six Labors license found". Debug builds only show a warning, so you may first notice the failure in CI or when publishing.
* **Your direct reference is pinned to an older version, such as 3.1.12**: Restore fails with a NU1605 package downgrade error. After you update the reference, the previous point applies.

To resolve the build failure, use one of the following options:

* Remove the direct reference if it only exists to pin a version. Umbraco still brings in ImageSharp, so its APIs remain available to your code.
* Get a license key from Six Labors. See [Security Support and License Enforcement](https://sixlabors.com/posts/security-support-and-license-enforcement/) for the license options. See the [ImageSharp documentation](https://docs.sixlabors.com/articles/imagesharp/index.html#how-to-use-the-license-file) for how to configure the key.
* [Switch to ImageSharp 2](#switching-to-imagesharp-2) and change your direct reference to a 2.x version. Your code may need changes, as the ImageSharp 2 and 3 APIs differ.

Projects using `Umbraco.Cms.Imaging.ImageSharp2` stay on ImageSharp 2.x and are not affected by the license check.
