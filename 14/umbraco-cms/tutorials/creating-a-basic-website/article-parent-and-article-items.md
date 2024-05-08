# Articles and Article Items

Having an Articles Parent page, and a number of associated child articles, provides a good example of Umbraco's features. We'll assume our fictional company, Widgets Ltd, writes about ten articles a month and want the articles page to act like a blog. You could use this functionality for news, event pages, or any other collection of Document Types.

## Creating Articles and Article Items

Create two new Document Types with template: **Articles Main** and **Articles Item**.

To create **Articles Main** Document Type, follow these steps:

1. Go to **Settings**.
2. Click **...** next to the **Document Types** in the **Settings** tree.
3. Select **Create...**.
4. Select **Document Type with Template**.
5. Enter a **Name** for the **Document Type**. Let's call it _Articles Main_.
6. Let's add two fields with the following specifications:

    | Group | Field Name         | Alias            | Data Type        |
    | ----- | ------------------ | ---------------- | ---------------- |
    | Intro | Articles Title     | articlesTitle    | Textstring       |
    | Intro | Articles Body Text | articlesBodyText | Rich Text Editor |

    ![Articles Main Document Type Data Properties](images/articles-main.png)
7. Click **Save**

To create **Articles Item** Document Type, follow these steps:

1. Go to **Settings**.
2. Click **...** next to the **Document Types** in the **Settings** tree.
3. Select **Create...**.
4. Select **Document Type with Template**.
5. Enter a **Name** for the **Document Type**. Let's call it _Articles Item_.
6. Let's add two fields with the following specifications:

    | Group   | Field Name      | Alias          | Data Type        |
    | ------- | --------------- | -------------- | ---------------- |
    | Content | Article Title   | articleTitle   | Textstring       |
    | Content | Article Content | articleContent | Rich Text Editor |

    ![Article Item Document Type Data Properties](images/articles-item.png)
7. Click **Save**

### Updating the Document Type Permissions

To add **Articles Main** as a child node:

1. Navigate to the **Home Page** Document Type.
2. Go to the **Structure** tab.
3. Select **Choose** in the **Allowed child node types**.
4. Select **Articles Main**.
5. Click **Choose**.
6. Click **Save**.

To update **Articles Main** Document Type permissions:

1. Navigate to the **Articles Main** Document Type.
2. Go to the **Structure** tab.
3. Select **Choose** in the **Allowed child node types**.
4. Select **Articles Item**.
5. Click **Choose**.

    ![Adding child Node](images/adding-child-node.png)

6. Click **Configure as a collection**.
7. Select **List View - Content**.
8. Click **Save**.

    ![Enabling List View](images/list-view-enabled.png)

## Creating the Content Node

To add a content node:

1. Go to **Content**.
2. Select **...** next to the **HomePage** node.
3. Click **Create**.
4. Select **Articles Main**.
5. Enter the name for the article. We are going to call it _Articles_.
6. Enter the content in the **Article Title** and **Article Body Text** fields.
7. Click **Save and Publish**. When you click on Save and Publish, you will notice an empty list view is created.

    We still need to add the child nodes which will be displayed in the list view making it easier to view them. You can create new nodes from this section.

    {% hint style="info" %}
    If you do not see the list view, try refreshing the page.
    {% endhint %}

8. Click **Create Articles Item**.
9. Enter the name for the article. We are going to call it _Article 1_.
10. Enter the content in the **Article Title** and **Article Content** fields.
11. Repeat steps 8 to 10 to create _Article 2_.
12. Click **Save and Publish**.

    ![Content Tree with Articles](images/figure-40-articles-created-v8.png)

## Updating the Template

To update the **Articles Item** template, follow these steps:

1. Go to **Settings**.
2. Expand the **Templates** folder in the **Templating** section.
3. Open the **Articles Main** template.
4. Select **Master** in the **Master template:No Master** field.
5. Click **Choose**.
6. Click **Save**.
7. Open the **Custom Umbraco Template** folder.
8. Copy the contents of **Blog.html**.
9. Paste the content into **Articles Main** below the closing curly brace "}".
10. Remove everything from the `<html>` (around line 8) to the end of the `</div>` tag (around line 43) which is the `header` and `navigation` of the site since it is already mentioned in the Master template.
11. Remove everything from the `<!-- Footer -->` tag (around line 83) to the end of the `</html>` tag (around line 130)
12. Replace the static text within the `<h1>` tags (around line 12) with the Model.Value reference to _**articlesTitle**_.
13. Replace the static text within the `<div>` tags (from line 23 to 29) with the Model.Value reference to _**articlesBodyText**_.

    ![Articles Main Template](images/articles-main-template.png)

14. Define a query for all articles below the `<h3>` tag (around line 30) of the `<!-- Latest blog posts -->` section.

    ![Query Builder](images/query-builder.png)

15. You can set conditions to get specific articles or decide the order of the articles. For the purpose of this guide, we are using the following parameters:

    ![Query parameters](images/query-parameters-v14.png)

16. If you've set the correct parameters, you will get a preview of the items being selected with the query.
17. Click **Submit**.
18. You will see a similar code snippet added to your template:

    ```html
   @{
        var selection = Umbraco.Content(Guid.Parse("56aa9cc5-243b-4947-8fb1-37b209b97373"))
        .ChildrenOfType("articlesItem")
        .Where(x => x.IsVisible())
        .OrderByDescending(x => x.CreateDate);
    }
    <ul>
        @foreach (var item in selection)
        {
            <li>
                <a href="@item.Url()">@item.Name()</a>
            </li>
        }
</ul>
    ```

19. The above code will output a list of all the _**Article Items**_ as links using the name.
20. We will modify the template a little, to add more information about the articles.
21. Replace the `HTML` in the _foreach_ loop with this snippet:

    ```csharp
    <article class="special">
        <div class="articledate" > @item.CreateDate </div>
        <div class="articletitle"><a href="@item.Url()">@item.Name()</a></div>
        <div class="articlepreview">@Html.Truncate(item.Value("articleContent").ToString(), 20, true)<a href="@item.Url()">Read More..</a></div>
    </article>
    ```

22. Click **Save**.

To update the **Articles Item** template, follow these steps:

1. Go to **Settings**.
2. Expand the **Templates** folder in the **Templating** section.
3. Open the **Articles Item** template.
4. Select **Master** in the **Master template:No master** field.
5. Click **Choose**.
6. Click **Save**.
7. Open the **Custom Umbraco Template** folder.
8. Copy the contents of **Blogpost.html**.
9. Paste the content into **Articles Item** below the closing curly brace "}".
10. Remove everything from the `<html>` (around line 8) to the end of the `</div>` tag (around line 43) which is the `header` and `navigation` of the site since it is already mentioned in the Master template.
11. Remove everything from the `<!-- Footer -->` tag (around line 113) to the end of the `</html>` tag (around line 160)
12. Replace the static text within the `<h1>` tags (around line 13) with the Model.Value reference to _**articleTitle**_.
13. Replace the static text within the `<div>` tags (from line 25 to 39) with the Model.Value reference to _**articleContent**_.

    ![Articles Item Template](images/articles-item-template-v9.png)
14. Click **Save**.

Check your browser, you should now see something similar to the screen below.

![Finished Articles section](images/article-main-frontend-v14.png)
