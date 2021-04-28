---
versionFrom: 8.0.0
---

# Creating Your First Template

Umbraco creates corresponding template when you select the **Document Type with Template** option.

To edit the template:

1. Go to **Settings**.
2. In the **Templating** section, expand the **Templates** folder. You should see a template titled **_HomePage_**.
3. Open the template. It will contain a little bit of **_Razor code_**.
    ![Empty Homepage Template](images/figure-13-empty-homepage-template-v8.png)
4. Leaving the code that's there (if you don't understand it, don't worry!) let's copy our template code in.
    :::note
    We are using files from the Retrospect template here: [https://templated.co/retrospect](https://templated.co/retrospect)
    :::
5. Open the "Retrospect" template folder and copy the contents of **index.html**.
6. Paste the content into the _HomePage_ template below the closing curly brace "}". Your **_Template_** should now look like below:
    ![Homepage Template with Retrospect HTML](images/figure-14-homepage-template-with-Retrospect-html-v8.png)
    :::warning
    Umbraco **_Templates_** use **_Razor_** which allows you to add code in your **_Template_** files. **_Razor_** reacts to `@` signs.
    :::
7. Click **Save**.

We now have a **_Template_**. That's two out of the three stages complete for our first page.

## Creating Your First content node

Our third and final stage to creating our first page in Umbraco, is to create a **_content node_** that uses our **_Document Type_** and **_Template_**, to serve up an HTML page to web visitors.

To add a content node:

1. Go to **Content**.
2. Click the **...** next to the **Content** headline in the tree. Select **HomePage**.
    ![Create a Homepage](images/figure-15-create-a-homepage-v8.png)

    :::tip
    If you cannot see the content node, check that [Settings] > [Document Types] > [HomePage]  > [Structure tab] > [Allow at root] is checked.
    :::
    The Home Page opens in the content editor.
3. Enter the name for the content node.  We're going to call this "Homepage".
    :::tip
    The name will show up in the node list and will be used to create a url for the page. Try to keep it short but descriptive.
    :::
4. Enter the following details:
    <table border="0">
    <col width="130">
    <col width="600">
    <tr><th>Name</th><th>Description</th></tr>
    <tr><td>Page Title:</td><td>Welcome to Widgets Ltd</td></tr>
    <tr><td>Body Text:</td><td>Hello world! We can write what we like here! Widgets Ltd 2019</td></tr>
    <tr><td>Footer Text:</td><td>Copyright Widgets Ltd 2019</td></tr>
    </table>

5. Click **Save and Publish** button. The menu will reload with our homepage node.

Refresh your webpage in your browser http://localhost – the default Umbraco page will be gone and we'll now see a very bare, unstyled page! We’re getting there!

:::tip
If you see a blank page then check if the template is entered and remember to save it.
:::

![An Unstyled Homepage](images/figure-16-unstyled-homepage-v8.png)

---
## Next - [CSS & JavaScript](../CSS-And-JavaScript)

Adding the CSS and JavaScript for your site into Umbraco.
