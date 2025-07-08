---
description: >-
  Merge conflicts can happen when the same schema has been modified in both the
  flexible environment and the mainline environment it's connected to.
---

# Merge Conflicts on Flexible Environments

A merge conflict happens when a file or item contains conflicting changes in more than one environment during deployment.

This guide explains how to resolve these merge conflicts and how to avoid them.

## Resolving a Merge Conflict in a Flexible Environment

The image below shows a merge conflict when pulling from the mainline environment to a flexible environment.

![Pulling changes from the mainline environment failed](../../../../troubleshooting/deployments/images/pulling-failed.png)

To start debugging the merge conflict, a log file containing a list of conflicting files is provided. It's a `.txt` file that can be downloaded and viewed.

### Preparations

Before you start resolving the merge conflict, ensure you have the following things ready:

* The log file containing a list of the conflicting files.
* The clone link for the flexible (source) environment.
* The clone link for the mainline (target) environment that flexible environment is connected to.
* An editor that provides Git tools for handling merge conflicts (like Visual Studio Code).

### Steps

1. Download the log file provided from the failed pull (see image above).
2. Clone the flexible environment [to your local machine](../../../../build-and-customize-your-solution/handle-deployments-and-environments/working-locally/).
3. Use the mainline environment clone link to add a new `git remote`:

```git
git remote add [mainline environment name] [mainline environment clone link]
```

4. Fetch the `master` from the added remote:

```git
git fetch [mainline environment name] master
```

5. Merge the `master` into the local clone.

```
git merge [mainline environment name]/master
```

6. Open the cloned files in your favorite editor that also provide Git tools.
7. Go through the conflicting files one by one.
8. Stage and commit the resolved conflicts.
9. Push the change back to the flexible environment.

Once the push to the flexible environment is complete, verify that the merge was successful.

The final thing needed to be done is to complete the deployment to the mainline environment.

{% hint style="info" %}
In case you do not see your changes reflected on the flexible environment, [update the schema manually](../../../../build-and-customize-your-solution/handle-deployments-and-environments/deployment/deploy-dashboard.md#update-umbraco-schema-from-data-files) from the Umbraco backoffice. This will give you an idea of what is wrong enabling you to resolve it.
{% endhint %}

## Avoiding Merge Conflicts in a Flexible Environment

A flexible environment is attached to a single mainline environment. Changes cannot be deployed from the flexible to the mainline environment, before changes from the mainline are pulled into the flexible environment.

Learn more about how flexible environments work in the [Flexible Environments](../../../../begin-your-cloud-journey/project-features/flexible-environments.md) article.

Merge conflicts can be avoided by following these guidelines on the flexible environment:

* Only work on schema specific to a single feature.
* Do not make changes to schema regularly changed in the mainline environment.
