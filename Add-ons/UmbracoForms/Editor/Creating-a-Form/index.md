---
versionFrom: 8.0.0
versionTo: 9.0.0
---

# Creating a Form

In this section, we'll take a look at the basic steps of creating a Form and adding the Form to your Umbraco site.

## Accessing the Forms Section

You can manage Forms in the **Forms** section of the Umbraco backoffice. You need to have access to the section in order to see it.

If you do not see it, you will need to either log in with an Administrator account or request access from someone with Administrator permissions for your site. An Administrator can give permission to view the Forms section to your individual account or the user group your account belongs to from within the Users section of the backoffice.

![Forms Section](images/FormsSectionV9.png)

## Create a Form

To create a Form, follow these steps:

1. Navigate to the **Forms** section.
2. Click **...** next to the Forms folder.

    ![Forms tree](images/FormsTree.png)
3. The **Create a new Form** dialog opens.

    ![Forms create dialog](images/FormsCreateDialogV9.png)
4. Select **Empty Form**. The Form Designer opens in the editor.

    ![Forms designer](images/FormDesignerStartV8.png)
5. By default, there is a page, a fieldset, and a container available. The rest of the form has to be added using the interface.

    :::note
    In Umbraco Forms version 7 or higher, unless the feature has been disabled via configuration, there will be a predefined *Consent for storing submitted data* field added to all new forms.
    See this blog post for more details: [Umbraco version 7.9 and Forms 7.0](https://umbraco.com/blog/umbraco-version-79-and-forms-70-is-out/)
    :::

6. Enter the **Name** for the Form. Let's call it _Our first form_.
    ![Forms designer Set Name](images/FormDesignerFormNameV8.png)
7. [Optional] Enter the **Page Name**. We'll call it _The first page_. Click **Add new page** at the bottom of the Forms designer to add more pages.
    ![Forms designer page caption](images/FormDesignerPageCaptionV8.png)
8. [Optional] Enter the **Group Name**. Click **Add new group** to add another group.
    ![Forms designer page caption](images/FormDesignerPageGroupV8.png).
9. Click the **Add Question** button to add a new field.
    ![Forms designer add field](images/FormDesignerAddFieldV8.png)
10. The Add Question dialog opens.

    ![Forms add field dialog](images/FormDesignerAddFieldDialogV8.png)
11. Enter the following details:
    | Field Name | Value |
    |-|-|
    | Enter question | Name |
    | Enter help text | Enter your name here |
    | Choose answer type | Short answer |

12. In the **Sensitive data** field, choose if the field stores sensitive data. Once selected, the data from this field will be prevented from being downloaded and viewed by users who do not have permission to do so. Only members of the sensitive data user group will see this option.
13. Enter a **Default Value** for the field.
14. Add a **Placeholder** to make it easier for the user to fill in the form.
15. Select if the field is **Mandatory** and customize the message.
16. Add a **Validation** to the field. There are some predefined validation available but it is possible to add your own custom validation as well.
17. Set **Conditions** for the field. For more information on Conditions, see the [Setting up conditional logic on fields](Conditional-Logic) article.

    Some of the additional settings are dependent on which answer type was chosen. For example, since we selected *Short Answer* as our answer type we got two additional settings (Default Value and Placeholder).
18. Once the configuration is completed, click **Submit**. You will see that the field has been added to the Form designer.
    ![Forms field added](images/FormDesignerFieldAddedV8.png)

To edit a field that has already been added to the form, click the little **cog** icon next to the field to open the dialog. To delete a field or a group, click the **Recycle Bin** icon.

### Structure the Form

Once you've added a few fields to your Form, you might want to change the order of questions. To do so, click **Reorder** in the top-right corner of the form designer.
![Reorder Form](images/Reorder_Form.png)

When reordering your form, you can drag and drop the fields to make it look the way you want. Click **I am done reordering** to get back to the form designer.
![Reorder Form](images/Reorder_Form_1.png)

## Saving the form

Once you are satisfied with the form, you can save the design by clicking the **Save** button.

![Form save form](images/FormDesignerSaveV8.png)

## Adding the form to the Umbraco site

### Select a page

1. Navigate to the **Content** section of the Umbraco Backoffice.
2. Select the content page where you want to insert the form. The page you choose should either have an RTE field, a Grid Editor, or a form picker all of which you can add in the **Settings** section under **Document Types**.
    ![Content page](images/ContentExamples.png)

### Add Form macro

1. Click the **Insert macro** button in the toolbar of the RTE or Grid. The **Select Macro** dialog opens.
2. Click **Add** under **Choose a Form** and select the form you want to insert
    ![Content page add macro](images/ContentPageAddMacroDialog.png)
3. [Optional] Click **Add** under **Theme** to choose which theme the form should use
4. Finally you have an option to **Exclude Scripts**
5. Click **Submit**.
6. The form is inserted on to your page. Click the **Save and publish** button.
    ![Content page with form](images/ContentExamplesWithForm.png)
