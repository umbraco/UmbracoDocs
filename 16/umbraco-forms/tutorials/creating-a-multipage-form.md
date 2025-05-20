# Creating a Multi-Page Form

In this tutorial, you will learn how to create a multi-page form using Umbraco Forms. Multi-page forms are particularly useful when you need to collect detailed information from users in a structured and user-friendly way.

Multi-page forms are ideal for use cases such as event registration, job applications, booking a meeting, and so on.

## Prerequisites

* [Umbraco CMS Installation](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/install)
* [Umbraco Forms Package](../installation/install.md)
* Pre-built Website including a **Document Type** with the **Form Picker** Data Type.

## Log in to the Umbraco Backoffice

1. Log in to the Umbraco backoffice.
2. Go to the **Forms** section.

## Create a New Form

1. Click **+** next to the Forms folder.
2. Select **New Form**.

![New Form Creation](images/create-form.png)

3. Enter a **Name** for the form. For example: _Book a Meeting_.
4. Click **Save**.

## Set up the First Page of the Form

Let us begin by adding some fields to the first page of the form. By default, the **Data Consent** field is already available, and we will call this group **Data Consent**.

To create a new group:

1. Click **Add new group**.
2. **Enter the Name** of the group. For example: _Personal Information_.
3. Click **Add question**.
4. Select **Short answer** as the field type.
5. **Enter a Name** for the field type. For example, _First Name_.
6. Select **Text** as the **Field Type** from the drop-down list.
7. Mark the field as **Mandatory**.
8. Click **Submit**.
9. Click **Save**.

Similarly, you can also add other relevant fields such as last name or email based on your requirements.

For this tutorial, the following fields are added with the respective specifications:

| Field Name    | Data Type    | Field Type |
| ------------- | ------------ | ---------- |
| Surname       | Short answer | text       |
| Age           | Short answer | number     |
| Country       | Short answer | text       |
| Phone number  | Short answer | tel        |
| Email address | Short answer | email      |

If you wish to reorder your fields, click **Reorder**.

![Personal Information Questions on the First Page](images/first-page-of-form.png)

## Create the Second Page

To create a multi-page form, you need to add more pages:

1. Click **Add new page** to create the second page of your form.
2. **Enter a Name** for this page. For example: _Company Information_.
3. Click **Add question**.
4. Select **Short answer** as the field type.
5. **Enter a Name** for the field type. For example, _Company Name_.
6. Provide a **Default Value**. For example, _Enter the name of your company_.
7. Click **Submit**.
8. Click **Save**.

![Default Value displayed](images/company-information.png)

Similarly, you can also add other relevant fields based on your requirements.

### Add Conditional Logic

Umbraco Forms allows you to customize the flow of your multi-page form. You can add conditional logic to control which questions appear based on user inputs.

To add conditions, follow these steps:

1. Click **Add question**.
2. Select **Single choice** as the field type.
3. **Enter a Name** for the field type. For example, _Do you work with Umbraco_.
4.  Enter the **Value** and **Caption** in the **Options** field.

    For this tutorial, the following values are added:

    * Yes
    * No

![Values in the Options Field](images/prevalue-fields.png)

5. Mark the field as **Mandatory**.
6. Click **Submit**.
7. Click **Save**.
8. Repeat steps 1-4 to create a conditional question titled: _If yes, how many years?_
9.  Enter the **Value** and **Caption** in the **Options** field.

    For this tutorial, the following values are added:

    * 1-5 years
    * 5-10 years
    * 10+ years

![Conditional Question Values in the Options Field](images/conditional-question-part-1.png)

10. Enable **Conditions**.
11. Set the parameters for the condition as follows:
    * **Show** this field if **all** of the following match:
    * Question: **Do you work with Umbraco?**
    * Condition: **is**
    * Value: **Yes**

![Values for adding a Condition](images/conditional-question-part-2.png)

12. Click **Submit**.
13. Click **Save**.

![Company information Questions on the Second Page](images/page-2-details.png)

## Create the Final Page

1. Click **Add new page** to create the final page of your form.
2. **Enter a Name** for this page. For example: _Products_.
3. Click **Add question**.
4. Select **Multiple choice** as the field type.
5. **Enter a Name** for the field type. For example, _Select the products you are interested in_.
6.  Enter the **Value** and **Caption** in the **Options** field.

    For this tutorial, the following values are added:

    * Umbraco CMS
    * Umbraco Cloud
    * Umbraco Deploy
    * Umbraco Heartcore
    * Umbraco Forms
    * Umbraco Commerce
    * Umbraco Workflow

![Multiple Values in the Option Field](images/multiple-choice.png)

7. Click **Submit**.
8. Click **Save**.

![Products Selection Question on the Final Page](images/Final-page.png)

## Embed the Form on a Web Page

Once you are satisfied with your multi-page form, it is time to embed it on your website.

To display the form on the website, follow these steps:

1. Go to the **Content** section.
2. Click **+** next to the parent page of the website.
3. Select the Document Type.

![Pick a Document Type](images/pick-document-type.png)

4. **Enter a Name** for the page. For example, _Book a Meeting!_
5. Select the **Book a Meeting** form using the _Form Picker_.
6. Click **Save and Publish**.

![New Page created in the Content Section](images/Form-Content-section.png)

## Customize Form Settings

If you wish to customize the Form Settings, see the [Form Settings](../editor/creating-a-form/form-settings.md) article.

## Rendering the Form on the Frontend

For Umbraco Forms to work correctly, you need to include some client dependencies. For more information, see the [Preparing Your Frontend](../developer/prepping-frontend.md) article.

To render the Form on the frontend, see the [Rendering Forms](../developer/rendering-forms.md) article.

## Testing the Form

1. Go to the **Info** workspace view of the _Book a Meeting!_ page.
2. Click on the Published link in the **Links** section.
3. Fill out the form to see how it functions.
4. Submit the form to ensure it redirects to a Thank You page.
5. Go to the **Forms** section in the Backoffice.
6. Navigate to the **Book a Meeting** Form.
7. Click on the **Entries** tab and verify that the data is captured.

![Form Data in the Entries tab](images/form-data-entry.png)

You have successfully created a multi-page form with conditional logic in Umbraco Forms. By using multi-page forms, you have made complex data entry much simpler and more user-friendly. This not only improves the experience for your users but also makes your forms more efficient and manageable.
