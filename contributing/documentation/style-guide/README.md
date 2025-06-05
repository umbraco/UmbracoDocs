---
description: >-
  Help us keep the Umbraco documentation accessible and readable by following
  our style guide which is defined in this article.
---

# Style Guide

To ensure that the documentation is readable and has a similar style throughout we have defined a set of guidelines to follow. Most of the guidelines outlined here are set up with an automatic style linter called [Vale](https://github.com/errata-ai/vale). Additionally, we have a GitHub bot that will check PRs for broken rules and advise you on what to change.

## Rules

Below you will find a description of each rule the Umbraco Documentation is currently being checked against.

### Punctuation in headings

Try to not use any kind of punctuation in headings and headlines. These should act as titles, and no punctuation is necessary.

For consistency, this rule will give a warning if you end headings with either of these punctuation symbols:

* ?
* :
* .

### Editorializing

The words in the list below will cause a warning when they are included in your contribution.

Try not to use any of the mentioned words, as they are often opinionated. What may be 'easy' for you, might not be easy for another user reading the article.

In most cases, these words can be removed entirely whereas a rephrasing might be necessary in other cases.

* Simple
* Simply
* Just
* Easily
* Actually

### Start lists with capital letters

To ensure consistency with grammar and sentences, this rule will give an error if you have a list that starts with uncapitalized words.

An exception to this rule would be when listing items or names that use _camelcase_.

### Language Guidelines

Use the following language rules to keep the documentation clear and user-focused:

* **Write in the second person**: Address the reader directly using "you."
  * ⛔ "The user should add the Document Type by clicking the Add button."
  * ✅ “You can add the Document Type under…”
* **Use the present tense and active voice**:
  * ⛔ “The Document Type was added…”
  * ✅ “You can now test whether it works.”
* **Avoid using "it" or "this" as vague references**: Always replace them with what they refer to, unless used within the same sentence.
  * ⛔ “This can now be configured.”
  * ✅ “The Document Type can now be configured.”

### Long sentences

This rule will give a warning if you have a sentence with more than 25 words.

The rule is added in order to improve the readability of the documentation.

### Double spacing

In order to ensure readability and consistency, this rule will warn you if you have more than 1 space in a row in your text.

### Terms (general)

This rule will give you a warning when using a term that we prefer to avoid in the documentation.

**Example**: The term `blacklist` should be avoided and instead replaced with `deny list`.

For a full list of terms please check the [style rule](https://github.com/umbraco/UmbracoDocs/blob/master/.github/styles/UmbracoDocs/Terms.yml).

### Umbraco Terms

This rule is added in order to ensure that Umbraco-specific terms and names are spelled consistently throughout the documentation.

The list of Umbraco Terms includes, but is not limited to _Umbraco_, _backoffice_, _Document Type,_ and _Umbraco Forms_.

### Defined acronyms

All first-time uses of an acronym in the documentation need to be accompanied by a definition of that acronym. If an acronym is not defined on its first use in an article, the checker will give a warning.

Acronyms should be defined using either a parenthesis or a colon followed by the definition.

Examples of the use of acronyms:

:no\_entry: Do not do this: "Members will only have access to **CDN** endpoints."

:white\_check\_mark: Do this: "Members will only have access to **Content Delivery Network (CDN)** endpoints."

:no\_entry: Do not do this: **YSOD** (.Net error page)

:white\_check\_mark: Do this: **YSOD: Yellow Screen of Death**, .NET error page

### Names

In order to ensure that markup languages and other names are capitalized correctly a rule has been added to check for this.

The rule will ensure that instances of _HTML_ and _CSS_ are always written using only capital letters. It will also check whether _JavaScript_ is written in full.

### Brands

In some cases, throughout our documentation, we refer to other software providers or brands. We have added a rule to ensure that the most commonly used brand names are spelled and capitalized correctly.

The rule will, as an example, ensure that the names _Microsoft_ and _Slack_ are always capitalized.

### Lists

There are two types of commonly used lists in the Umbraco documentation: ordered lists and unordered lists.

We recommend using ordered lists for sequential task steps and unordered lists for sets of options, notes, criteria, and the like.

In order to keep lists short and to the point, we recommend that you follow these guidelines:

* Start each item on the list with the **action** word.
  * :no\_entry: Do not do this: "The next thing to do, is to _navigate to_ the Content section"
  * :white\_check\_mark: Do this: "_Navigate to_ the Content section"
* Add a maximum of two actions per item list.
* Keep each list item short and to the point.
  * Add additional information in one or more sub-list items.

## Test the documentation yourself

One of the big strengths of Vale is that it is possible for a contributor to run the tests locally before you create a PR. Below are a couple of options on how to test the documentation.

### Visual Studio Code extension

There is an extension for Visual Studio Code that allows you to use Vale as you are writing documentation. It can also be used to run checks on existing articles and find where potential changes are needed.

The extension is called `vale-vscode` and can be downloaded via the Visual Studio Code Marketplace in your editor.

To use it, you will still have to install a `Vale Server` on your computer. For more information, see the [official Vale installation](https://vale.sh/docs/vale-cli/installation/) article.

Once the tools have been installed, a check of the complete repository of articles can be done using the terminal within Visual Studio Code.

Run the following command:

`vale --glob='*.md' .`

The Vale extension will also run automatically when you are viewing Markdown files. It will present warnings directly in the document as you write, based on the style rules set for the project. It will look similar to this:

![Example of the extension](<../../../.gitbook/assets/extension (1).png>)

### Using Vale locally

The first step to running Vale locally is to install it following Vale's [Installation documentation](https://vale.sh/docs/vale-cli/installation/).

Next, you can open a command line tool in the documentation repository and run the following command:

`vale --glob='*.md' .`

This tells Vale to test all markdown files (.md) in the current directory (.). The output will look something like this:

![Vale Output](<../../../.gitbook/assets/vale-output (1).png>)

It will show you what file has issues. In the case above the `v8documentation.md` the article broke the [HeadingsPunctuation rule](./#punctuation-in-headings), and it did so in the following places:

* Line 15, column 36
* Line 59, column 15
* Line 64, column 12

When the check has run you will get the total amount of errors, warnings, and suggestions including how many files have been checked.
