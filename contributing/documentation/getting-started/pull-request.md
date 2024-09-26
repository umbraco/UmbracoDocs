---
description: Learn the two different ways to submit a PR to the Umbraco Documentation.
---

# Submit a Pull Request

A Pull Request (PR) is a way of submitting changes to an open-source project like the Umbraco documentation.

Let us say you have found a typing or syntax error in one of the articles on the documentation, and you want to correct it. You can do that with a pull request.

There are two ways to create a pull request:

1. You can either edit a file directly on GitHub, or
2. You can create a fork of the GitHub repository.

{% hint style="info" %}
In order to create a PR to the Umbraco Documentation it is required that you have a GitHub account.
{% endhint %}

## Option 1: Creating a PR directly on GitHub

GitHub has a functionality that allows you to submit a PR directly from our [repository](https://github.com/umbraco/UmbracoDocs/). There is also a button on the right side of every article title, which allows you to jump straight into GitHub to suggest your changes.

<figure><img src="../../../.gitbook/assets/image%20(1).png" alt="Highlighting the GitHub Edit button"><figcaption><p>Highlighting the Edit on GitHub button.</p></figcaption></figure>

1. Select "Edit on GitHub" from the right-side of the article you want to suggest changes to.
2. Select the pen icon to start editing the article.
3. Make the changes.
4. Add a title and description explaining what changes you have made and why you made them.
5. Select **Propose changes**.
6. Select **Create pull request** to preview your PR.
7. Select **Create pull request** again to create the PR.

This is helpful to fix typing errors or add small things. If you are working on a larger update that includes pictures and editing files then it is not the best way to work. In that case, you will be better off creating a fork. See below for more thorough instructions on this approach.

## Options 2: Creating a PR through a fork

There are a lot of great tutorials available online on [how to fork a repository (GitHub)](https://help.github.com/articles/fork-a-repo/), but we have also created a guide with instructions.

{% hint style="info" %}
If you do not have Git installed on your machine, you should follow [these instructions](https://help.github.com/articles/set-up-git/) before you go any further.
{% endhint %}

### Step 1: Creating a fork

Once you have set up Git you can create a fork of the [Umbraco Documentation repository](https://github.com/umbraco/UmbracoDocs/).

When you make a fork, you get a copy of the entire repository on your own GitHub profile.

You can create a fork by selecting the **Fork** option at the top of the screen:

![Creating a fork](../images/fork-repository-new.png)

Once the fork has been created you will have your own copy of the Umbraco documentation. If you clone your fork, you will have the files locally which means you can make changes and sync them back up to your fork.

{% hint style="warning" %}
Are you adding a new article to the documentation? Add it to the `SUMMARY.md` file as well to ensure it is added to the navigation.
{% endhint %}

When you are satisfied with the changes you have made, you can submit a pull request to sync your copy with the original repository:

![Fork of documentation](../images/example-of-fork.png)

{% hint style="info" %}
When you have had your fork for some time, you need to sync with the original repository before making new changes. This is called a rebase.

1. Set the original repository (UmbracoDocs) as an upstream to sync from.
2. Fetch the updates.
3. Update your own fork.

```console
git remote add upstream https://github.com/umbraco/UmbracoDocs/
git fetch upstream
git rebase upstream/main
```

This can also be done by using the **Sync fork** option, which will be present once your fork is behind the original repository.

<img src="../images/sync-fork.png" alt="Highlight the Sync fork option available on a fork that is behind the original repository" data-size="original">
{% endhint %}

### Step 2: Creating a pull request

Once you have made some changes and you are happy with the result, you can create a pull request.

1. Navigate to the **Code** section on your fork.
2. Select **Contribute** and then **Open pull request** to get started.

![Highlight option to contribute directly from fork to original repository.](../images/contribute.png)

3. Add a title and description explaining what changes you have made and why you made them.
4. Select **Create pull request** to create the pull request on the original repository.

### Step 3: The review process

Your PR is now subject to review with the Umbraco HQ Documentation team.

We hope to review and resolve all incoming pull requests within a couple of weeks, depending on the extent of the changes.
