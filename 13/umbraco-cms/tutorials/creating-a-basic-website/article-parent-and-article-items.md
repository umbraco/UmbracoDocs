# Articles and Article Items

Having an Articles Parent page, and a number of associated child articles, provides a good example of Umbraco's features. We'll assume our fictional company, Widgets Ltd, writes about ten articles a month and want the articles page to act like a blog. You could use this functionality for news, event pages, or any other collection of Document Types.

## Creating Articles and Article Items

Create two new Document Types with template: **Articles Main** and **Articles Item**.

To create **Articles Main** Document Type, follow these steps:

1. Go to **Settings**.
2. Select **...** next to the **Document Types** in the **Settings** tree.
3.  Click **Document Type with Template**.

    ![Document Type with template](images/Document_type_with_template.png)
4. Enter a **Name** for the **Document Type**. Let's call it _Articles Main_.
5.  Let's add two fields with the following specifications:

    | Group | Field Name         | Alias            | Data Type        |
    | ----- | ------------------ | ---------------- | ---------------- |
    | Intro | Articles Title     | articlesTitle    | Textstring       |
    | Intro | Articles Body Text | articlesBodyText | Rich Text Editor |

    ![Articles Main Document Type Data Properties](images/figure-38-articles-main-v11.png)
6. Click **Save**

To create **Articles Item** Document Type, follow these steps:

1. Go to **Settings**.
2. Select **...** next to the **Document Types** in the **Settings** tree.
3.  Click **Document Type with Template**.

    ![Document Type with template](images/Document_type_with_template.png)
4. Enter a **Name** for the **Document Type**. Let's call it _Articles Item_.
5.  Let's add two fields with the following specifications:

    | Group   | Field Name      | Alias          | Data Type        |
    | ------- | --------------- | -------------- | ---------------- |
    | Content | Article Title   | articleTitle   | Textstring       |
    | Content | Article Content | articleContent | Rich Text Editor |

    ![Article Item Document Type Data Properties](images/figure-39-articles-item-v11.png)
6. Click **Save**

### Updating the Document Type Permissions

To update **Articles Main** Document Type permissions:

1. Navigate to the **Home Page** Document Type and go to the **Permissions** tab.
2. Select **Add child** in the **Allowed child node types**. The **Choose child node** window opens.
3. Select **Articles Main** and click **Save**.
4. Navigate to the **Articles Main** Document Type and go to the **List View** tab.
5.  Toggle **Enable List view** and click **Save**.

    ![Enabling List View](images/figure-44-list-view-enabled.png)

To update **Articles Item** Document Type permissions:

1. Navigate to the **Articles Main** Document Type and go to the **Permissions** tab.
2. Select **Add child** in the **Allowed child node types**. The **Choose child node** window opens.
3. Select **Articles Item** and click **Save**.

## Creating the Content Node

To add a content node:

1. Go to **Content**.
2. Select **...** next to the **HomePage** and select **Articles Main**.
3. Enter the name for the article. We are going to call it _Articles_.
4.  Enter the **Article Title**, **Article Content**, and click **Save and Publish**. When you click on Save and Publish, you will notice an empty list view is created.

    We still need to add the child nodes which will be displayed in the list view making it easier to view them. You can create new nodes from this section.

    {% hint style="info" %}
    If you do not see the list view, try refreshing the page.
    {% endhint %}

5\. Click \*\*Create Articles Item\*\* to add two child nodes called \*\*Article 1\*\*, \*\*Article 2\*\*, and click \*\*Save and Publish\*\*.

<figure><img src="images/figure-40-articles-created-v8.png" alt=""><figcaption><p>Content Tree with Articles</p></figcaption></figure>

## Updating the Template

To update the **Articles Item** template, follow these steps:

1. Go to **Settings**.
2. Expand the **Templates** folder in the **Templating** section. You should see a template titled _**Articles Main**_.
3. Select **Master** in the **Master template** and click **Save**.
4. Open the **Custom Umbraco Template** folder.
5. Copy the contents of **Blog.html** and paste the content into **Articles Main** below the closing curly brace "}".
   * Take care when pasting the template not to overwrite the first line `@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ContentModels.ArticlesMain>`. If you get an error when loading the page ensure the last part in <> brackets matches your Document Type alias.
6. Remove everything from the `<html>` (around line 9) to the end of the `</div>` tag (around line 44) which is the `header` and `navigation` of the site since it is already mentioned in the master template.
7. Remove everything from the `<!-- Footer -->` tag (around line 84) to the end of the `</html>` tag (around line 131)
8. Replace the static text within the `<h1>` tags (around line 13) with the Model.Value reference to _**articlesTitle**_.
9.  Replace the static text within the `<div>` tags (from line 24 to 30) with the Model.Value reference to _**articlesBodyText**_.

    ![Articles Main Template](images/articles-main-template-v9.png)
10. Define a query for all articles below the `<h3>` tag (around line 32) of the `<!-- Latest blog posts -->` section.

    ![Query Builder](images/query-builder-v9.png)
11. You can set conditions to get specific articles or decide the order of the articles. For the purpose of this guide, we'll use the following parameters:

    ![Query parameters](images/query-parameters.png)
12. If you've set the correct parameters, you will get a preview of the items being selected with the query. Click **Submit**, and you will see a code snippet has been added to your template. It will look similar to this:

    ```html
    @{ var selection =
    Umbraco.Content(Guid.Parse("e0a4f1ff-122e-41bd-941c-f9686f03019f"))
    .ChildrenOfType("articlesItem") .Where(x => x.IsVisible())
    .OrderByDescending(x => x.CreateDate); }
    <ul>
        @foreach (var item in selection) {
        <li>
            <a href="@item.Url()">@item.Name()</a>
        </li>
        }
    </ul>
    ```
13. The above code will output a list of all the _**Article Items**_ as links using the name. We will modify the template a little, to add more information about the articles. Replace the `HTML` in the _foreach_ loop with this snippet:

    ```csharp
    <article class="special">
        <div class="articledate" > @item.CreateDate </div>
        <div class="articletitle"><a href="@item.Url()">@item.Name()</a></div>
        <div class="articlepreview">@Html.Truncate(item.Value("articleContent").ToString(), 20, true)<a href="@item.Url()">Read More..</a></div>
    </article>
    ```
14. Click **Save**.

To update the **Articles Item** template, follow these steps:

1. Go to **Settings**.
2. Expand the **Templates** folder in the **Templating** section. You should see a template titled _**Articles Item**_.
3. Select **Master** in the **Master template** and click **Save**.
4. Open the **Custom Umbraco Template** folder.
5. Copy the contents of **Blogpost.html** and paste the content into **Articles Item** below the closing curly brace "}".
   * Take care when pasting the template not to overwrite the first line `@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ContentModels.ArticlesItem>`. If you get an error when loading the page ensure the last part in <> brackets matches your Document Type alias.
6. Remove everything from the `<html>` (around line 9) to the end of the `</div>` tag (around line 44) which is the `header` and `navigation` of the site since it is already mentioned in the master template.
7. Remove everything from the `<!-- Footer -->` tag (around line 114) to the end of the `</html>` tag (around line 161)
8. Replace the static text within the `<h1>` tags (around line 14) with the Model.Value reference to _**articleTitle**_.
9.  Replace the static text within the `<div>` tags (from line 26 to 41) with the Model.Value reference to _**articleContent**_.

    ![Articles Item Template](images/articles-item-template-v9.png)
10. Click **Save**.

Check your browser, you should now see something similar to the screen below.

![Finished Articles section](images/article-main-frontend.png)
