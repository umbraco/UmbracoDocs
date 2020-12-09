---
meta.Title: "Style Guide"
meta.Description: "A style guide for Umbraco documentation repo."
---

# Style Guide

To ensure that the documentation is readable and has a similar style throughout we have a few rules to follow. These rules are set up with an automatic style linter called [Vale](https://errata-ai.github.io/vale/). Additionally we have a GitHub bot that will check PRs for broken rules and advise you what to change.

## Current style rules

### Punctuation in headings

Try to not use any kind of punctuation in headings and headlines. These should act as titles, and no punctuation is necessary.

For consistency, this rule will give a warning if you end headings with either of these punctuation symbols:

- ?
- :
- .

### Use of Hyperbole

The words in the list below, will cause a warning when they are included in your contribution.

Try not to use any of the mentioned words, as they are often opinionated. What may be 'easy' for you, might not be easy another user reading the article.

<!-- vale off -->

- Simple
- Simply
- Just
- Easily
- Actually

<!-- vale on -->

### Start lists with capital letters

To ensure consistency with grammar and sentence, this rule will give an error if you have a list that starts with uncapitalized words.

### Long sentences

This rule will give an error if you have a sentence with more than 40 words. The number of words may change in the future, generally 20-25 is the recommended amount per sentence in documentation.

This is to improve readability.

### Double spacing

In order to ensure readability and consistency, this rule will warn you if you have more than 1 space in a row in your text.

### Terms

To ensure the consistency in the way terms are spelled throughout the documentation, this rule will suggest a different term if you use one we have deemed wrong.

**Example**:
The term `backoffice` has been seen spelled in many different ways, most commonly:

1. `backoffice`
1. `back office`
1. `back-office`

This rule will kick in if you spell it as number 2 or 3 and suggest you spell it as number 1. For a full list of terms please check the [style rule](https://github.com/umbraco/UmbracoDocs/blob/master/.github/valeStyle/Terms.yml).

## Using Vale locally

One of the big strengths of Vale is that it is possible as a contributor to run the tests locally before you create a PR, there is also a VS Code extension for it.

First step to running Vale locally is to install it following [their documentation](https://errata-ai.github.io/vale/#installation).

Next you can open a command line tool in the documentation repo and run the following command:

```vale --glob='*.md' .```

This tells Vale to test all markdown files (.md) in the current directory (.). The output will look something like this:

![Vale Output](images/vale-output.png)

So it tells you what file has issues, in this case `v8documentation.md`, it broke the [HeadingsPunctuation rule](#punctuation-in-headings), and it did so the following places:

- Line 15, column 36
- Line 59, column 15
- Line 64, column 12

At the end of the list of errors it will tell you the total amount of errors and warnings and how many files it went through.

### VS Code extension

Taking it even further there is an extension for Visual Studio Code that allows you to use Vale as you are writing documentation. It is called `vale` and can be downloaded via the VS Code Marketplace in your editor.
To use it you will still have to install Vale on your computer which can be done following [their documentation](https://errata-ai.github.io/vale/#installation).

The Vale extension will run automatically when you are in Markdown files in VS Code and will give warnings directly in the document as you write, based on the style rules set for the project. It looks like this:

![Example of the extension](images/extension.png)

As you can see this example is from this article further up the page, where I am breaking two rules by listing uncapitalized list items and it is all the hyperbole words we don't want.
