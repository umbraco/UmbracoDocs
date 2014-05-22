#Articles Parent and Article Items - A Parent Page with Infinite Children

Having an Articles Parent page and a number of associated child articles which the editors can add to freely provides a good example page of the power of Umbraco. We'll assume our fictional company, Widgets Ltd, write about ten articles a month and want the articles page to act like a blog (e.g. you could use this functionality for a blog or news and events pages).


Create two new Document Types "_Articles Home_" and "_Articles Item_" **_Document Types Settings > Document Types (hover) > ... > + Create_**. Remember to leave **_Master Document Type_** = "_none.._". 


Create the following **_Tabs_** and **_Data Properties_**:
####Articles Main
>Tab = Intro


>**"Articles Title"** - Type = Textstring


>**"Articles Body Text"** - type = Rich Text Editor**


![Articles Main Document Type Data Properties](images/figure-38-articles-main.png?raw=true)


*Figure 38 - Articles Main Document Type Data Properties*


####Articles Item
>Tab = Contents


>**"Article Title"** - Type = Textstring


>**"Article Contents"** - type = Rich Text Editor**


![Article Item Document Type Data Properties](images/figure-39-articles-item.png?raw=true)


*Figure 39 - Article Item Document Type Data Properties*


Now go to the **_Settings > Document Types >Articles Main node > Structure tab > Allowed child nodetypes_** and check the **_Articles Item_**. This allows us to create items under the main (which acts as a parent container). We also need to allow the **_Articles Main node_** to be created under the **_Homepage node_** (do this in the **_Settings > Document Types > Homepage node > Structure tab > Allowed child nodetypes_** - don't check the **_Articles Item_** - only the main should be at this level). 


Now go to **_Content > Homepage node (hover)> ..._** and create a node called "_Articles_" of type **_Articles Main_** (if you don't have this option go back and check your allowed child nodes - did you forget to click **_Save_**)?  Give the Articles node some content and a title and then create a couple of article item content nodes under this node (**_Content > Homepage node > Articles node (hover) >  ..._** 


Now you should have a content tree that looks like the image below (obviously with your own page node names).  Let's go update our templates we just created (automatically when we created the Document Types). First update them to use the Master as a parent **_Settings > Templates > Articles Main node > Properties tab > Master template dropdown_** = "Master" - do the same for the Articles Item remembering to click **_Save_**. 


![Content Tree With Articles](images/figure-40-articles-created.png?raw=true)


*Figure 40 - Content Tree With Articles*


Copy the template content from the **_Simple Content Page_**  template and paste this into each (clicking **_Save_**).  Then replace the Page fields with the relevant e.g. **_articlesTitle_** and **_articlesBodyText_** for the **_Articles Main_** and the **_articleTitle_** and **_articleContents_** for **_Article Item_**. 


If we now go and check our Articles Main page in the browser we should see our content. Now we need to list the children under this so that we can see a list of our articles. Umbraco makes this easy for us but we need to use a bit of Razor.


Click on the **_Developer_** menu from the left hand side menu and then hover over the **_Partial View Macros Files node_** to get the more menu **_..._** then **_click + Create_**. Name this "_listArticles_" and select the "_List Child Pages Ordered By Date_" in the **_Choose a snippet_** field and click **_Create_**.


![Template for Articles Parent with the Macro Code](images/figure-41-articles-parent-with-macro-code.png?raw=true)


*Figure 41 - Template for Articles Parent with the Macro Code*


Now all we have to do is wire up the Articles main page to list our child articles. Edit the Articles Main template **_Settings > Templates node > Master node > Articles Main node > Template tab_**.  Under the paragraph tags enter a carriage return and then click the **_Insert Macro_** button  then click **_Save_**. 


Check what we have on our **_Articles_** page now - we're really getting somewhere!  Let's make it a bit more real world - I'll leave the understanding of this to Razor lessons / The Umbraco videos but it will finish our site off nicely - edit the Partial you just created - **_Developer > Partial View Macro Files > listArticles.cshtml_** and change the content to be:


	@inherits Umbraco.Web.Macros.PartialViewMacroPage

	@* OrderBy() takes the property to sort by and optionally order desc/asc *@
	
    @foreach (var page in CurrentPage.Children.Where("Visible").OrderBy("CreateDate desc"))
    { 
		<div class="article">
        	<div class="articletitle"><a href="@page.Url">@page.Name</a></div>
			<div class="articlepreview">@Umbraco.Truncate(@page.ArticleContents,100) <a href="@page.Url">Read More..</a></div>
		</div>
		<hr/>
    }

*Figure 42 - Improved Macro for listArticles*



Now check this in the browser!


![Finished Articles Page](images/figure-43-finished-articles-page.png?raw=true)


*Figure 43 - Finished Articles Page*


---
##Next - [Conclusions and Where Next?](Conclusions-Where-Next.md)
By this point you'll have a basic working site - where next?  You've barely scratched the surface of the power of Umbraco!

