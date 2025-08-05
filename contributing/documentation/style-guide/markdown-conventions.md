---
description: Learn how to use Markdown to write articles for the Umbraco Documentation.
---

# Markdown Conventions

The Umbraco Documentation is written in Markdown.

In this article, you can learn how Markdown is used for adding different elements to the articles.

## Headings

To create a heading, add between one to four `#` symbols before your heading text. The number of `#` you use will determine the hierarchy level and size of the heading.

```markdown
# Article Title
## Heading 1
### Heading 2
#### Heading 3
```

<figure><img src="../../.gitbook/assets/Screenshot 2025-06-30 at 12.39.12.png" alt=""><figcaption><p>How the different levels of headings are diplayed on the Documentation site.</p></figcaption></figure>

{% hint style="info" %}
The Article Title (`#`) must be used only once. All other headings should follow the correct hierarchical order.
{% endhint %}

When two or more headings are used in an article, they will be used to generate a table of contents on the right side of the article. Heading 3 will not be shown in the table of contents.

<figure><img src="../../.gitbook/assets/Screenshot 2025-06-30 at 12.43.10.png" alt=""><figcaption><p>A simplified example of a table of contents added based on headings in an article.</p></figcaption></figure>

## Styling text

| Style  | Syntax             | Example             | Output            |
| ------ | ------------------ | ------------------- | ----------------- |
| Bold   | `** **` or `__ __` | `This is **bold**.` | This is **bold**. |
| Italic | `* *` or `_ _`     | `This is *italic*.` | This is _italic_. |

## Links

In the following, you will find a few examples of different links.

### External links

Include either the complete URL using the following syntax:

```markdown
[yahoo something](https://yahoo.com/something)
```

All external links open in a new browser tab.

### Internal links

When linking between pages in the documentation, use **relative paths**.

Link to an article in the same directory as the current article:

```markdown
[Article Title](article.md)
```

Link to an article in a different directory than the current article:

```markdown
[Article Title](../../reference/article.md)
```

### Page Links

It is possible to add a page link that spans the entire width of the page. This is generally used for linking to a new subject related to the article at hand.

The following is a page link that links to the "Submit Feedback" article:

```markdown
{% content-ref url="issues.md" %}

[Article Title](issues.md)

{% endcontent-ref %}
```

{% content-ref url="../getting-started/issues.md" %}
[issues.md](../getting-started/issues.md)
{% endcontent-ref %}

### Link Text

Use the title of the article that is linked to as the _link text_. This is done to tell the reader what they will find on the other end.

Do not use "**here"** or "**link"** as the link text, as this provides no information about the destination.

:no\_entry: Learn more about Document Types [here](https://docs.umbraco.com/umbraco-cms/fundamentals/data/defining-content).

:white\_check\_mark: Learn more about Document Types in the [Defining Content](https://docs.umbraco.com/umbraco-cms/fundamentals/data/defining-content) article.

## Images

Images used in documentation articles must always be added to the repository as well. Learn more about where to add the images in the [File Names and Structure](structure.md) article.

Use relative paths when referencing images in an article.

Use descriptive alt text and captions to enhance accessibility and Search Engine Optimization (SEO) benefits.

```md
// Block with Caption

![This is a sample Caption](images/sample.png)

// Block with Alt text

<figure><img src="images/sample.png" alt="This is a sample Alt text"></figure>

// Block with Caption and Alt text

<figure>
  <img src="images/sample.png" alt="This is a sample Alt text">
  <figcaption>
    <p>This is a sample Caption</p>
  </figcaption>
</figure>
```

{% hint style="info" %}
Always provide an alt text or a caption to describe the image’s purpose and content.
{% endhint %}

### Best practices when working with images

* Use clear and relevant filenames. Example: `dashboard-view.png` instead of `image1.png`.
* Avoid placing large amounts of text in images. If text is required, provide it in the article instead.
* Use SVG format for diagrams and icons where possible to ensure scalability.

## Notes and Warnings

Four types of hints can be added to our documentation: `info`, `success`, `warning`, and `danger`.

[Learn more about how to use hints in the GitBook Docs](https://docs.gitbook.com/tour/editor/blocks/hint).

## Advanced Blocks

It is possible to add more advanced elements such as Expandables and Tabs. These are created using specific GitBook syntax

Learn more about how to work with these elements on the official GitBook documentation:

* [Expandables](https://gitbook.com/docs/creating-content/blocks/expandable)
* [Tabs](https://gitbook.com/docs/creating-content/blocks/tabs)

{% hint style="warning" %}
Avoid editing the HTML used to generate [Cards](https://gitbook.com/docs/creating-content/blocks/cards) on landing pages  in the Umbraco Documentation.

To request changes, contact the Umbraco HQ Documentation Team.
{% endhint %}
