---
description: >-
  Learn how to use language variants to output your content in multiple
  languages.
---

# Language Variants

Language Variants allows you to vary content by culture, so you can allow a content node to exist in multiple languages.

This article will cover the different aspects of enabling and working with language variants on your Umbraco website.

## Contents

* [Video tutorial](variants.md#video-tutorial)
* [How to enable Language Variants](variants.md#how-to-enable-language-variants)
* [Enabling Language Variants on Document Types](variants.md#enabling-language-variants-on-document-types)
* [Working with Language Variants on content](variants.md#working-with-language-variants-on-content)
* [Test your language variants](variants.md#test-your-language-variants)
* [Control User Group permissions on language variants](variants.md#control-user-group-permissions-on-language-variants)
* [Related Links](variants.md#related-links)

## Video tutorial

{% embed url="https://www.youtube.com/watch?ab_channel=UmbracoLearningBase&v=TWLqt-jVdyQ" %}
How to use Language Variants in Umbraco
{% endembed %}

## How to enable Language Variants

To work with Language Variants you need to have more than one language enabled. This can be done from the `Settings` section:

![Adding a language](../../.gitbook/assets/adding-a-language.png)

{% hint style="info" %}
You will always have one default language but each language can be set to mandatory.
{% endhint %}

## Enabling Language Variants on Document Types

Now that there are two languages to vary the content with, it needs to be enabled on the Document Types. To do so:

1. Go to the Document Type in the **structure** section.
2. Open the **settings** page.
3.  Toggle **Allow vary by culture**.

    <figure><img src="../../.gitbook/assets/allow-variance2.png" alt=""><figcaption></figcaption></figure>

To allow a property on the Document Type to be varied it will have to be enabled for the property:

![Allowing Variance on properties](../../.gitbook/assets/varying-properties.png)

## Working with Language Variants on content

When you return to your content node you will notice two things:

1. At the top of the Content tree there will now be a dropdown so you can show the Content tree in the language of your choice.
2.  To the right of the content name there is now a dropdown where you can select a language. You can also open a split view so you can see two languages at once.

    ![Allowing Variance on properties](../../.gitbook/assets/Allowing-Variance-on-properties.png)

To read about how you render variant content in Templates, check out the [rendering content section](../design/rendering-content.md).

## Test your language variants

Culture and hostnames must be added to your language sites before the content can be tested for variants:

1. Click **...** next to the Home node and select **Culture and Hostnames**.
2. Add a specific URL per language and save. For eg: An English language variant with English (United States) as the language can be given a specific URL `https://yourwebsite.com/en-us` and a Danish language variant can be given a specific URL `https://yourwebsite.com/dk`.

The Info content app should now show specific URLs for your language variants.

## Control User Group permissions on language variants

{% hint style="info" %}
This feature is available from Umbraco version 10.2.
{% endhint %}

When you are working with a multilingual site you might want to control who can edit the different variations of the content on the website.

This can be controlled on a User Group level. All default User Groups, except the Sensitive data group, have access to all languages out of the box.

When "Allow access to all languages" is not checked, languages can be added and/or removed. This is to determine which variants the users in the user group have access to.

![Assign access to all or individual languages on the User Group](../../.gitbook/assets/Assign-Access-Languages.png)

{% hint style="info" %}
Even though the language permissions have been set, a user will still be able to view and browse all the language variations. The permission setting will ensure that only the added languages are editable by users of the User Group.
{% endhint %}

## Related Links

* [Umbraco 8: Language Variants (official blog post from Umbraco HQ)](https://umbraco.com/blog/umbraco-8-language-variants/)
* [Language variations](../../reference/language-variation.md)
* [Render varied content in Templates](../design/rendering-content.md)
