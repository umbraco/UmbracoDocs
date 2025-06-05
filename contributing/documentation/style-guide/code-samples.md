---
description: >-
  When adding code snippets to the Umbraco documentation, refer to this article 
  for tips on how to improve the samples.
---

# Code Samples

The articles in the Umbraco Documentation can, in most cases, benefit from relevant code samples to support the written text.

This article provides guidelines for formatting and using code samples in the Umbraco Documentation.. You will find definitions and examples of the most commonly used types of code samples.

## Example

{% code title="HomePageView.cshtml" %}
```csharp
@if (Model.ColorTheme != null)
{
    var value = Model.ColorTheme;
    <p>@value</p>
}
```
{% endcode %}

### Markdown

````markdown
{% raw %}
{% code caption="HomePageTemplate.cshtml %}

```csharp
@if (Model.HasValue("colorTheme"))
{
    var value = Model.Value("colorTheme");
    <p>@value</p>
}
```

{% endcode %}
{% endraw %}
````

## Good practices

To ensure quality and consistent code samples, follow these best practices when adding code snippets:

* [Define the context](code-samples.md#define-the-context)
* [Add a Caption (file name)](code-samples.md#add-a-caption-file-name)
* [Use code comments in longer code snippets](code-samples.md#use-code-comments)
* [Use real-life samples](code-samples.md#use-real-life-samples)
* [Add correct syntax highlighting](code-samples.md#add-correct-syntax-highlighting)
* [Add only complete compilable samples](code-samples.md#add-only-complete-compilable-samples)
* [Check for syntax errors](code-samples.md#check-for-syntax-errors)
* [Use File-Scoped Namespaces](code-samples.md#use-file-scoped-namespaces)
* [Use line numbers only when relevant](code-samples.md#use-line-numbers-only-when-relevant)

Each guideline is explained in more detail below.

### Define the context

Code samples without context, explanations, and instructions can lead to issues when used.

Always add a clear description of what the code sample showcases when adding a snippet to an article. It should be clear where and when the snippet can be used.

### Add a Caption (file name)

Inform the reader which file or file type a code snippet should be added to.

Aside from mentioning this in the description of the code snippet, it is also recommended to add the file name as a caption.

If the code snippet is from a `.cs` file, add `fileName.cs` as the caption.

Example:

<figure><img src="../../.gitbook/assets/Screenshot 2025-06-04 at 12.10.05.png" alt=""><figcaption><p>Screenshots of a code snippet where the file name is defined using the caption.</p></figcaption></figure>

Markdown example:

````markdown
{% raw %}
{% code caption="ErrorController.cs" %}

```csharp

...
```

{% endcode %}
{% endraw %}
````

### Use code comments

When adding code samples that contain more than a single feature or method, it is recommended to add inline comments.

By adding inline comments, you avoid having too much text surrounding the code sample. You also help readers understand the code snippet in detail.

### Use real-life samples

The documentation often aims to explain complex scenarios and concepts within Umbraco. Code samples can be useful to improve understanding. The code samples should, where possible, be _real-life_ examples.

For example, using variables such as `foo` and `bar` can distract from the intent of the example. Aim to use an example that would make sense to add to a production environment.

To keep the code sample as neutral and general as possible, make it a habit to use placeholders for names, methods, and the like.

With Umbraco, there are often more than one way to achieve a result. It depends on context and the skillset of the development team. Providing multiple examples can help prevent readers from mixing techniques in their solution. An example could be providing a Models Builder version and a non-Models Builder version when documenting Templates.

### Add correct syntax highlighting

When you add code blocks to an article, make sure to add the correct syntax highlighting. This will "prettify" the code in the sample based on which language is used.

Syntax highlighting makes the code snippet easier to read, as it allows the reader to distinguish between the different code elements.

Example:

<div><figure><img src="../../.gitbook/assets/Screenshot 2025-06-04 at 12.10.05.png" alt=""><figcaption><p>Example of a code snippet that uses the correct syntax highlighting.</p></figcaption></figure> <figure><img src="../../.gitbook/assets/Screenshot 2025-06-04 at 12.14.16.png" alt=""><figcaption><p>Example of a code snippet that is missing syntax highlighting.</p></figcaption></figure></div>

Markdown example:

````
{% raw %}
{% code caption="ErrorController.cs" %}

```csharp
using Microsoft.AspNetCore.Mvc;

namespace YourProjectNamespace.Controllers;

...
```

{% endcode %}
{% endraw %}
````

If the language used in a snippet isn't supported, use `none`.

### Add only complete compilable samples

A reader of the Umbraco Documentation should be able to grab code samples in the articles and apply them directly to their solution. The code in the sample should compile.

Include any relevant `Using` statements for namespaces that provide 'extension' methods and key functionality.

### Check for syntax errors

When reading any piece of text, it can be frustrating to run into spelling and syntax errors. This also applies to code samples.

Any code that is added to articles in the documentation should be double-checked for syntax errors and typos.

### Use File-Scoped Namespaces

The use of file-scoped namespaces improves the readability of the code samples. Use file-scoped namespaces in the examples. Below is an example of how to use file-scoped namespaces:

#### With File-Scoped Namespace

```csharp
namespace MyProject;

public class Umbraco
{
}
```

#### Without File-Scoped Namespace

```csharp
namespace MyProject
{
    public class Umbraco
    {
    }
}
```

### Use line numbers only when relevant

It is recommended to use line numbers only when you will be adding text that references specific lines and elements in a larger code snippet.

Example:

<figure><img src="../../.gitbook/assets/Screenshot 2025-06-03 at 14.32.44.png" alt=""><figcaption><p>An image of a code samples that uses line numbers.</p></figcaption></figure>

Markdown example:

````
{% raw %}
{% code title="UmbracoAppAuthenticatorComposer.cs" lineNumbers="true" %}

```csharp
namespace My.Website;

...
```

{% endcode %}
{% endraw %}
````

## When to use code samples

Code samples are relevant for most types of articles. Potentially, any topic covered could benefit from a real-life code sample to support the article content.

In most cases, you will want to base an article on a single code sample. If you're describing a flow or feature, you will, however, want to add smaller code snippets to highlight specific points.

### Types of samples

The Umbraco Documentation operates with three types of code samples.

#### Inline code

Use inline code when:

* Referencing methods.
* Using the names of certain code elements.
* Highlighting a certain value.

Example:

{% code overflow="wrap" %}
```markdown
Each item is treated as a standard `IPublishedElement` entity, which means you can use all the value converters you are used to using.
```
{% endcode %}

The markdown above will output the following:

![Example of inline code](../images/inline-sample.png)

#### Smaller code snippets

As part of longer articles or tutorials, use smaller code snippets to highlight what must be implemented.

These snippets can be added between sections anywhere in an article without breaking focus from the main topic. Keep in mind that adding too many snippets in quick succession can confuse the flow of the article.

Example:

```csharp
@{
    // Perform an null-check on the field with alias 'pageTitle'
    if (Model.HasValue("pageTitle")){
        // Print the value of the field with alias 'pageTitle'
        <p>@(Model.Value("pageTitle"))</p>
    }
}
```

The Razor snippet above will output the following:

![Example of smaller code snippet](../images/codesnippet-sample.png)

#### Large code samples

As part of tutorials and longer articles covering a specific workflow, it might make sense to add longer code snippets or even entire files.

It is recommended to add longer code snippets into [Expandables](https://gitbook.com/docs/creating-content/blocks/expandable) using the file name as the title. When adding code snippets into expandables, the reader can expand the code only when they are ready.

It is highly recommended to use [line numbers](code-samples.md#use-line-numbers-only-when-relevant) in large code samples. This will make it easier to reference certain parts of the sample in the surrounding text.
