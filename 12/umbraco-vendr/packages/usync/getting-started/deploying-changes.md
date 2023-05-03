---
title: Deploying Changes
description: Configuring Umbraco for Vendr uSync, an add-on package for Vendr, the eCommerce solution for Umbraco v8+
---

## Serializing Settings

After installing Vendr uSync, it will automatically install the Vendr serializers into the uSync config and start serializing any changes made in the Vendr settings section to disk in the `uSync` folder alongside other uSync serialized content. These files should be committed to your repository and transferred between environments.

Depending how you have uSync configured to perform imports, importing may occur either automatically or require a manual import step.

## Reviewing Changes

To review any changes awaiting importing, from within the **Settings > uSync** section, under the **Report** button, you can click the **Report Vendr Settings** link to run a full uSync report.

![Report Changes Menu Option](../media/usync/report.png)

![Report Changes](../media/usync/vendr_usync_report.png)

## Importing Changes

To import changes, from within the **Settings > uSync** section, under the **Import** button, you can click the **Import Vendr Settings** link to run a full uSync import.

![Import Menu Option](../media/usync/import.png)

![Imported Report](../media/usync/vendr_usync_imported.png)