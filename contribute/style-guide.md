---
meta.Title: "Style Guide"
meta.Description: "A style guide for Umbraco documentation repo."
---

# Style Guide

To ensure that the documentation is readable and has a similar style throughout we have defined a set of guidelines to follow. These guidelines are set up with an automatic style linter called [Vale](https://github.com/errata-ai/vale). Additionally we have a GitHub bot that will check PRs for broken rules and advise you what to change.

## Content

- [Rules](#rules)
  - [Punctuation in headings](#punctuation-in-headings)
  - [Editorializing](#editorializing)
  - [Start lists with capital letters](#start-lists-with-capital-letters)
  - [Long sentences](#long-sentences)
  - [Double spacing](#double-spacing)
  - [Terms (general)](#terms-general)
  - [Umbraco Terms](#umbraco-terms)
  - [Names](#names)
  - [Brands](#brands)
- [Test the docs yourself](#test-the-docs-yourself)
  - [Visual Studio Code Extension](#visual-studio-code-extension)
  - [Use Vale locally](#using-vale-locally)

## Rules

Below you will find a description of each rule the Umbraco Documentation is currently being checked against.

### Punctuation in headings

Try to not use any kind of punctuation in headings and headlines. These should act as titles, and no punctuation is necessary.

For consistency, this rule will give a warning if you end headings with either of these punctuation symbols:

- ?
- :
- .

### Editorializing

The words in the list below, will cause a warning when they are included in your contribution.

Try not to use any of the mentioned words, as they are often opinionated. What may not be difficult for you, might be for another user reading the article.

In most cases, these words can be removed entirely whereas a rephrasing might be necessary in other cases.

<!-- vale off -->

- Simple
- Simply
- Just
- Easily
- Actually

<!-- vale on -->

### Start lists with capital letters

To ensure consistency with grammar and sentence, this rule will give an error if you have a list that starts with uncapitalized words.

An exception to this rule would be when listing items or names that uses *camel case*.

### Long sentences

This rule will give a warning if you have a sentence with more than 25 words.

The rule is added in order to improve readability of the documentation.

### Double spacing

In order to ensure readability and consistency, this rule will warn you if you have more than 1 space in a row in your text.

### Terms (general)

This rule will give you a warning when using a term that we prefer to avoid in the documentation.

**Example**:
The term `blacklist` should be avoided and instead replaced with `deny list`.

For a full list of terms please check the [style rule](https://github.com/umbraco/UmbracoDocs/blob/master/.github/styles/UmbracoDocs/Terms.yml).

### Umbraco Terms

This rule is added in order to ensure that Umbraco specific terms and names are spelled consistently throughout the documentation.

The list of Umbraco Terms includes, but is not limited to *Umbraco*, *backoffice*, *Document Type* and *Umbraco Forms*.

### Defined acronyms

All first-time uses of an acronym in the documentation need to be accompanied by a definition of that acronym. If an acronym is not defined on its first use in an article, the checker will give a warning.

Acronyms should be defined using either parenthesis or a colon followed by the definition.

Examples of the use of acronyms:

Do this: "Members will only have access to **Content Delivery Network (CDN)** endpoints."

Do not do this: "Members will only have access to **CDN** endpoints."

Do this: **YSOD: Yellow Screen of Death**, .NET error page

Do not do this: **YSOD** (.Net error page)

### Names

In order to ensure that markup languages and other names are capitalized correctly a rule has been added to check for this.

The rule will ensure that instances of *HTML* and *CSS* are always written using only capital letters. It will also check whether *JavaScript* is written in full.

### Brands

In some cases throughout our documentation we refer to other software providers or brands. We have added a rule to ensure that the most commonly used brand names are spelled and capitalized correctly.

The rule will, as an example, ensure that the names *Microsoft* and *Slack* are always capitalized.

## Test the docs yourself

One of the big strengths of Vale is that it is possible as a contributor to run the tests locally before you create a PR. Below are a couple of options on how to test the documentation.

### Visual Studio Code extension

There is an extension for Visual Studio Code which allows you to use Vale as you are writing documentation. It can also be used to run checks on existing articles and find where the potential changes are needed.

The extension is called `vale-vscode` and can be downloaded via the Visual Studio Code Marketplace in your editor.

To use it, you will still have to install `Vale Server` on your computer. For more information, see the [official Vale installation](https://vale.sh/docs/vale-cli/installation/) article.

Once the tools have been installed, a check of the complete repository of articles can be done using the terminal within Visual Studio Code.

Run the following command:

```vale --glob='*.md' .```

The Vale extension will also run automatically when you are viewing Markdown files. It will present warnings directly in the document as you write, based on the style rules set for the project. It will look similar to this:

![Example of the extension](images/extension.png)

### Using Vale locally

First step to running Vale locally is to install it following Vale's [Installation documentation](https://vale.sh/docs/vale-cli/installation/).

Next you can open a command line tool in the documentation repository and run the following command:

```vale --glob='*.md' .```

This tells Vale to test all markdown files (.md) in the current directory (.). The output will look something like this:

![Vale Output](images/vale-output.png)

It will show you what file has issues. In the case above the `v8documentation.md` article broke the [HeadingsPunctuation rule](#punctuation-in-headings), and it did so the following places:

- Line 15, column 36
- Line 59, column 15
- Line 64, column 12

When the check has run you will get the total amount of errors, warnings and suggestions including how many files has been checked.
