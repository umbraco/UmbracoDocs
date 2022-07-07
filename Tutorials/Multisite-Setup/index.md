---
versionFrom: 8.0.0
versionTo: 10.0.0
meta.Title: "Multisite setup in Umbraco"
product: "CMS"
meta.Description: "A guide to multisite setup in Umbraco"
---

# Multisite setup

This tutorial explains how to host multiple sites from one project/installation of Umbraco.
For practical reasons, we recommend using [Baselines](../../Umbraco-Cloud/Getting-Started/Baselines/) on Umbraco Cloud projects.

:::tip
When using Baselines on Umbraco Cloud for a multisite solution, you would not need to worry about [Usage](../../Umbraco-Cloud/Set-up/Usage/) limits, and could see better performance compared to having multiple websites in one project.
:::

If you are planning to create a multilingual site in Umbraco 8, please take a look at the [Multilanguage Setup](../Multilanguage-Setup/) tutorial instead.

## Structuring your website

The best way to handle a multisite solution is to have multiple root nodes in the Content section, where each root node would act as a separate website.

Keep in mind all the websites in your solution will be using the same schema - meaning, in most cases, your content pages on website A will be using the same properties as on website B.

:::note
If your site is hosted on Umbraco Cloud, you will need to map your sites' hostnames to the project.

Before you can map your hostnames to individual websites in the solution, you should add them in the Hostnames page on the Cloud portal to ensure they are secured with TLS.
:::

![Adding hostnames to the project](images/1-addinghostnames.png)

Keep in mind the [hostnames have to be configured in a specific way.](../../Umbraco-Cloud/Set-Up/Manage-Hostnames/).

## Mapping the hostnames to individual websites/root nodes

At this point you should have several root nodes, where each is a separate website. To map the hostnames to individual root nodes:

1. Go to the **Content** section in the backoffice of your site.
2. Right-click on the content node you wish to assign the hostname to.
3. Select **Allow access to assign culture and hostnames** option.

    :::note
    In Umbraco 9 and below, this option is called **Culture and Hostnames**.
    :::

    ![Culture and hostnames](images/2-culturehostnames-v10.png)

4. In the **Domains** pane, click **Add new Domain**.
5. Enter the domain in the **Domain** field and select the language from the **Language** drop-down list.

    :::tip
    If  you have a multilanguage solution, you can map different hostnames to specific languages.
    :::

    ![Culture and hostnames](images/3-culturehostnamesp2-v10.png)

6. Click Save, and that should do it!

The sites you have should now be available under the hostnames you provided.

![Dolphin site](images/6-dolphins.png)
![SWATO site](images/7-swato.png)

## Best practices

While such a setup might be handy, it also comes with drawbacks.
It is important to keep in mind that having multiple sites on one Umbraco project:

- Might increase resource usage.
- Could interfere with editors' workflows, especially if there are multiple people working on both websites at once. That is because the solution will still use one database for both websites.
- Limit your options in regards to developing new features and making schema changes.

On Umbraco Cloud-hosted sites we recommend using the [Baseline](../../Umbraco-Cloud/Getting-Started/Baselines/) functionality - which comes with added benefits, and offers increased stability compared to the multisite solution in a single project.
