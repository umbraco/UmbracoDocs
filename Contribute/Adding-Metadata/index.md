---
meta.Title: "Annotating a document with meta data"
meta.Description: "The documentation markdown files are allowed to contain meta data.  This is done by adding YAML at the top of the document."
---

# Annotating a document with meta data

The documentation markdown files are allowed to contain meta data.  This is done by adding [YAML](https://en.wikipedia.org/wiki/YAML) at the top of the document.

To add meta data, the metadata is between two lines, each with three dashes.  Every line contains a keyword followed by a '`:`' and then the value e.g.:

    ---
    versionFrom: 7.3.4
    meta.Title: "Contribute to Umbraco CMS"
    meta.Description: "Explanation of how you can contribute to Umbraco, what the process is like and what things to keep in mind when contributing."
    ---

Supported meta data properties:

- `versionFrom`: A property with semver notation to indicate from which version this article is valid
- `versionTo`: A property with semver notation to indicate till which version this article is valid
- `versionRemoved`: A property with semver notation to indicate that the topic has been removed from a given version
- `meta.Title`: Used for SEO - [Meta Title](https://moz.com/learn/seo/title-tag)
- `meta.Description`: Used for SEO - [Meta Description](https://moz.com/learn/seo/title-tag)

We have also added other properties, that you are welcome to use. They currently do not have any underlying functionality, as this is something we are still working on.

- `keywords`:  Space separated properties, adding the possibility to supply other keywords which improve findability
- `tags`: with space separated properties, adding the possibility to add tags which improve findability
- `product`: A property to provide information about which product(s) the article is relevant for
- `complexity`: Adds information about the level of complexity within the article
- `Audience`: Adds information about the intended audience for the article
