---
meta.Title: "Language Variants in Umbraco"
meta.Description: "Language Variants allow you to vary content by culture, so you can allow a content node to exist in several languages."
versionFrom: 8.0.0
---

# Language Variants

Language Variants is a new feature included in Umbraco 8. It allows you to vary content by culture, so you can allow a content node to exist in several languages.

## Video tutorial

<iframe width="800" height="450" src="https://www.youtube.com/embed/-vzxCdjq4FM?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

## How to enable Language Variants

The first thing to ensure when you want to work with Language Variants is that you have more than one language enabled, this can be done from the `Settings` section:

![Adding a language](images/languages.png)

Note that you will always have one default language but each language can be set to mandatory if you want.

## Enabling Language Variants on doctypes

Now that there are two languages to vary the content with, it needs to be enabled on the document types you wish to use it with. To do so head to a document type in the Settings section. In the top right corner you can go to permissions and then check the "Allow varying by culture" toggle:

![Allowing variance on doc types](images/allow-variance.png)

Now to allow a property on the doctype to be varied it will have to be enabled for the property:

![Allowing variance on properties](images/varying-properties.png)

## Working with Language Variants on content

When you return to your content node you will notice two things.

1. At the top of the content tree there will now be a dropdown so you can show the content tree in the language of your choice.
2. To the right of the content name there is now a dropdown where you can select a language. You can also open a split view so you can see two languages at once.

![Allowing variance on properties](images/varying-content.png)

Each property editor that does not allow variants will be greyed out and have the content of the default language.

To read about how you render variant content in templates, check out the [rendering content section](../../Design/Rendering-Content/).

## Test your language variants

Culture and hostnames must be added to your language sites before the content can be tested for variants.

1. Right-click the Home node and select Culture and Hostnames.
2. Add a specific url per language and save. For eg: An English language variant with English (United States) as the language can be given a specific url *https://yourwebsite.com/en-us* and a Danish language variant can be given a specific url *https://yourwebsite.com/dk*.
3. The Info content app should now show specific urls for your language variants.

## Read more

- [Umbraco 8: Language Variants (official blog post from Umbraco HQ)](https://umbraco.com/blog/umbraco-8-language-variants/)
