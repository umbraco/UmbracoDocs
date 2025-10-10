---
description: >-
  Learn how to create and add new material to the Umbraco Documentation,
  including updated material for upcoming releases.
---

# Create a New Version of an Article

There are 2 common scenarios where you might want to add a new article to the Umbraco Documentation:

1. You are [adding new material](how-to-add-a-new-version.md#add-new-material-to-the-documentation) to the documentation site.
   1. This includes topics or tutorials not previously covered..
2. You are updating [an existing article for an **Upcoming major version**](how-to-add-a-new-version.md#update-an-article-for-an-upcoming-major-version) of a product.

## Add New Material to the Documentation

When you are adding a brand new article to the Umbraco Documentation, there are a few questions that we recommend asking yourself before getting started:

<details>

<summary>What type of article are you going to be writing?</summary>

It could be a tutorial, a guide on how to solve something specific, or an article detailing a specific concept or workflow.

The type of article you are writing will determine the content and sometimes also the structure of the material.

</details>

<details>

<summary>Who is the audience of the article?</summary>

C# developers, newcomers to Umbraco, and content editors each have different approaches and prerequisites to using Umbraco and reading the documentation.

Knowing your audience will enable you to write in a manner that fits that particular group. It will also give you some pointers on what [types of content](#user-content-fn-1)[^1] should be your focus.

</details>

<details>

<summary>Where does the article fit into the existing structure?</summary>

Depending on which product you are adding new material for, the structure of the existing documentation will differ. We recommend browsing the existing material to figure out which section will be the best fit for your new article.

If you have doubts about where to place your article, the team at Umbraco HQ can help you out. In this case, add a note in the description when submitting the PR, letting us know that you need help placing the article.

</details>

The steps to create, write, and add a new article to the Umbraco Documentation are outlined below:

1. Access the [UmbracoDocs GitHub](https://github.com/umbraco/UmbracoDocs) repository.
2. Fork the repository.
3. Clone your fork to your local machine.
4. Create a new branch using the following naming convention: `productname/topic`
   * Branch name example: `cms/new-content-app-tutorial`
5. Locate the section or folder in the existing structure where your article fits.
6. Create a new `.md` file and name it using the title you will give the article.
   * The file name needs to be in small caps and use hyphens instead of spaces.
   * File name example: `statistics-content-app-tutorial.md`.
7. Write the article following:
   1. [Umbraco Style Guide](../style-guide/)&#x20;
   2. [Markdown Conventions](../style-guide/markdown-conventions.md).
8. Add your new article to the [`SUMMARY.md`](#user-content-fn-2)[^2] file so it appears in the documentation navigation.
9. Commit and push your changes to your forked repository.
10. [Submit a PR to the official UmbracoDocs repository](pull-request.md).

## Update an Article for an Upcoming Major Version

The documentation is versioned using directories in the root of the repository. The **major** Umbraco CMS version number is used to name the directories, and you will find documentation for each versioned Umbraco product within them.

{% hint style="info" %}
The documentation follows the Long Term Support (LTS) strategy for Umbraco CMS. This means that whenever a major version is End of Life (EOL), documentation for that version will be moved to GitHub.

Read the [Versioning Strategy](https://docs.umbraco.com/welcome/documentation-and-versions) article to learn more about how to handle documentation for the different versions.
{% endhint %}

The following sections of the Umbraco Documentation follow the versioning strategy:

* Umbraco CMS
* Umbraco Forms
* Umbraco Deploy
* Umbraco Workflow
* Umbraco Commerce
* Umbraco UI Builder
* Umbraco Engage

{% hint style="info" %}
The documentation site for a new major version is publicly available around the Release Candidate (RC) phase. The structure is set up typically 3-4 weeks before the final release.
{% endhint %}

Once the RC is released, you can find the associated documentation using the version drop-down on the Documentation site.

### Update an article for the upcoming release

1. Access the [UmbracoDocs GitHub](https://github.com/umbraco/UmbracoDocs) repository.
2. Fork the repository.
3. Clone your fork to your local machine.
4. Create a new branch using the following naming convention: `productnameXX/topic`
   * Branch name example: `cms15/configuration`
5. Locate the article you need to make changes to.
6. Make the necessary changes to the article.
7. Add and commit the changes.
8. Push the branch to your forked repository.
9. [Submit a PR to the official UmbracoDocs repository](https://docs.umbraco.com/welcome/contribute/pull-request#step-2-creating-a-pull-request).

[^1]: Code samples with comments are great for C# developers, while screenshots and step-by-step lists are good for new Umbraco developers.

[^2]: Only articles that are added to the `SUMMARY.md` file will be visible on the published documentation site.
