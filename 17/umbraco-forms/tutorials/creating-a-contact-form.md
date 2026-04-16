# Creating a Contact Form

In this tutorial, we'll look at creating a Contact Form using Umbraco Forms. It will take you through the process of creating a Contact Form and cover all the different components involved in building the form.

You can use a Contact Form on your website to allow a visitors to send you a message. Having a Contact Form on your website allows you to keep track of potential customer queries and possibly generate leads via email communication.

## Video Tutorial

{% embed url="https://www.youtube-nocookie.com/embed/l0X9DOwd6zk" %}
Creating a Contact Us Form using Umbraco Forms
{% endembed %}

## Step 1: Configure the Document Types

The first step in this tutorial is to configure the Document Types that will be used to show the Contact Form on your website.

### Creating a Composition

We'll start off by creating a Composition. A Composition is a stand-alone Document Type, that you can reuse on other Document Types. By creating a Composition, we are not duplicating the same properties on multiple Document Types. This is helpful when we want to use the same set of properties on multiple Document Types.

To create a Composition, follow these steps:

1. Go to **Settings** in the Umbraco Backoffice.
2. Expand the **Document Types** folder in the **Settings** tree.
3. Select **...** next to the **Compositions** folder.
4. Click **Create**.
5. Select **Document Type**.
6. Enter a **Name** for the **Composition**- let's call it _Title Box_.
7.  Add the following fields with the respective specifications:

    | Group     | Field Name | Alias    | Data Type  |
    | --------- | ---------- | -------- | ---------- |
    | Title Box | Title      | title    | Textstring |
    | Title Box | Subtitle   | subtitle | Textarea   |
8.  Click **Save** to save the Composition.

    ![Add Composition Properties](../.gitbook/assets/composition-properties-v14.png)

### Creating a Contact Us Document Type with Template

Next, we will create a Document type with template. A Document Type contains different properties for holding different types of content. The Document Type we create here will be the one used for creating the content page that will hold our Contact Form.

To create a **Contact Us** Document Type, follow these steps:

1. Go to **Settings** in the Umbraco Backoffice.
2. Select **...** next to the **Document Types** folder.
3. Click **Create**.
4. Select **Document Type with Template**.
5. Enter a **Name** for the **Document Type**- let's call it _Contact Us_.
6. Select **Compositions** in the top-right corner.
7. Select **Title Box**.
8. Click **Submit**.
9.  Add the following fields with the respective specifications:

    | Group   | Field Name   | Alias       | Data Type       |
    | ------- | ------------ | ----------- | --------------- |
    | Form    | Contact Form | contactForm | Form Picker     |
    | Content | Body Text    | bodyText    | Richtext Editor |
10. Click **Save**.

    ![Contact Us Document Type Properties](../.gitbook/assets/contact-us-doc-type-properties-v14.png)

### Updating the Document Type Permission

In the following we will update the Document Type permissions to specifically add child nodes under the root content node.

To update the **Contact Us** Document Type permissions, follow these steps:

1. Navigate to the Document Type used for the root content node on your website, in this case **Home** page.
2. Go to the **Structure** tab.
3. Select **Choose** in the **Allowed child node types** section.
4.  Select the **Contact Us** page.

    ![Update Home Page Document Type Properties](../.gitbook/assets/update-doc-type-permissions-v14.png)
5. Click **Choose**.
6. Click **Save**.

## Step 2: Prepare the Content Node

This step takes you through creating the content node for your Contact Form. The content node uses the Document Type and Template to serve up an HTML page to web visitors.

To add the content node, follow these steps:

1. Go to **Content** in the Umbraco Backoffice.
2. Select **...** next to the **Home Page**.
3. Click **Create**.
4. Select **Contact Us**.
5. Enter the name for the content node. let's call it _Contact Us_.
6.  Enter a **Title**, **Subtitle**, and **Body Text** value. These can always be updated at a later point.

    ![Enter values in Contact Us Content node](../.gitbook/assets/fill-contact-us-node-v14.png)
7. Click **Save** or **Save and Publish**.

## Step 3: Creating the Contact Form

In this step, we will create the Contact Form using Umbraco Forms.

To create a form, follow these steps:

1. Go to the **Forms** section in the Umbraco Backoffice.
2. Click **...** next to the Forms folder.
3. Click Create.
4. Select **New Form...**.
5. Enter a **Name** for the Form. Let's call it _Contact Us_.
6. _\[Optional]_ Enter a **Page Name** and **Group Name** for the Data Consent statement. Let's call it _Data Consent_.
7. Click **Add new group**. Let's call it _Information_.
8. Select **Add Question** to add a new field.
9.  Enter the following details:

    | Field Name         | Value        |
    | ------------------ | ------------ |
    | Enter question     | **Name**     |
    | Alias              | fullName     |
    | Choose answer type | Short answer |
    | Field Type         | text         |
    | Mandatory          | On           |
10. Click **Submit**.
11. Repeat **steps 8-10** to add the following fields:

    | Field Name         | Value            |
    | ------------------ | ---------------- |
    | Enter question     | **Company Name** |
    | Choose answer type | Short answer     |

    | Field Name         | Value                          |
    | ------------------ | ------------------------------ |
    | Enter question     | **How should we contact you?** |
    | Choose answer type | Single choice                  |
    | Prevalues Items    | phone, email                   |
    | Mandatory          | On                             |

    | Field Name         | Value                       |
    | ------------------ | --------------------------- |
    | Enter question     | **Enter your phone number** |
    | Choose answer type | Short answer                |
    | Field Type         | tel                         |
    | Validation         | Validate as a number        |
12. Enable **Conditions** in the _Enter your phone number_ field.
13. Click **Add Condition**.
14. Select **How should we contact you?** from the dropwdown.
15. Select **phone** in the value field.
16. Click **Submit**.
17. Repeat **steps 8-10** to add the following field:

    | Field Name         | Value                        |
    | ------------------ | ---------------------------- |
    | Enter question     | **Enter your email address** |
    | Choose answer type | Short answer                 |
    | Field Type         | email                        |
    | Validation         | Validate as an email address |
18. Enable **Conditions** in the _Enter your email address_ field.
19. Click **Add Condition**.
20. Select **How should we contact you?** from the dropwdown.
21. Select **email** in the value field.
22. Click **Submit**.
23. Repeat **steps 8-10** to add the following field:

    | Field Name         | Value                                                    |
    | ------------------ | -------------------------------------------------------- |
    | Enter question     | **What is your role?**                                   |
    | Choose answer type | Dropdown                                                 |
    | Prevalues Items    | manager, developer, tester, writer, marketing specialist |

    | Field Name                    | Value                    |
    | ----------------------------- | ------------------------ |
    | Enter question                | **Attachments (if any)** |
    | Choose answer type            | File upload              |
    | Predefined allowed file types | pdf, png, jpg, gif, txt  |

    | Field Name         | Value                |
    | ------------------ | -------------------- |
    | Enter question     | **Are you a Robot?** |
    | Choose answer type | reCAPTCHAv2          |
    | Theme              | light                |
    | Size               | normal               |
    | Mandatory          | On                   |

    ![Add questions](../.gitbook/assets/contact-us-form-add-questions-v14.png)
24. Select the **Reorder** option.
25. Drag the **Data consent** group below the **Information** group.
26. Click **I am done reordering**.
27. Click **Save**.

### Configuring the Form Workflow

Workflows is how you determine what you happen after your form is submitted. It could be actions like sending an email or displaying a "Thank You" message.

To configure the Form workflow, follow these steps:

1. Select the **Submit message/ Go to page** options in the bottom of the Forms editor.
2. Enter a customised message in the **Message on Submit** field.
3. Click **Submit**.
4. Click on **Send template email to xxx@xx.dk**.
5. Enter an email address in the **Sender Email** field.
6. By default, the **Example-Template.cshtml** template will be selected in the **Email template** field.
7. Enable **Attach Uploaded Files**.
8. Click **Submit**.
9. Click **Save**.

### Configuring the Form Settings

In this step, you will find the information about accessing the Forms Settings and the validations available to customise your form.

To configure the form settings, follow these steps:

1. Navigate to the **Settings** tab in the Forms editor.
2. Scroll to find the **Validation** section.
3. Ensure that the **Mark Mandatory fields** option is checked under **Mark fields**.
4. Click **Save**.

{% hint style="info" %}
There are multiple settings that be configured. These are all optional in relation to this tutorial.
{% endhint %}

## Step 4: Adding the Contact Form to the Content Node

Now that you have created your Contact Form, you can add it in the Contact Us Content Node using the _Form Picke_ Data Type.

To add the Contact Form to the Content Node, follow these steps:

1. Go to the **Content** section in the Umbraco Backoffice.
2. Open the **Contact Us** Page.
3. Select **Choose** in the **Contact Form** field.
4. Select the **Insert Form with Theme** option.
5. Select the **Contact Us** Form.
6.  Click **Choose**.

    ![Adding the Contact Us Form](../.gitbook/assets/select-form-v14.png)
7. Click **Save** or **Save and Publish**.

## Step 5: Additional configuration

In the next couple of steps, we will add some additional configuration required in order for our form to work properly.

### Configuring the reCAPTCHA value

You need to update the configuration to include a value in the `appsettings.json` file.

To configure the reCAPTCHA value, see the [reCAPTCHA configuration](../developer/configuration/#recaptcha-v2-field-type-configuration) article.

### Configuring Simple Mail Transfer Protocol (SMTP)

By adding the SMTP settings in the `appsettings.json` file, you can send out emails from your Umbraco installation. It is required in order for your form to be able to send emails on submission.

To configure the SMTP settings, see the [Global Settings](https://docs.umbraco.com/umbraco-cms/reference/configuration/globalsettings#smtp-settings) article.

## Step 6: Rendering the Contact Form

In this step, we will render the values of the Contact Us Document Type in the template.

To render the Contact Form, follow these steps:

1. Go to the **Settings** section in the Umbraco Backoffice.
2. Open the **Contact Us** template in the **Templates** folder.
3.  Enter the following code to render the form:

    ```cs
    @using Umbraco.Forms.Web.Helpers;
    @await Component.InvokeAsync("RenderForm", new { formId = Guid.Parse("<form guid>"), FormTheme = "bootstrap3-horizontal", ExcludeScripts = "1" })
    ```

{% hint style="info" %}
```
Replace **<form guid>** with the ID of your form. You can find the ID in the Form's **Info** tab.
```
{% endhint %}

4. Select **Insert**.
5. Click **Value**.
6. Select **Document Type** from the **Choose field** dropdown.
7. Select **Contact Us**.
8. Click **Choose**.
9. Select **bodyText** from the **Contact Us** dropdown.
10. Click **Submit**.
11. Click **Save**.

{% hint style="info" %}
For Umbraco Forms to work correctly, you need to include some client dependencies. For more information, see the [Preparing Your Frontend](../developer/prepping-frontend.md) article.
{% endhint %}

## The final result

Finally, it is time to view the Contact Form on the frontend.

To view the Contact Form on the Frontend, follow these steps:

1. Go to the **Content** section in the Umbraco Backoffice.
2. Open the **Contact Us** Page.
3. Ensure that the page is published.
4. Go to the **Info** tab.
5. Click on the Published link in the **Links** section.

You now have a full-fledged Contact Form ready to be used on your website.
