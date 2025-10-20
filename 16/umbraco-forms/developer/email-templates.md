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

	//You can use Umbraco.Content & Umbraco.Media etc to use Images & content from your site
	//directly in your email templates too

	//Strongly Typed
	//@Model.GetValue("aliasFormField")
	//@foreach (var color in Model.GetValues("checkboxField")){}


    //Images need to be absolute - so fetching domain to prefix with images
    var siteDomain = Context.Request.Scheme + "://" + Context.Request.Host;
    var assetUrl = siteDomain + "/App_Plugins/UmbracoForms/assets/Email-Example";

}
<!DOCTYPE html>
<html>
<head>
	<title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<style type="text/css">

		/* CLIENT-SPECIFIC STYLES */
		body, table, td, a {
			-webkit-text-size-adjust: 100%;
			-ms-text-size-adjust: 100%;
		}

		table, td {
			mso-table-lspace: 0pt;
			mso-table-rspace: 0pt;
		}

		img {
			-ms-interpolation-mode: bicubic;
		}

		/* RESET STYLES */
		img {
			border: 0;
			height: auto;
			line-height: 100%;
			outline: none;
			text-decoration: none;
		}

		table {
			border-collapse: collapse !important;
		}

		body {
			height: 100% !important;
			margin: 0 !important;
			padding: 0 !important;
			width: 100% !important;
		}

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
		@@media screen and (max-width:600px) {
			h1 {
				font-size: 32px !important;
				line-height: 32px !important;
			}
		}

		/* ANDROID CENTER FIX */
		div[style*="margin: 16px 0;"] {
			margin: 0 !important;
		}
	</style>
</head>
<body style="background-color: #f4f4f4; margin: 0 !important; padding: 0 !important;">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<!-- HERO -->
		<tr>
			<td align="center" style="padding: 40px 10px 0px 10px;">
				<!--[if (gte mso 9)|(IE)]>
					<table align="center" border="0" cellspacing="0" cellpadding="0" width="600">
					<tr>
					<td align="center" valign="top" width="600">
				<![endif]-->
				<table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
					<tr>
						<td bgcolor="#ffffff" align="center" valign="top" style="padding: 40px 20px 20px 20px; color: #000000; font-family: Helvetica, Arial, sans-serif; font-size: 36px; font-weight: 900; line-height: 48px;">
							<h1 style="font-size: 36px; font-weight: 900; margin: 0;">Submission for @Model.FormName</h1>
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
			<td bgcolor="#F3F3F5" align="center" style="padding: 0px 10px 40px 10px;">
				<!--[if (gte mso 9)|(IE)]>
					<table align="center" border="0" cellspacing="0" cellpadding="0" width="600">
					<tr>
					<td align="center" valign="top" width="600">
				<![endif]-->
				<table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
					<!-- HEADER COPY -->
					@if (Model.HeaderHtml is not null)
					{
						<tr>
							<td bgcolor="#ffffff" align="left" style="padding: 20px 30px 40px 30px; color: #303033; font-family: Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 1.6em;">
								@Model.HeaderHtml
							</td>
						</tr>
					}

					<!-- BODY COPY -->
					@if (Model.BodyHtml is not null)
					{
						<tr>
							<td bgcolor="#ffffff" align="left" style="padding: 20px 30px 40px 30px; color: #303033; font-family: Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 1.6em;">
								@Model.BodyHtml
							</td>
						</tr>
					}

					<!-- FORM FIELDS HEADING -->
					<tr>
						<td bgcolor="#ffffff" align="left" style="padding: 40px 30px 0px 30px; color: #000000; font-family: Helvetica, Arial, sans-serif; line-height: 25px;">
							<h2 style="font-size: 24px; font-weight: 700; margin: 0;">Form Results</h2>
						</td>
					</tr>

					<!-- FORM FIELDS -->
					<tr>
						<td bgcolor="#ffffff" align="left" style="padding: 20px 30px 40px 30px; color: #303033; font-family: Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;">

							@{
								string[] ignoreFields = new string[]
								{
									"FieldType.Recaptcha2.cshtml",
									"FieldType.Recaptcha3.cshtml",
									"FieldType.RichText.cshtml",
									"FieldType.Text.cshtml"
								};
							}

							@foreach (var field in Model.Fields.Where(x => ignoreFields.Contains(x.FieldType) == false))
							{
								<h4 style="font-weight: 700; margin: 0; color: #000000;">@field.Name</h4>

								<p style="margin-top: 0;">
									@switch (field.FieldType)
									{
										case "FieldType.FileUpload.cshtml":
											var uploadCount = 0;
											foreach (var fileUploadValue in field.GetValues())
											{
												if (fileUploadValue != null && !string.IsNullOrEmpty(fileUploadValue.ToString()))
												{
													uploadCount++;
												}
											}

											if (uploadCount > 0)
											{
												<span>@uploadCount file@(uploadCount == 1 ? string.Empty : "s") uploaded</span>
											}

											break;

										case "FieldType.DatePicker.cshtml":
											var datePickerValue = field.GetValue();
											if (datePickerValue != null && !string.IsNullOrEmpty(datePickerValue.ToString()))
											{
												DateTime dt;
												var dateValid = DateTime.TryParse(datePickerValue != null ? datePickerValue.ToString() : string.Empty, out dt);
												var dateStr = dateValid ? dt.ToString("f") : "";
												@dateStr
											}
											break;

										default:
											var values = field.GetValues();
											if (values != null)
											{
												foreach (var value in values)
												{
													if (value != null)
													{
														@(value is string strValue ? strValue.ApplyPrevalueCaptions(field.Id, Model.PrevalueMaps) : value)
								
														<br />
													}
												}
											}
											break;
									}
								</p>
							}

						</td>
					</tr>

					<!-- FOOTER COPY -->
					@if (Model.FooterHtml is not null)
					{
						<tr>
							<td bgcolor="#ffffff" align="left" style="padding: 20px 30px 40px 30px; color: #303033; font-family: Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 1.6em;">
								@Model.FooterHtml
							</td>
						</tr>
					}
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
