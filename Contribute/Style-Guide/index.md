---
meta.Title: "Style Guide"
meta.Description: "A style guide for Umbraco documentation repo."
---

# Style Guide

To ensure that the documentation is readable and has a similar style throughout we have defined a set of guidelines to follow. These guidelines are set up with an automatic style linter called [Vale](https://github.com/errata-ai/vale). Additionally we have a GitHub bot that will check PRs for broken rules and advise you what to change.

## Content

* [Rules](#rules)
  * [Punctuation in headings](#punctuation-in-headings)
  * [Editorializing](#editorializing)
  * [Start lists with capital letters](#start-lists-with-capital-letters)
  * [Long sentences](#long-sentences)
  * [Double spacing](#double-spacing)
  * [Terms (general)](#terms-general)
  * [Umbraco Terms](#umbraco-terms)
  * [Names](#names)
  * [Brands](#brands)
* [Use Vale locally](#using-vale-locally)
* [Visual Studio Code Extension](#visual-studio-code-extension)

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

Try not to use any of the mentioned words, as they are often opinionated. What may be 'easy' for you, might not be easy for another user reading the article.

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

### Names

In order to ensure that markup languages and other names are capitalized correctly a rule has been added to check for this.

The rule will ensure that instances of *HTML* and *CSS* are always written using only capital letters. It will also check whether *JavaScript* is written in full or if the abbreviation, *js*.

### Brands

In some cases throughout our documentation we refer to other software providers or brands. We have added a rule to ensure that the most commonly used brand names are spelled and capitalized correctly.

The rule will, as an example, ensure that the names *Microsoft* and *Slack* are always capitalized.

## Using Vale locally

One of the big strengths of Vale is that it is possible as a contributor to run the tests locally before you create a PR.

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

## Visual Studio Code extension

Taking it even further there is an extension for Visual Studio Code that allows you to use Vale as you are writing documentation. It is called `vale-vscode` and can be downloaded via the VS Code Marketplace in your editor.

To use it, you will still have to install `Vale Server` on your computer. For more information, see the [Vale + VS Code Integration](https://github.com/errata-ai/vale-vscode#vale--vs-code) article.

The Vale extension will run automatically when you are viewing Markdown files in VS Code. It will present warnings directly in the document as you write, based on the style rules set for the project. It will look similar to this:

![Example of the extension](images/extension.png)
