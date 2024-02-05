# Displaying the Document Type Properties

You might have noticed that the content we've added to the homepage is not being displayed. We need to wire up the Data Type properties to the template.

Let’s look at our template and identify where the content should be displayed.

![Where our Data Properties Content Should be Output](images/figure-17-where-our-data-fields-go-v8.png)

The top arrow in this image is the _Page Title_ and the bottom arrow is the _Body Text_, whereas the Footer is all the way at the bottom.

## Setting the Document Type Properties

To set the Document Type properties:

1. Go to **Settings**.
2. Select **Templates** in the **Templating** section, and open the **Homepage** template.
3.  Scroll down to the `<!-- Jumbotron, w title -->` section (around line 46) and highlight the text `“Welcome - UmbracoTV”` (around line 49).\\

    <figure><img src="images/figure-18-replace-hardcoded-text-with-umbraco-page-field-v9 (1) (1) (2).png" alt=""><figcaption></figcaption></figure>
4. Click **Insert** and select **Value**.
5.  Select **pageTitle** field from the drop-down list.\\

    <figure><img src="images/figure-19-umbraco-page-field-v9.png" alt=""><figcaption></figcaption></figure>
6. Click **Submit**.
7. Repeat the same process for the content between the `<div class="container">` tags (around line 61 to 78):
   *   Highlight the content as shown in the figure.\\

       <figure><img src="images/figure-20-replace-bodytext-with-page-field-v9.png" alt=""><figcaption></figcaption></figure>
   * Click **Insert** and select **Value**.
   * Select **bodyText** field from the drop-down list.
   * Click **Submit**.
8. Repeat the same process for the content in the `<div class="container-fluid footer">` tag (around line 149 to 182):
   *   Highlight the content between the `<div class="container">` tags.

       <figure><img src="images/figure-21-footer-text-v9.png" alt=""><figcaption></figcaption></figure>
   * Click **Insert** and select **Value**.
   * Select **footerText** field from the drop-down list.
   * Click **Submit**.
9. Click **Save**.

Reload your homepage to view the content. You should see something similar like the image below:

<figure><img src="images/figure-22-displaying-document-type-properties.png" alt=""><figcaption></figcaption></figure>

Now, you can go back and add additional fields or update existing fields in the Document Type, fill them out in the content node and then add them in the template to display the data in the website.
