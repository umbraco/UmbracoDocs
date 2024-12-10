---
description: Learn how to create custom templates for emails, prints, and exports.
---

# Customizing Templates

Umbraco Commerce provides support for customizing templates for emails, prints, and exports. This allows you to tailor the outputs of your e-commerce solution to meet specific branding or functional requirements.

## Accessing the Default Built-in Templates

The default templates for email, print, and export are embedded in Razor Class Libraries (RCLs) in Umbraco Commerce. To customize these templates, you can extract them and use them as a starting point.

Download the custom templates and place them in `/Views/Partials/Commerce/Email/`.

{% file src="../.gitbook/assets/Umbraco.Commerce.Templates.v13.zip" %}
Umbraco Commerce Custom Templates
{% endfile %}

## Creating Custom Templates

### Email Templates

To Create a Custom Email Template:

1. Create a Razor view file (`.cshtml`) in `/Views/Partials/Commerce/Email/.`
2. Implement the `IEmailTemplate` interface to make the template available in Umbraco Commerce:

```csharp
using Umbraco.Commerce.Core.Interfaces;  

public class CustomOrderEmailTemplate : IEmailTemplate  
{  
    public virtual string FileName => "CustomOrderEmail.cshtml";  
}  

```

3. Register the Template in a Composer:

```csharp
using Umbraco.Cms.Core.Composing;  
using Umbraco.Cms.Core.DependencyInjection;  

public class CustomTemplateComposer : IComposer  
{  
    public void Compose(IUmbracoBuilder builder)  
    {  
        builder.EmailTemplates().Add<CustomOrderEmailTemplate>();  
    }  
}  

```

### Print and Export Templates

To create Print/Export Templates:

1. Create a Razor view file (`.cshtml`) under the relevant paths:

```
/Views/Partials/Commerce/Prints/  
/Views/Partials/Commerce/Exports/  
```

2. Implement the `IPrintTemplate` or `IExportTemplate` interface to make the template available in Umbraco Commerce.
3. Register the template in a Composer similar to the email template process.

## Shipping Custom Templates in a Razor Class Library

To distribute custom templates as part of a Razor Class Library (RCL):

1. Create a new Razor Class Library project.
2. Add the template files under appropriate paths, for example, `Views/Partials/Commerce/Emails/`.
3. Implement interfaces like `IEmailTemplate,` `IPrintTemplate,`or `IExportTemplate` .
4. Use a composer to register your custom templates.
