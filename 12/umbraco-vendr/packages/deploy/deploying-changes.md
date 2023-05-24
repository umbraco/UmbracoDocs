---
description: >-
  Learn more about the advantages of using the Vendr Deploy package with Umbraco
  Vendr.
---

# Deploying Changes

After installing Vendr Deploy, it will automatically serialize any changes made in the Vendr settings section to disk. They will be added to the `data\revision` folder alongside Umbraco's own serialized content.

These files should be committed to your repository. Umbraco Deploy will then monitor these files and automatically deploy changes between environments for you.

Learn more about how the deployment process works in the [Umbraco Deploy documentation](https://docs.umbraco.com/umbraco-deploy/).
