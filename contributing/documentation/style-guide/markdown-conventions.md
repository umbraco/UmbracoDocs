---
description: Learn how to use Markdown to write articles for the Umbraco Documentation.
---

# Markdown Conventions

The Umbraco Documentation uses Markdown for all articles.

In this article you can learn how we Markdown for different elements on our documentation.

## Links

In the following you will find a few examples of different links.

### External links

Include either the complete URL, or link using the following syntax:

```markdown
[yahoo something](https://yahoo.com/something)
```

### Internal links

When linking between pages in the documentation, link using relative paths. The following are examples of linking to an article.

Link to an article in the same directory as the current article:

```markdown
[Article Title](article.md)
```

Link to an article in a different directory than the current article:

```markdown
[Article Title](../../reference/article.md)
```

{% hint style="info" %}
Use the title of the article that is linked to, as the _link text_. This is done in order to tell the reader what the will find on the other end.

Do not use **here** or **link** as the link text, as this provides little to no information about the destination.
{% endhint %}

### Page Links

It is possible to add a page link that spans the entire width of the page. This is generally used for linking to a new subject related to the article at hand.

The following is a page link that links to the "Submit Feedback" article:

```markup
{% raw %}
{% content-ref url="issues.md" %}

[issues.md](issues.md)

{% endcontent-ref %}
{% endraw %}


```

{% content-ref url="../getting-started/issues.md" %}
[issues.md](../getting-started/issues.md)
{% endcontent-ref %}

## Formatting code

Code formatting comes in 2 variants: inline code and code blocks.

### Inline code

Use inline code when referencing file names and paths as well as actual code the does not extend over multiple lines.

Inline code should be wrapped in \` (backtick) characters.

### Code Blocks

We follow [GitBooks conventions for adding code blocks](https://docs.gitbook.com/tour/editor/blocks/code-block) to our articles.

## Adding tips and warnings

Four types of hints can be added to our documentation: info, success, warning and danger.

[Learn more about how to use hints in the GitBook Docs](https://docs.gitbook.com/tour/editor/blocks/hint).
