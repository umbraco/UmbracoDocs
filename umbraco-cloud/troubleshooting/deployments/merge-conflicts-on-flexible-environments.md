---
description: Merge conflicts can happen on a flexible environment when the same schema has been changed in both the source and target environment.
---

# Merge Conflicts on Flexible Environments

A merge conflicts happens when one file or item contains changed in more than one instance that's part of a deployment.

This guide explains how to resolve these merge conflicts and how to avoid them.

## How to Resolve a Merge Conflict on a Flexible Environment

1. Clone the flexible environment to your local machine.
2. Add a `git remote` to the cloned environment.
3. Fetch the `master` from the added remote.
4. Merge the `master` into the local clone.
5. Go through the conflicts one by one.
6. Commit the resolved conflicts.
7. Push the change back to the flexible environment.

## How to Avoid Merge Conflicts on a Flexible Environment

A flexible environment is attached to a single mainline environment. Changes cannot be deployed from the flexible to the mainline environment, before changes from the mainline are pulled into the flexible environment.

Merge conflicts can avoid by following these guidelines on the flexible environment:

* Only work on schema specific to a single feature.
* Do not make changes to schema regularly changed in the mainline environment.
