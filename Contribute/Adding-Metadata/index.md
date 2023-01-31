---
meta.Title: "Annotating a document with meta data"
meta.Description: "The documentation markdown files are allowed to contain meta data.  This is done by adding YAML at the top of the document."
meta.RedirectLink: "/contribute/getting-started"
---

# Annotating a document with meta data

The documentation markdown files are allowed to contain meta data.  This is done by adding [YAML](https://en.wikipedia.org/wiki/YAML) at the top of the document.

To add meta data, enclose the data between two lines of three dashes.  Every line of metadata contains a keyword followed by a '`:`' and then the value, e.g.:

    ---
    versionFrom: 7.3.4
    meta.Title: "Contribute to Umbraco CMS"
    meta.Description: "Explanation of how you can contribute to Umbraco, what the process is, and what to keep in mind when contributing."
    ---

Supported meta data properties:

- `versionFrom`: A property with semver notation to indicate the earliest version for which this article is valid
- `versionTo`: A property with semver notation to indicate the last version for which this article is valid
- `versionRemoved`: A property with semver notation to indicate that the topic has been removed from a given version
- `meta.Title`: Used for SEO - [Meta Title](https://moz.com/learn/seo/title-tag)
- `meta.Description`: Used for SEO - [Meta Description](https://moz.com/learn/seo/title-tag)

We have also added other properties that you are welcome to use. They currently do not have any underlying functionality, as this is something we are still working on.

- `keywords`:  Space separated properties, allowing you to supply other keywords which improve findability
- `tags`: Space separated properties, allowing you to add tags which improve findability
- `product`: A property to specify which product(s) the article is relevant for
- `complexity`: A property to specify the level of complexity within the article
- `Audience`: A property to specify the intended audience for the article
