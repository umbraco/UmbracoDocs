# Creating a Form - The Basics

In this article, we'll take a look at the basic steps of creating a Form and adding the Form to your Umbraco site.

## Accessing the Forms Section

You can manage the Forms in the **Forms** section of the Umbraco backoffice. You need to have access to the section in order to see it.

If you do not see the **Forms** section, you might need to request access from the site Administrator. An Administrator can give permission to view the **Forms** section. This is done from within the **Users** section of the backoffice.

![Forms Section](<images/FormsSectionV9 (1).png>)

## Creating a Form

To create a Form, follow these steps:

1. Navigate to the **Forms** section.
2.  Click **...** next to the Forms folder.

    ![Forms tree](<images/FormsTree (1).png>)
3.  The **Create a new Form** dialog opens.

    ![Forms create dialog](<images/FormsCreateDialogV9 (1).png>)
4.  Select **Empty Form**. The Form Designer opens in the editor.

    ![Forms designer](<images/FormDesignerStartV8 (1).png>)
5. By default, there is a page, a fieldset, and a container available. The rest of the Form has to be added using the interface.
6.  Enter the **Name** for the Form. Let's call it _Our first form_.

    <figure><img src="images/FormDesignerFormNameV8.png" alt=""><figcaption></figcaption></figure>
7.  **\[Optional]** Enter the **Page Name**. We'll call it _The first page_. Click **Add new page** at the bottom of the Forms designer to add more pages.

    <figure><img src="images/FormDesignerPageCaptionV8 (1).png" alt=""><figcaption></figcaption></figure>
8.  **\[Optional]** Enter the **Group Name**. Click **Add new group** to add another group.

    <figure><img src="images/FormDesignerPageGroupV8 (1).png" alt=""><figcaption></figcaption></figure>
9.  Click the **Add Question** button to add a new field.

    <figure><img src="images/FormDesignerAddFieldV8 (1).png" alt=""><figcaption></figcaption></figure>
10. The **Add Question** dialog opens.

    ![Forms add field dialog](<images/FormDesignerAddFieldDialogV8 (1).png>)
11. Enter the following details:

    | Field Name         | Value                |
    | ------------------ | -------------------- |
    | Enter question     | Name                 |
    | Enter help text    | Enter your name here |
    | Choose answer type | Short answer         |
12. In the **Sensitive data** field, choose if the field stores sensitive data. Once selected, the data from this field will be prevented from being downloaded and viewed by users who do not have permission to do so. Only members of the sensitive data user group will see this option of downloading.
13. Enter a **Default Value** for the field.
14. Add a **Placeholder** to make it easier for the user to fill in the Form.
15. Select if the field is **Mandatory** and customize the message.
16. Add a **Validation** to the field. There are some predefined validations available but it is possible to add your own custom validation as well.
17. Some form fields allow you to show or hide the label that's associated with the field when it is rendered within the form on the website. The default is always to show the field, but if you prefer to hide it, untick the **Show label** option.
18. Set **Conditions** for the field. For more information on Conditions, see the [Setting-up conditional logic on fields](conditional-logic.md) article.

    Some of the additional settings are dependent on which answer type was chosen. For example, since we selected _Short Answer_ as our answer type we got two additional settings (Default Value and Placeholder).
19. Once the configuration is completed, click **Submit**. You will see that the field has been added to the Form designer.

    <figure><img src="images/FormDesignerFieldAddedV8 (1).png" alt=""><figcaption></figcaption></figure>

To edit a field that has already been added to the Form, click the little **cog** icon next to the field to open the dialog. To delete a field or a group, click the **Recycle Bin** icon.

### Structuring the Form

#### Ordering Fields

Once you've added a few fields to your Form, you might want to change the order of questions. To do so, click **Reorder** in the top-right corner of the Form designer.

<figure><img src="images/Reorder_Form (1).png" alt=""><figcaption></figcaption></figure>

When reordering your Form, you can drag and drop the fields to make it look the way you want. Click **I am done reordering** to get back to the Form designer.

<figure><img src="images/Reorder_Form_1 (1).png" alt=""><figcaption></figcaption></figure>

#### Form Pages

Forms can be grouped into pages. When rendered, each page will be presented one at a time to the user. They will need to complete the first page before moving onto the second and can navigate back and forth between pages.

You can add a new page directly to the bottom of the form via the **Add new page** button. This will appear below other pages when at least one exists.

### Form Groups

With a page, form fields can be arranged into groups. These will display all together on a single page but can be styled so the fields are appropriately grouped in fieldsets.

New groups are added via the **Add new group** button.

## Form Columns

The last level of structure are columns that can be created within a group. To set the number of columns click the **cog** icon next to the group. You will then be able to add or move fields to the new columns created.

## Saving the Form

Once you are satisfied with the Form, you can save the design by clicking the **Save** button.

## Organizing Forms in Folders

If installation of the product is configured for storage of form definitions in the database, you will have the option to store forms within folders. If you are planning to create a number of them, this may help with organization and locating them once created for modification.

To create a folder, access the same dialog used for creating a form. Here, you'll have the option to create a folder, for which you need to provide a name.

You can create folders within folders, rename, move and delete them. You also have the ability to move or copy forms into folders, all via the tree operations available from the **...** menu.

![Form save Form](<images/FormDesignerSaveV8 (1).png>)

## Adding the Form to the Umbraco site

To add the Form, follow these steps:

1. Navigate to the **Content** section of the Umbraco Backoffice.
2.  Select the content page where you want to insert the Form. The page you choose should either have an Rich Text Editor (RTE) field, a Grid Editor, or a form picker all of which you can add in the **Settings** section under **Document Types**.

    ![Content page](<images/ContentExamples (1).png>)
3. Click the **Insert macro** button in the toolbar of the RTE or Grid. The **Select Macro** dialog opens.
4.  Click **Add** under **Choose a Form** and select the Form you want to insert. You will be able to select from the full list of forms. If available on your installation, you will also be able to select using a folder based view, which can be quicker to navigate when many forms have been prepared.

    ![Content page add macro](<images/ContentPageAddMacroDialog (1).png>)
5. **\[Optional]** Click **Add** under **Theme** to choose which theme the Form should use.
6. Finally you have an option to **Exclude Scripts**.
7. Click **Submit**.
8.  The Form is inserted on to your page. Click the **Save and publish** button.

    ![Content page with form](<images/ContentExamplesWithForm (1).png>)
