---
meta.Title: "Language Variants in Umbraco"
meta.Description: "Language Variants allow you to vary content by culture, so you can allow a content node to exist in several languages."
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Language Variants

Language Variants allows you to vary content by culture, so you can allow a content node to exist in several languages.

This article will cover the different aspects of enabling and working with language variants on your Umbraco website.

## Contents

* [Video tutorial](#video-tutorial)
* [How to enable Language Variants](#how-to-enable-language-variants)
* [Enabling Language Variants on Document Types](#enabling-language-variants-on-document-types)
* [Working with Language Variants on content](#working-with-language-variants-on-content)
* [Test your language variants](#test-your-language-variants)
* [Control User Group permissions on language variants](#control-user-group-permissions-on-language-variants)
* [Read more](#read-more)

## Video tutorial

<iframe width="800" height="450" title="Language Variants" src="https://www.youtube.com/embed/TWLqt-jVdyQ?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

## How to enable Language Variants

To work with Language Variants you need to have more than one language enabled. This can be done from the `Settings` section:

![Adding a language](images/languages_v10.png)

:::note
You will always have one default language but each language can be set to mandatory.
:::

## Enabling Language Variants on Document Types

Now that there are two languages to vary the content with, it needs to be enabled on the Document Types. To do so:

1. Go to the document type in the **Settings** section.
2. Open the **Permissions** page.
3. Toggle **Allow vary by culture**.
    ![Allowing variance on doc types](images/allow-variance_v10.png)

To allow a property on the Document Type to be varied it will have to be enabled for the property:

![Allowing variance on properties](images/varying-properties_v10.png)

## Working with Language Variants on content

When you return to your content node you will notice two things:

1. At the top of the Content tree there will now be a dropdown so you can show the Content tree in the language of your choice.
2. To the right of the content name there is now a dropdown where you can select a language. You can also open a split view so you can see two languages at once.

    ![Allowing variance on properties](images/varying-content_v10.png)

Each Property Editor that does not allow variants (an Invariant Property) will by default need to be unlocked in order to be edited. The lock exists to make it clear that this change will affect more languages, as the value of the invariant properties are shared between all variants on the website.

![How an invariant property looks when it is locked](images/invariant-property-locked.png)

:::note
Whether or not the lock is enabled on the invarient properties depend on the `AllowEditInvariantFromNonDefault`.

On projects starting on Umbraco 10.2 or later versions the setting is `true` by default. Was the project upgraded to 10.2 or later, the setting will be `false`.

Learn more about the `AllowEditInvariantFromNonDefault` setting in the [Security Settings](../../../Reference/Configuration/SecuritySettings/) article.
:::

To read about how you render variant content in Templates, check out the [rendering content section](../../Design/Rendering-Content/).

## Test your language variants

Culture and hostnames must be added to your language sites before the content can be tested for variants:

1. Right-click the Home node and select **Allow access to assign culture and hostnames...**.

    :::note
    In Umbraco v9, this option is called **Culture and Hostnames**.
    :::
2. Add a specific URL per language and save. For eg: An English language variant with English (United States) as the language can be given a specific URL *<https://yourwebsite.com/en-us>* and a Danish language variant can be given a specific URL *<https://yourwebsite.com/dk>*.

The Info content app should now show specific URLs for your language variants.

## Control User Group permissions on language variants

:::note
This feature is available from Umbraco version 10.2.
:::

When you are working with a multilingual site you might want to control who can edit the different variations of the content on the website.

This can be controlled on a User Group level. All default User Groups, except the Sensitive data group, have access to all languages out of the box.

When "Allow access to all languages" is not checked, languages can be added and/or removed in order to control which variations the users in the User Group have access to.

![Assign access to all or individual languages on th User Group](images/Assign-Access-Languages.png)

:::tip
Even though a the language permissions have been set on a User Group, a user in that group will still be able to view and browse all the language variations in the allowed parts of the Content tree. The permission setting will ensure that only the added languages are editable by users of the User Group.
:::

:::links
## Read more

* [Umbraco 8: Language Variants (official blog post from Umbraco HQ)](https://umbraco.com/blog/umbraco-8-language-variants/)
* [Language variations](../../../Reference/Language-Variation/)
* [Render varied content in Templates](../../Design/Rendering-Content/)
:::
