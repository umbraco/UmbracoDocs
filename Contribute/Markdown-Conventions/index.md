---
meta.Title: "Markdown conventions"
meta.Description: "Explanation of how to use markdown and how we structure the files."
---

# Markdown conventions

The Umbraco Documentation uses Markdown for all the articles - but more precisely we use the CommonMark specification. Read more about the [difference between CommonMark and Markdown](https://commonmark.org/).

In this article you can learn how to use Markdown, as well as how we structure the files.

## Structure

For the documentation project, each individual topic is contained in its own folder.
Each folder must have an `index.md` file which links to the individual sub-pages, if images are used, these must be in `images` folders next to the .md file referencing them relatively.

* `topic`
  * `images`
    * `images.png`
  * `Subtopic`
    * `images`
    * `index.md`
  * `index.md`
  * `other-page.md`

## Images

Images are stored and linked relatively to .md pages, and should by convention always be in an `images` folder. So to add an image to `/documentation/reference/partials/renderviewpage.md` you link it like so:

```markdown
![My Image Alt Text](images/img.png)
```

And store the image as `/documentation/reference/partials/images/img.png`

Images can have a maximum width of **800px**. Please always try to use the most efficient compression, `gif` or `png`. No `bmp`, `tiff` or `swf` (Flash).

### Center images

By default, all images added to an article in the documentation will be left-aligned. If you want to ensure that the image you add to an article will be center-aligned, use the following formatting:

```markdown
:::center
![Example of the load indicator](images/arm_with_u_logo-SMALL.png)
:::
```

The example above will render the image in the center of the page.

:::center
![Example of the load indicator](images/arm_with_u_logo-SMALL.png)
:::

## Links

In the following you'll find a few examples of different links.

### External links

Include either the complete URL, or link using a specific syntax:

```markdown
https://yahoo.com/something
```

or

```markdown
[yahoo something](https://yahoo.com/something)
```

### Internal links

If you need to link between pages, always link relatively and optionally include the .md extension based on the scenario. For example if you need to provide hyperlink to an `index.md` file which is in the current folder then only the path including the folder name is required. If you want provide hyperlink to any file other than `index.md` in the current folder then only the path including the folder name along with the filename is required. The `.md` extension is not required in this case.

```markdown
[Umbraco.Helpers](Umbraco.Helpers)
```

or

```markdown
[Umbraco.Helpers](../../Reference/Umbraco.Helpers)
```

### Styled links

When you have multiple links that you want to add below an article we recommend using the styled links options. Let's say you've written a guide and want to direct the user to more related articles afterwards, you can do that by using the following formatting.

```markdown
:::links
## Related articles
- [Styled links](/)
- [You can also add `inline code` to links](/)
:::
```

The example above, will render like the following:

:::links
### Related articles

- [Styled links](#)
- [You can also add `inline code` to links](#)
:::

## Formatting code

Indent your sample with 4 spaces, which will cause it to be rendered as `<pre><code>` tags.
For inline code, wrap in ` (backtick) chars.

Use # for the headline, ## for sub headers and ### for parameters (on code reference pages)

For optional parameters wrap in _ (underscore) - end result: `###_optionalParameter_`

## Adding notes, warnings, tips

The Markdown conversion library used in the documentation is called [Markdig](https://github.com/lunet-io/markdig). It has the possibility of adding classes to markdown that you can then target with CSS. There are a few custom Markdown classes that can be used:

```markdown
:::note
This is a note, it contains useful information and also a link: https://thisisalink.com/useful/resource, please make sure it looks nice on Our!
:::

:::warning
This is a warning, it contains useful information and also a link: https://thisisalink.com/useful/resource, please make sure it looks nice on Our!
:::

:::tip
This is a tip, it contains useful information and also a link: https://thisisalink.com/useful/resource, please make sure it looks nice on Our!
:::
```

Will render like this:

:::note
This is a note, it contains useful information and also [a link](https://thisisalink.com/useful/resource), please make sure it looks nice on Our!
:::

:::warning
This is a warning, it contains useful information and also [a link](https://thisisalink.com/useful/resource), please make sure it looks nice on Our!
:::

:::tip
This is a tip, it contains useful information and also [a link](https://thisisalink.com/useful/resource), please make sure it looks nice on Our!
:::

## Styled checklists

Instead of using the classic bullet for lists, the Umbraco documentation provides an option to use checkmarks for lists.

```markdown
:::checklist
* Item 1
* Item 2
* Item 3
* Item 4
:::
```

The list in the snippet above, will give the following checklist on the frontend:

:::checklist

* Item 1
* Item 2
* Item 3
* Item 4

:::


