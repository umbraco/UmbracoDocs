---
description: >-
  Learn how to structure files and images when working with the Umbraco
  Documentation.
---

# File Names and Structure

When contributing to the Umbraco documentation, it is useful to know how to structure directories, files, and images.

In this article, you'll get an overview of the file structure and learn about the naming conventions used for elements in the structure.

## File names

How files, directories, and images are named is important for consistency, but also for ensuring continuous compatibility with GitBook, where the Documentation sites are hosted.

* All file and directory names must use **lowercase**.
  * Exception: Name all parent articles `README.md`, and name the surrounding directory using the title of the `README.md` file.
* Use **hyphens** (`-`) instead of spaces.
* Use the **title of the article** when naming the associated file.
* Give images descriptive names matching the content associated with them.

## File structure

The overall structure of the Umbraco documentation is divided by version and product. Each Umbraco version has its own directory, and in those, each product has its own directories with articles and images.

Diving one step deeper, each individual topic is contained in its own directory.

Each directory must have a `README.md` file which will act as a landing page for that directory and a parent page to all other articles added within.

When images are used, they must be in an `images` directory next to the `.md` file referencing them using relative paths.

* `/topic` _(directory)_
  * `README.md`  (_landing page/parent article_)
  * `another-article.md`
  * `/images` _(directory)_
    * `images.png`
  * `/subtopic` _(directory)_
    * `README.md` (_landing page/parent article_)
    * `article.md`
    * `another-article.md`
    * `/images` _(directory)_

## Documentation Navigation&#x20;

Independent of how the files are structured in the directories, it is the `SUMMARY.md` file that ultimately determines how the documentation navigation is displayed.

Each product directory has a `SUMMARY.md` file wherein all articles related to that product are listed.

It is possible to add groups to separate the article into sections. This is done using two `#` symbols followed by the section name: `## Fundamentals` .

{% hint style="warning" %}
An article is not available on the public documentation site unless it is listed within the `SUMMARY.md` file.
{% endhint %}

## Structural Changes

These changes include moving an article to a different section, renaming or deleting an article as well as adding a new article.

When either of the actions above occurs, it needs to be tracked in two files: `.gitbook.yaml` and `SUMMARY.md`.

### Moving an article

When an article is moved to a different section/directory, follow these steps:

1. Update the relative path to the file in the closest `SUMMARY.md` file.
2. Move the article link in the `SUMMARY.md` file to the correct section.
3. Add a redirect to the `redirects` section of the closest `.gitbook.yaml` file.
   1. _Example_: `relative/path/to/current/location: relative/path/to/new/location.md`

### Renaming an article

When an article is renamed, follow these steps to track the changes:

1. Update the Title and the relative path to the file in the closest `SUMMARY.md` file.
2. Add a redirect to the `redirects` section of the closest `.gitbook.yaml` file.
   1. _Example_: `path/to/current-name: path/to/new-name.md`

### Deleting an article

When an article is deleted from the documentation, follow these steps to avoid broken links:

1. Remove the file from the closest `SUMMARY.md` file.
2. Add a redirect to the `redirects` section of the closest `.gitbook.yaml` file.
   1. Point to either the article's replacement or to the parent article.
   2. _Example_: `path/to/article: path/to/new-article-or-parent.md`

### Adding a new article

When a new article is added, it must also be added to the `SUMMARY.md` file to show up in the published documentation:

1. Add the article to the `SUMMARY.md` file like this:
   * Example: `* [Article Title](path/to/article.md)`&#x20;
