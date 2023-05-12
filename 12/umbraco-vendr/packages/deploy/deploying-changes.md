---
title: Deploying Changes
description: Configuring Umbraco for Vendr Deploy, an add-on package for Vendr, the eCommerce solution for Umbraco v8+
---

After installing Vendr Deploy, it will automatically serialize any changes made in the Vendr settings section to disk in the `data\revision` folder alongside Umbraco's own serialized content. These files should be committed to your repository. Umbraco Deploy will then monitor these files and automatically deploy changes between environments for you.
