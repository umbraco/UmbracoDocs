---
description: "Creating an email template for Umbraco Forms."
---

# Email Templates

We include a Workflow **Send email with template (Razor)** that allows you to pick a Razor view file that can be used to send out a _pretty HTML email_ for Form submissions.

## Creating an Email Template

If you wish to have one or more templates to choose from the **Send email with template (Razor)**, you will need to place all email templates into the `~/Views/Partials/Forms/Emails/` folder.

The Razor view must inherit from FormsHtmlModel:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<Umbraco.Forms.Core.Models.FormsHtmlModel>
```

You now have a model that contains your Form fields which can be used in your email HTML markup, along with the UmbracoHelper methods such as `Umbraco.TypedContent` and `Umbraco.TypedMedia` etc.

Below is an example of an email template from the `~/Views/Partials/Forms/Emails/` folder:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<Umbraco.Forms.Core.Models.FormsHtmlModel>

@{
    //This is an example email template where you can use Razor Views to send HTML emails

    //You can use Umbraco.TypedContent & Umbraco.TypedMedia etc to use Images & content from your site
    //directly in your email templates too

    //Strongly Typed
    //@Model.GetValue("aliasFormField")
    //@foreach (var color in Model.GetValues("checkboxField")){}

    //Dynamics
    //@Model.DynamicFields.aliasFormField
    //@foreach(var color in Model.DynamicFields.checkboxField

    //Images need to be absolute - so fetching domain to prefix with images
    var siteDomain = Context.Request.Scheme + "://" + Context.Request.Host;
    var assetUrl = siteDomain + "/App_plugins/UmbracoForms/Assets/Email-Example";

}
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900" rel="stylesheet">
    <style type="text/css">

    /* CLIENT-SPECIFIC STYLES */
    body, table, td, a { -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; }
    table, td { mso-table-lspace: 0pt; mso-table-rspace: 0pt; }
    img { -ms-interpolation-mode: bicubic; }

    /* RESET STYLES */
    img { border: 0; height: auto; line-height: 100%; outline: none; text-decoration: none; }
    table { border-collapse: collapse !important; }
    body { height: 100% !important; margin: 0 !important; padding: 0 !important; width: 100% !important; }

    /* iOS BLUE LINKS */
    a[x-apple-data-detectors] {
        color: inherit !important;
        text-decoration: none !important;
        font-size: inherit !important;
        font-family: inherit !important;
        font-weight: inherit !important;
        line-height: inherit !important;
    }

 /* MOBILE STYLES */
 @@media screen and (max-width:600px){
  h1 {
   font-size: 32px !important;
   line-height: 32px !important;
  }
 }

    /* ANDROID CENTER FIX */
    div[style*="margin: 16px 0;"] { margin: 0 !important; }
    </style>
</head>
<body style="background-color: #f4f4f4; margin: 0 !important; padding: 0 !important;">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-bottom: 40px;">
        <!-- LOGO -->
        <tr>
            <td bgcolor="#413659" align="center">
                <!--[if (gte mso 9)|(IE)]>
                    <table align="center" border="0" cellspacing="0" cellpadding="0" width="600">
                    <tr>
                    <td align="center" valign="top" width="600">
                <![endif]-->
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
                    <tr>
                        <td align="center" valign="top" style="padding: 40px 10px 40px 10px;">
                            <a href="http://umbraco.com" target="_blank">
                                <img alt="Logo" src="@assetUrl/umbraco-logo.png" width="40" height="40" style="display: block; width: 40px; max-width: 40px; min-width: 40px; font-family: 'Lato', Helvetica, Arial, sans-serif; color: #ffffff; font-size: 18px;" border="0">
                            </a>
                        </td>
                    </tr>
                </table>
                <!--[if (gte mso 9)|(IE)]>
                    </td>
                    </tr>
                    </table>
                <![endif]-->
            </td>
        </tr>

        <!-- HERO -->
        <tr>
            <td bgcolor="#413659" align="center" style="padding: 0px 10px 0px 10px;">
                <!--[if (gte mso 9)|(IE)]>
                    <table align="center" border="0" cellspacing="0" cellpadding="0" width="600">
                    <tr>
                    <td align="center" valign="top" width="600">
                <![endif]-->
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
                    <tr>
                        <td bgcolor="#ffffff" align="center" valign="top" style="padding: 40px 20px 20px 20px; color: #000000; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 36px; font-weight: 900; line-height: 48px;">
                            <h1 style="font-size: 36px; font-weight: 900; margin: 0;">Umbraco Forms</h1>
                        </td>
                    </tr>
                </table>
                <!--[if (gte mso 9)|(IE)]>
                    </td>
                    </tr>
                    </table>
                <![endif]-->
            </td>
        </tr>

        <!-- COPY BLOCK -->
        <tr>
            <td bgcolor="#F3F3F5" align="center" style="padding: 0px 10px 0px 10px;">
                <!--[if (gte mso 9)|(IE)]>
                    <table align="center" border="0" cellspacing="0" cellpadding="0" width="600">
                    <tr>
                    <td align="center" valign="top" width="600">
                <![endif]-->
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">

                    <!-- COPY -->
                    <tr>
                        <td bgcolor="#ffffff" align="left" style="padding: 20px 30px 40px 30px; color: #303033; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 1.6em;">
                            This is an example email template from Umbraco Forms Razor based email templates. You can build forms using any HTML markup you wish.
                        </td>
                    </tr>

                    <!-- IMAGE -->
                    <tr>
                        <td bgcolor="#ffffff" align="left" style="padding: 0;">
                            <a href="http://umbraco.com" target="_blank">
                                <img alt="CodeGarden16 Attendees" src="@assetUrl/sample-image.jpg" width="600" style="display: block; width: 100%; max-width: 100%; min-width: 100px;" border="0" />
                            </a>
                        </td>
                    </tr>

                    <!-- COPY HEADING -->
                    <tr>
                        <td bgcolor="#ffffff" align="left" style="padding: 40px 30px 0px 30px; color: #000000; font-family: 'Lato', Helvetica, Arial, sans-serif; line-height: 25px;">
                            <h2 style="font-size: 24px; font-weight: 700; margin: 0;">Form Results</h2>
                        </td>
                    </tr>

                    <!-- COPY -->
                    <tr>
                        <td bgcolor="#ffffff" align="left" style="padding: 20px 30px 40px 30px; color: #303033; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;">

                            @foreach (var field in Model.Fields)
                            {
                                <h4 style="font-weight: 700; margin: 0; color: #000000;">@field.Name</h4>

                                switch (field.FieldType)
                                {
                                    case "FieldType.FileUpload.cshtml":
                                        <p style="margin-top: 0;"><a href="@siteDomain/@field.GetValue()" target="_blank" style="color: #00AEA2;">@field.GetValue()</a></p>
                                        break;

                                    case "FieldType.DatePicker.cshtml":
                                        DateTime dt;
                                        var fieldValue = field.GetValue();
                                        var dateValid = DateTime.TryParse(fieldValue != null ? fieldValue.ToString() : string.Empty, out dt);
                                        var dateStr = dateValid ? dt.ToString("f") : "";
                                        <p style="margin-top: 0;">@dateStr</p>
                                        break;

                                    case "FieldType.CheckBoxList.cshtml":
                                        <p style="margin-top: 0;">
                                            @foreach (var color in field.GetValues())
                                            {
                                                @color<br/>
                                            }
                                        </p>
                                        break;
                                    default:
                                        <p style="margin-top: 0;">@field.GetValue()</p>
                                        break;
                                }
                            }

                        </td>
                    </tr>
                </table>
                <!--[if (gte mso 9)|(IE)]>
                    </td>
                    </tr>
                    </table>
                <![endif]-->
            </td>
        </tr>

        <!-- SUPPORT CALLOUT -->
        <tr>
            <td bgcolor="#F3F3F5" align="center" style="padding: 30px 10px 0px 10px;">
                <!--[if (gte mso 9)|(IE)]>
                    <table align="center" border="0" cellspacing="0" cellpadding="0" width="600">
                    <tr>
                    <td align="center" valign="top" width="600">
                <![endif]-->
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
                    <!-- HEADLINE -->
                    <tr>
                        <td bgcolor="#03BFB3" align="center" style="padding: 30px 30px 30px 30px; color: #ffffff; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;">
                            <h2 style="font-size: 20px; font-weight: 700; color: #ffffff; margin: 0; margin-bottom: 5px;">Need more help?</h2>
                            <p style="margin: 0;"><a href="https://our.umbraco.org/Documentation/Add-ons/UmbracoForms/" target="_blank" style="color: #ffffff;">Find our documentation here</a></p>
                        </td>
                    </tr>
                </table>
                <!--[if (gte mso 9)|(IE)]>
                    </td>
                    </tr>
                    </table>
                <![endif]-->
            </td>
        </tr>

    </table>
</body>
</html>
```
