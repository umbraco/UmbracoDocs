# Document Types

The first step in any Umbraco site is to create a **Document Type**. A **Document Type** is a data container in Umbraco where you can add **Properties** (data fields/attributes) to input data. Each **Property** has a **Data Type** like text string, number, or rich text body. Umbraco outputs the input data using **Templates**.

These are some of the most common properties you would add to a **Document Type**:

* Page title
* Sub Heading
* Body Text
* Meta Title
* Meta Description

## Creating a Document Type

To create a Document Type:

1. Go to **Settings**.
2.  Select **...** next to the **Document Types** in the **Settings** tree.

    ![Creating a Document Type](images/figure-7-creating-a-document-type-v8.png)
3. Select **Document Type with Template**.
   * Using folders can help you organise your **Document Types**.
4. Enter a **Name** for the **Document Type**. Let's call it _HomePage_. You'll notice that an **Alias** is automatically created.
   * The alias of the Document Type is automatically generated based on the property name. If you want to change the auto-generated alias, click the "lock" icon. The alias must be in camel case. For example: _homePage_.
5. Enter the **Description**. For example: _This is our homepage template_. The description helps to identify the correct **Document Type** when creating new **Content Nodes** in the **Content Section**.
6.  Click **Save**. Our new Document Type is now visible as a new item under **Document Types**.

    ![Saving a Document Type](images/figure-7-saving-a-document-type-v11.png)

## Customizing the Document Type

### Adding icons

With the help of icons, you can identify different Document Types in the **Content Tree**. To add an icon:

1.  Select the icon placeholder next to the document name. The **Select Icon** dialog appears on the right-side of the website.

    ![Selecting an icon](images/figure-9-adding-an-icon-to-document-type-v11.png)
2. Browse through the icon list and select the icon of your choice.
3. Click **Submit**.

### Setting Permissions

To create a Document Type at the root of the **Content Tree**:

1.  Go to the **Structure** tab.

    ![Allow Document Type as root](images/figure-9a-allow-document-type-as-root-v8.png)
2. Toggle the **Allow as root** or **Allow at root** button.
   * If your **Document Types** do not have the **Allow as root** checked, you will not be able to create any content on your site.
3. Click **Save**.

### Adding Properties

To add properties to your Document Type, follow these steps:

1. Go to the **Design** tab.
2.  Select **Add Group** and enter a name for the group. For this tutorial, we will call it _Content_.

    ![Adding a Group](images/figure-10-document-types-adding-groups-v11.png)
3. Select **Add property**. The **Property Settings** dialog opens.
4. Enter a **Name**. For example: _Page Title_.
5.  Enter a **Description**. For example: _The main title of the page (Welcome to Widgets Ltd.)_.

    ![Adding a property](images/figure-11-creating-our-pagetitle-property-v11.png)
6.  Select **Select Editor** and select the Data Type of your choice. We'll add _text_ in the search box and select the **Textstring** Data Type.

    ![Selecting a Data Type](images/figure-11a-selecting-textstring-data-type-v11.png)
7. Click **Submit**.
   * Remember to come back and explore the list of _**Data Types**_ later.
8.  Repeat Steps 3 to 7 using the specification below:

    | Name        | Body Text                     |
    | ----------- | ----------------------------- |
    | Group       | Content                       |
    | Alias       | bodyText                      |
    | Description | The main content of the page. |
    | Data Type   | Richtext Editor               |
9.  Select **Add Group** to create a new group called Footer. Repeat Steps 3 to 7 using the specification below:

    | Name        | Footer Text                      |
    | ----------- | -------------------------------- |
    | Group       | Footer                           |
    | Alias       | footerText                       |
    | Description | Copyright notice for the footer. |
    | Data Type   | Textstring                       |
10. Your Document Type should now look like this:

    ![Home Page with Properties](images/figure-12-homepage-document-type-with-properties-v11.png)
11. Click **Save**.

We’ve now created our first **Document Type**. Umbraco takes the data from an instance of the _**Document Type**_ (also called as _**Content Node**_). This data is then merged with a _**Template**_ – let's create our template next.
