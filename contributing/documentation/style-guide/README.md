---
description: >-
  Keep the Umbraco documentation accessible, consistent, and readable by
  following the style guide defined in this article.
---

# Style Guide

To ensure that the documentation is readable and has a similar style throughout, follow the guidelines outlined in this article. A GitHub bot will check PRs for broken rules and advise you on what to change.

## Text Formatting

Below you will find a description of each rule the Umbraco Documentation follows.

### Avoid Punctuation in Headings

Don't use punctuation in headings and headlines. These should act as titles, and no punctuation is necessary.

For consistency, this rule will give a warning if you end headings with either of these punctuation symbols:

* ?
* :
* .

### Avoid Double spacing

To ensure readability and consistency, this rule will warn you if you have more than one space in a row in your text.

### Use Lists when Listing more than 2 Items/Steps

There are two types of commonly used lists in the Umbraco documentation: ordered lists and unordered lists.

* Use **ordered lists** for sequential task steps.
* Use **unordered lists** for sets of options, notes, criteria, and the like.
* Start lists with capital letters.
  * An exception to this rule would be when listing method names that use _camelcase_. In this case, highlight the names using in-line code formatting.

#### Ordered lists

To keep ordered lists short and to the point, follow these guidelines:

* Start each item on the list with the **action** word.
  * :no\_entry: The next thing to do, is to _navigate to_ the Content section.
  * :white\_check\_mark: _Navigate to_ the Content section.
* Add a maximum of two actions per list item.
* Keep each list item short and to the point.
  * Add additional information in one or more sub-list items.

## Language

### Write in the second person

Address the reader directly using "you".

⛔ The user should add the Document Type by clicking the Add button.

✅ You can add the Document Type by clicking…

### Use the present tense and active voice

Use the present tense for statements that describe general behavior that's not associated with a particular time.

⛔ The Document Type was added…

✅ The Document Type is added...

### Avoid Editorializing

The words in the list below will cause a warning when included in your contribution.

Avoid using the following words, as they are often opinionated. What may be 'easy' for you might not be easy for another user reading the article.

In most cases, these words can be removed entirely, whereas a rephrasing might be necessary in other cases.

* Simple
* Simply
* Just
* Easily
* Actually

### Avoid Long sentences

This rule flags any sentence longer than 25 words. Shorter sentences improve clarity and readability.

The rule is added to improve the readability of the documentation. When a sentence is longer than 25 words, the readability is degraded. This is especially true for technical content that is meant to be instructional.

### Avoid using "it" or "this" as references

To avoid confusion, don't use "it" or "this" to refer to an action or item referenced at an earlier point. The only exception to this rule is when used within the same sentence.

⛔ This can now be configured.

✅ The Document Type can now be configured.

## Terms and Names

### Terms (general)

This rule flags any use of discouraged terms in the Umbraco Documentation.

**Example**: The term `blacklist` must be avoided and replaced with `deny list`.

For a full list of terms, please check the [style rule](https://github.com/umbraco/UmbracoDocs/blob/master/.github/styles/UmbracoDocs/Terms.yml).

### Umbraco Terms

This rule is added to ensure that Umbraco-specific terms and names are spelled and used consistently throughout the documentation.

The list of Umbraco Terms includes, but is not limited to _Umbraco_, _backoffice_, _Document Type,_ and _Umbraco Forms_.

### Acronyms

All first-time uses of an acronym in an article need to be accompanied by a definition of that acronym. If an acronym is not defined on its first use in an article, the checker will give a warning.

Acronyms are defined using either a parenthesis or a colon followed by the definition.

Examples of the use of acronyms:

:no\_entry: Members will only have access to **CDN** endpoints.

:white\_check\_mark: Members will only have access to **Content Delivery Network (CDN)** endpoints.

:no\_entry: **YSOD** (.Net error page)

:white\_check\_mark: **YSOD: Yellow Screen of Death**, .NET error page

### Names

To ensure that markup languages and other names are capitalized correctly, a rule has been added to check for this.

The rule will ensure that instances of _HTML_ and _CSS_ are always written using only capital letters. It will also check whether _JavaScript_ is written in full.

### Brands

In some cases, throughout the documentation, other software providers or brands are referenced. This rule is added to ensure that the most commonly used brand names are spelled and capitalized correctly.

The rule will, as an example, ensure that the names _Microsoft_ and _Slack_ are always capitalized.

***

## Test the documentation yourself

One of the big strengths of Vale is that it is possible for a contributor to run the tests locally before creating a PR. Below are a couple of options on how to test the documentation.

<details>

<summary>Visual Studio Code extension</summary>

There is an extension for Visual Studio Code that allows you to use Vale as you are writing documentation. It can also be used to run checks on existing articles and find where potential changes are needed.

The extension is called `vale-vscode` and can be downloaded via the Visual Studio Code Marketplace in your editor.

To use it, you will still have to install a `Vale Server` on your computer. For more information, see the [official Vale installation](https://vale.sh/docs/vale-cli/installation/) article.

Once the tools have been installed, a check of the complete repository of articles can be done using the terminal within Visual Studio Code.

Run the following command:

`vale --glob='*.md' .`

The Vale extension will also run automatically when you are viewing Markdown files. It will present warnings directly in the document as you write, based on the style rules set for the project. It will look similar to this:

![Example of the extension](<../../../.gitbook/assets/extension (1).png>)

</details>

<details>

<summary>Use Vale locally</summary>

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

</details>
