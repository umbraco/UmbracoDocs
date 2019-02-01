---
versionFrom: 8.0.0
---

# Adding Language Variants 

Now that we have a basic site set up, let's explore one of the cool new features brought on in Umbraco v8; Language Variants. For this we will make a Danish version of the `Contact Us` page. At this point your page should look like this:

![Current version of the contact us page](images/current-page.png)

## Adding a new language

So the first thing we should do is go to the **_Settings > Language_** and then click the `Add Language` button at the top. In the dropdown you can select a long list of languages, in this tutorial we will pick Danish.

![Adding the Danish language](images/adding-danish-language.png)

As you can see there are several options, to add a fallback language, make it mandatory and so on, we will just leave it default for now but if you want to ensure all content has a language varied version then make them mandatory.

## Enabling Language Variants on Document Types and Properties

Now head on over to **_Document Types > Simple Content Page > Permissions_** and check the `Allow varying by culture` checkbox, now click save and go to the **_Design_** tab. 

We will now edit the settings of our property editors, so click on the little gear icon ⚙ for the **_Page Title_** editor and again check the `Allow varying by culture` checkbox.

![Allow property editor Language Variants](images/allow-varying-property-editor.png)

For now we will leave the **_Body Text_** property editor unchanged, so click save in the bottom right corner and head on over to **_Content > Contact Us_**. Now there will be a language dropdown next to the title at the top:

![Language Variant dropdown](images/language-dropdown.png)

When you click the dropdown you will get a list of all the languages you have enabled. When you mouseover a language an `Open in Splitview` box will appear, click this to open it.

![Open Language in Splitview](images/open-in-splitview.png)

In this splitview we will be able to see the content node with each language side by side. You may notice that the bodytext is greyed out - this is because we haven't checked the `Allow varying by culture` checkbox for that property editor.

![Splitview editing](images/splitview-editing.png)

You can now click publish at the bottom of the page and it will give you the option to publish one or more languages.

![Publishing Variant content](images/publishing-variant-content.png)

Now if you head on over to your contact us page you will see it looks the same, but if you then access /kotakt-os or whatever you have called the new Language Varied node, then you will see the headline change to what you put in!


## Next - [Conclusions and Where Next?](Conclusions-Where-Next)
By this point you'll have a basic working site - where next?  You've barely scratched the surface of the power of Umbraco!