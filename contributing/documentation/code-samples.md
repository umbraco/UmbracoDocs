---
description: >-
  When adding code snippets to the Umbraco documentation, refer to this article 
  for tips on how to improve the samples.
---

# Code Blocks

The articles in the Umbraco Documentation can in most cases benefit from relevant code samples to support the written text.

In this article, you will find guidelines that outline how we recommend formatting and using code samples. We provide definitions and examples of the most used types of code samples in the Umbraco Documentation.

## Code Block example

```markdown

    {% code title="index.js" overflow="wrap" lineNumbers="true" %}

    ```html
    @{
        // Perform an null-check on the field with alias 'pageTitle'
        @if (!Model.HasValue(Model.PageTitle))
        {
            // Print the value of the field with alias 'pageTitle'
            <p>@Model.PageTitle</p>
        }
    }
    ```

    {% endcode %}

```

## Good practices

To ensure quality and consistent code samples, follow these best-practices when adding code snippets.

* Define the context
* Add a title (file name)
* Use code comments
* Use real-life samples
* Add correct syntax highlighting
* Add only complete compilable samples (incl. `using` statements)
* Check for syntax errors

Each of these guidelines is explained in more detail below.

### Define the context

Code samples without context, explanations, and instructions can make the reader run into issues when using the snippet.

Make sure to **always** add a clear description of what the code sample showcases before or after adding the snippet to the article. It should be clear where and when the snippet can be used.

### Add a title (file name)

Inform the reader which file or file type a code snippet should be added to.

Aside from mentioning this in the description of the code snippet, it is also recommended to add the file name as a title.

Is the code snippet from a JSON file, add `fileName.json` as the caption.

Add the file name to the markup around the code block: `{% code title="fileName.json" %}`

### Use code comments

When adding code samples that contain more than a single feature or method, it is recommended that you add inline comments.

By adding inline comments you avoid having too much text surrounding the code sample, and you also help readers understand the code snippet in detail.

The use of code comments does not eliminate the need for a description of the code sample in the surrounding text.

### Use real-life samples

The documentation often aims to explain complex scenarios and concepts within Umbraco. This means that code samples can be useful to further the understanding. It is important that the code samples are _real-life_ examples.

For example, using variables such as 'foo' and 'bar' can distract from the intent of the example. Aim to use an example that would make sense to add to a production environment.

Try to use _placeholders_ for names, methods, and the like, in order to keep the code samples as neutral and general as possible.

With Umbraco, often there are often more than one way to achieve a result, depending on context and the skillset of the development team. Having multiple examples - for example, a Modelsbuilder version and a non-Modelsbuilder version - can help prevent readers from mixing techniques in their solution. It is fine to provide multiple examples.

### Add correct syntax highlighting

When you add code blocks to an article, make sure that you add the correct syntax highlighting. This will "prettify" the code in the sample based on which language is used.

If you are adding a code sample using a language that isn't supported, it is recommended that you add a `none` label instead.

### Add only complete compilable samples (incl. `using` statements)

A reader of the Umbraco Documentation should be able to grab code samples in the articles and apply them to their own code solution. While there might be a need for some minor alterations, the code in the sample should compile.

Include any relevant `Using` statements for namespaces that provide 'extension' methods or key functionality.

### Check for syntax errors

When reading any piece of text, there is nothing more frustrating than running into spelling and syntax errors. This also applies to code samples.

Any code that is added to articles in the documentation should be double-checked for syntax errors and typos.

### Use File Scoped Namespaces

The use of file-scoped namespaces improves, among other things, the readability of the code samples. Therefore, use file scoped namespaces in the examples. See below how to use file-scoped namespaces:

```csharp
namespace MyProject;

public class Umbraco
{
}
```

Instead of: 

```csharp
namespace MyProject
{
    public class Umbraco
    {
    }
}
```

## When to use code samples

Code samples are relevant for most types of articles. Potentially, any topic covered could benefit from a real-life code sample to support the contents of the article.

You might want to base an entire article on one code sample. Alternately, if you're describing a flow or feature, you might want to add smaller code snippets to highlight specific points.

### Types of samples

As a basis, we are working with 3 types of code samples in the Umbraco Documentation.

#### Inline code

Use inline code when you are referencing methods, using the names of the elements or highlighting a certain value.

Example:

```markdown
Each item is treated as a standard `IPublishedElement entity`, which means you can use all the value converters you are used to using.
```

The markdown above will output the following:

![Example of inline code](images/inline-sample.png)

#### Smaller code snippets

As part of longer articles or tutorials, we recommend using smaller code snippets to highlight the bits of code that need to be implemented.

These snippets can be added between sections anywhere in an article without breaking focus from the main topic. Keep in mind that adding too many snippets in quick succession can be confusing to the flow of the article.

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

![Example of smaller code snippet](images/codesnippet-sample.png)

#### Large code samples

As part of tutorials and longer articles explaining a specific workflow, it might make sense to add a full code sample of the topic covered.

We recommend creating separate articles for these large code samples and using them as references, instead of adding them as part of the actual article. Having long snippets in an article that already contains multiple sections and steps can make the article confusing.

It is highly recommended to use line numbers in large code samples. This will make it easier to reference certain parts of the sample in the surrounding text.
