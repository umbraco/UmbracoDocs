# Markdown Conventions Reference

Full markdown usage conventions for Umbraco documentation.

## Headings

```markdown
# Article Title        (use only once — the page title)
## Section Heading     (primary sections)
### Sub-section        (appears in right-side table of contents)
#### Sub-sub-section   (does NOT appear in table of contents)
```

Follow correct hierarchy — don't skip from `##` to `####`.

## Text Styling

| Style  | Syntax             | Example             |
| ------ | ------------------ | ------------------- |
| Bold   | `** **` or `__ __` | `This is **bold**.` |
| Italic | `* *` or `_ _`     | `This is *italic*.` |

## Links

### External Links
```markdown
[Link Text](https://example.com/path)
```
External links open in a new tab automatically.

### Internal Links
Always use **relative paths**:
```markdown
[Article Title](article.md)
[Article Title](../../reference/article.md)
```

### Page Links (full-width content references)
```markdown
{% content-ref url="path/to/article.md" %}
[Article Title](path/to/article.md)
{% endcontent-ref %}
```

### Link Text Rules
- Use the destination article's title as link text
- Never use "here" or "link" as link text

## Images

Use relative paths. Always provide alt text or caption.

```markdown
![Caption text](images/descriptive-name.png)
```

HTML syntax (used by GitBook editor):
```html
<figure><img src="images/sample.png" alt="Alt text"></figure>
```

With both alt text and caption:
```html
<figure>
  <img src="images/sample.png" alt="Alt text">
  <figcaption>
    <p>Caption text</p>
  </figcaption>
</figure>
```

When contributing via GitHub, prefer Markdown syntax over HTML.

## Hint Blocks (Notes/Warnings)

Four types: `info`, `success`, `warning`, `danger`.

```markdown
{% hint style="info" %}
Informational note content.
{% endhint %}

{% hint style="warning" %}
Warning content.
{% endhint %}

{% hint style="danger" %}
Critical warning content.
{% endhint %}
```

## Advanced Blocks

### Expandables
Use for large code samples or optional detail. See [GitBook expandables docs](https://gitbook.com/docs/creating-content/blocks/expandable).

### Tabs
Use for showing alternatives (e.g., different install methods). See [GitBook tabs docs](https://gitbook.com/docs/creating-content/blocks/tabs).

### Cards
Do **not** edit Cards HTML on landing pages. Contact the Umbraco HQ Documentation Team for changes.
