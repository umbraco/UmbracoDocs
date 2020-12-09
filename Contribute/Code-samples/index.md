---
meta.Title: "Code samples - Best practices"
meta.Description: "We highly recommend supporting your documentation articles with code samples. Make sure the samples follow our best practices outlined in this article."
---

# Code samples

The articles in the Umbraco Documentation can in most cases benefit from relevant code samples to support the written text.

In this article, you will find some guidelines which outline how we recommend formatting and using code samples for consistency in the documentation pages. We provide definitions and examples of the most used types of code samples in the Umbraco Documentation.

## Good practices

In order to ensure the quality and consistency of all the various code samples in the Umbraco Documentation, we have outlined a set of good practices that we highly recommend that you follow, when adding code snippets to articles.

* Add a clear description
* Use code comments
* Use real-life samples
* Add correct syntax highlighting
* Add only complete compilable samples (incl. `using` statements)
* Check for syntax errors

Each of these guidelines is explained in more detail below.

### Add a clear description

Having a code sample in an article without explaining what the code does and how it can be used, could leave the reader confused and potentially they could end up running into issues when using the snippet.

Make sure to **always** add a clear description of what the code sample showcases before or after adding the snippet to the article. It should be clear where and when the snippet can be used.

### Use code comments

When you are adding code samples that contain more than a single feature or a single method, it is highly recommended that you add inline-comments directly in the code.

By adding comments directly in the code you can avoid having too much text surrounding the code sample, and you also help readers understand each section or part of the code snippet in detail.

Note that the use of code comments does not eliminate the need for a description of the code sample in the surrounding text.

### Use real-life samples

The documentation often aims to explain complex scenarios and concepts within Umbraco, which means that code samples can be very useful to further the understanding. It is important that these code samples are *real-life* clear examples. For example, using variables such as 'foo' and 'bar' can distract from the intent of the example. Aim to use an example that would make sense to add to a production environment.

It can be a good idea to use *placeholders* for names, methods and other things, in order to keep the code samples as neutral and general as possible, although that is not a requirement.

With Umbraco, depending on the context of the implementation and the skillset of the development team - often there is more than one way to achieve a result. Having multiple examples, eg a Modelsbuilder version, a non-Modelsbuilder version etc - can help prevent readers from mixing techniques in their solution, so try to consider the context of alternative approaches, and its fine to provide multiple examples.

### Add correct syntax highlighting

When you add code blocks to an Umbraco Docs article make sure that you add the correct syntax highlighting. This will "prettify" the code in the sample, based on which language is used. In the Umbraco Documentation the following languages are supported for syntax highlighting:

* Csharp
* Json
* Javascript
* Html
* Xml

The package used for the syntax highlighting can be found here: [Syntax Highlighter](https://github.com/abjerner/Skybrud.SyntaxHighlighter/blob/master/src/Skybrud.SyntaxHighlighter/Language.cs).

To add syntax highlighting, add the name of the language in lower case directly after the first three backticks:

![Where to add syntax highlighting](images/add-syntax-highlighting.png)

Code sample without syntax highlighting:

![Code sample without syntax highlighting](images/snippet-without-syntaxhighlighting.png)

The same code sample with syntax highlighting:

![The same code sample with syntax highlighting](images/snippet-with-syntaxhighlighting.png)

If you are adding a code sample using a language that isn't support, it is recommended that you add a `none` label instead.

### Add only complete compilable samples (incl. `using` statements)

As a reader of the Umbraco Documentation, you should be able to grab code samples in the articles and apply them directly to your own code solution. Keep in mind that his is an aspiration and there might be a need for some minor alterations, but on the most basic level, the code in the sample should at the very least be compilable. Including any relevant Using statements for namespaces that might provide that 'extension' method or key functionality.

### Check for syntax errors

When reading any piece of text be it documentation or a novel, there is nothing more frustrating that running into spelling and syntax errors. This also applies for code samples.

Any code that is added to articles in the documentation should be double-checked for syntax errors and typos.

## When to use code samples

Code samples are relevant for most types of articles in the Umbraco Documentation. Potentially, any topic covered could benefit from a real-life code sample to support the surrounding contents of the article.

You might want to base an entire article on one code sample, or perhaps you're describing a flow or feature where you might want to add several smaller code snippets to highlight various points.

### Types of samples

As a basis, we're working with 3 types of code samples in the Umbraco Documentation.

#### Inline code

Use inline code when you are referencing methods, using names of various elements or highlighting a certain value.

Example:

```markdown
Each item is treated as a standard `IPublishedElement entity`, which means you can use all the value converters you are used to using.
```

The markdown above will output the following:

:::center
![Example of inline code](images/inline-sample.png)
:::

#### Smaller code snippets

As part of longer articles or tutorials, we recommend using smaller code snippets within the text to highlight the various bits of code that need to be implemented at each step.

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

:::center
![Example of smaller code snippet](images/codesnippet-sample.png)
:::

#### Large code samples

As part of tutorials and longer articles explaining a certain workflow, it might make sense to add a full code sample of the topic covered.

An example of this could be the tutorial on [creating a custom Dashboard](../../Tutorials/Creating-a-Custom-Dashboard) for your Umbraco project. This article uses various smaller code snippets mixed in with the steps and text sections. At the bottom of the article, you will notice a full example of the file that has been built on throughout the tutorial - this is an example of a large code sample.

We recommend creating separate articles for these large code samples and using them as references instead of adding them as part of the actual article. Having long snippets in an article which already contains multiple sections and steps, can make the article confusing.

When adding these large code samples, make sure to link to the sample from the relevant tutorial(s) as well as linking from the article containing to sample, to the tutorial where the sample is referenced.
