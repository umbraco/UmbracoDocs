---
versionFrom: 8.0.0
---
# Articles Parent and Article Items - A Parent Page with Infinite Children

Having an Articles Parent page, and a number of associated child articles which the editors can add to freely, provides a good example page of the power of Umbraco. We'll assume our fictional company, Widgets Ltd, write about ten articles a month and want the articles page to act like a blog (e.g. you could use this functionality for a blog or news and events pages).

For this you can create a **Document Type Collection**, go to **_Settings > Document Types > Create > Document Type Collection_** call the Parent Document Type `Articles Main` and the Child one `Articles Item`. 

![Articles Main Document Type Data Properties](images/figure-38a-articles-main-v8.png)

Create the following **_Tabs_** and **_Data Properties_**:

#### Articles Main

>Group = Intro
>**"Articles Title"** - Type = Textbox
>**"Articles Body Text"** - Type = Rich Text Editor**

![Articles Main Document Type Data Properties](images/figure-38-articles-main-v8.png)

#### Articles Item
>Tab = Content
>**"Article Title"** - Type = TextBox
>**"Article Content"** - Type = Rich Text Editor**

![Article Item Document Type Data Properties](images/figure-39-articles-item-v8.png)

Now go to the **_Settings > Document Types >Articles Main node > Permissions screen_** and you will notice that **_Articles Item_** has already been added as an allowed child node, this is because we created it as a Document Collection. 

This allows us to create items under the main (which acts as a parent container). We also need to allow the **_Articles Main node_** to be created under the **_Homepage node_** (do this in the **_Settings > Document Types > Homepage node > Permissions screen >  Allowed child node types_** - don't add the **_Articles Item_** - only the main should be allowed at this level). 

Now go to **_Content > Homepage node (hover)> ..._** and create a node called "_Articles_" of type **_Articles Main_** (if you don't have this option go back and check your allowed child nodes - did you forget to click **_Save_**)?  Give the Articles node some content and a title. 

When you click save you will notice that it has been created as a list view, this means that child nodes are automatically in a list to make it easier to see them, you can create new nodes from this section too, go ahead and create a few.

Now you should have a content tree that looks like the image below (obviously with your own page node names).  Let's go update our templates we just created (automatically when we created the Document Types). First, update them to use the Master as a parent **_Settings > Templates > Articles Main node > Master template_** = "Master" - do the same for the Articles Item remembering to click **_Save_**. 

![Content Tree With Articles](images/figure-40-articles-created-v8.png)

Copy the template content from the **_Simple Content Page_**  template and paste this into both the Articles Item and Articles Main (you may need to refresh the nodes again to see these. Set the Master template to be "Master" and then replace the Page field tags with the relevant  properties e.g. **_articlesTitle_** and **_articlesBodyText_** for the **_Articles Main_** and the **_articleTitle_** and **_articleContent_** for **_Article Item_**. 

:::warn
Take care when copying not to overwrite the first line `@inherits Umbraco.Web.Mvc.UmbracoTemplatePage<ContentModels.ArticlesMain>` - if get an exception when loading the page about not being able to bind to source ensure the last part in < > brackets matches your Document Type Alias. 
:::

If we now go and check our Articles Main page in the browser we should see our content. We'd like to list the child article items under the intro content so that our visitors can see a list of our articles. Umbraco makes this easy for us but we need to use a bit of Razor.

Click on the **_Settings_** menu from the top menu and then hover over the **_Partial View Macros Files node_** to get the more menu **_..._** then click **_New partial view macro from snippet_**. Select the "_List Child Pages Ordered By Date_" and then name it "_listArticles_" and save.

---------------This is currently not working in v8, will have to try again soon

Now all we have to do is wire up the Articles main page to list our child articles. Edit the Articles Main template **_Settings > Templates node > Master node > Articles Main node_**.  Under the *articlesBodyText* tag enter a carriage return and then click the **_Insert Macro_** button, choose the ListArticles macro we just created and then click **_Save_**. 


![Template for Articles Parent with the Macro Code](images/figure-41-articles-parent-with-macro-code.png)


*Figure 41 - Template for Articles Parent with the Macro Code*


Check what we have on our **_Articles_** page now - we're really getting somewhere!  Let's make it a bit more real world - I'll leave the understanding of this to Razor lessons / The Umbraco videos but it will finish our site off nicely - edit the Partial you just created - **_Developer > Partial View Macro Files > listArticles.cshtml_** and change the content to be:


```csharp
@inherits Umbraco.Web.Macros.PartialViewMacroPage
@{ 
    var selection = CurrentPage.Children.Where("Visible").OrderBy("CreateDate desc"); 
    @* OrderBy() takes the property to sort by and optionally order desc/asc *@
}

@foreach (var item in selection)
{
<div class="article">
        <div class="articletitle"><a href="@item.Url">@item.Name</a></div>
        <div class="articlepreview">@Umbraco.Truncate(@item.ArticleContents,100) <a href="@item.Url">Read More..</a></div>
    </div>
    <hr/>
}
```

*Figure 42 - Improved Macro for listArticles*



Now check this in the browser!


![Finished Articles Page](images/figure-43-finished-articles-page.png)


*Figure 43 - Finished Articles Page*


---
## Next - [Adding Language Variants](../Adding-Language-Variants.md)
At this point we have a basic site, but wouldn't it be cool if we could make the same site in another language? Read on to see how easy it is with Language Variants!

