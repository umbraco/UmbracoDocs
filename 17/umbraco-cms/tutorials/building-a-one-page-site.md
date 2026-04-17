---
description: >-
  Learn how to build a one-page website in Umbraco 17 using a Document Type,
  a Template, and section-based anchor navigation.
---

# Building a One-Page Site

This tutorial shows you how to build a one-page site in Umbraco 17. A one-page site presents all content on a single HTML page. Visitors navigate between sections using anchor links in the navigation.

The site you build in this tutorial includes four sections:

* **Hero** — a full-width banner with a title, subtitle, and image.
* **About** — a text section with a heading and a rich text body.
* **Services** — a list of services managed with the Block List Editor.
* **Contact** — a heading and an email address.

Each section maps to a group of properties on the Document Type. The Template renders all sections in sequence with anchor link navigation.

## Prerequisites

Before you start, make sure you have:

* A running Umbraco 17 installation. See the [Installation](../fundamentals/setup/install/README.md) documentation for details.
* Basic familiarity with Document Types and Templates. See the [Creating a Basic Website](creating-a-basic-website/README.md) tutorial for an introduction.

## Step 1: Create the Service Item Element Type

The Services section uses the Block List Editor. The Block List Editor requires an Element Type to define each service item.

1. Go to the **Settings** section.
2. Select **Create** > **Element Type** from the **...** menu next to **Document Types**.
3. Name the Element Type `Service Item`.
4. Add a group named `Content`.
5. Add the following properties:

| Property name | Property Editor |
|---------------|-----------------|
| Title         | Textstring      |
| Description   | Textarea        |

6. Click **Save**.

## Step 2: Create the Document Type

The Document Type defines the properties editors use to manage content for each section.

1. Go to **Settings** > **Document Types**.
2. Select **Create** > **Document Type with Template** from the **...** menu.
3. Name the Document Type `One-Page Site`.
4. Open the **Permissions** tab and toggle **Allow as root**.
5. Click **Save**.

### Add the Hero group

1. Add a group named `Hero`.
2. Add the following properties:

| Property name | Property Editor |
|---------------|-----------------|
| Hero Title    | Textstring      |
| Hero Subtitle | Textstring      |
| Hero Image    | Media Picker    |

### Add the About group

1. Add a group named `About`.
2. Add the following properties:

| Property name | Property Editor  |
|---------------|------------------|
| About Heading | Textstring       |
| About Text    | Rich Text Editor |

### Add the Services group

1. Add a group named `Services`.
2. Add the following properties:

| Property name    | Property Editor |
|------------------|-----------------|
| Services Heading | Textstring      |
| Services Items   | Block List      |

3. Configure the Block List to allow **Service Item** blocks.

### Add the Contact group

1. Add a group named `Contact`.
2. Add the following properties:

| Property name   | Property Editor |
|-----------------|-----------------|
| Contact Heading | Textstring      |
| Contact Email   | Textstring      |

3. Click **Save**.

## Step 3: Build the Template

Umbraco created a Template named **One-Page Site** when you saved the Document Type. Open the Template and replace its content with the following:

1. Go to **Settings** > **Templates**.
2. Open **One-Page Site**.
3. Replace the existing code with the template below.
4. Click **Save**.

{% code title="OnepageSite.cshtml" %}
```cshtml
@using Umbraco.Cms.Core.Models.Blocks
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@{
    Layout = null;
    var services = Model.Value<BlockListModel>("servicesItems");
}
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>@Model.Name</title>
    <link rel="stylesheet" href="/css/styles.css" />
</head>
<body>

    <nav>
        <ul>
            <li><a href="#hero">Home</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#services">Services</a></li>
            <li><a href="#contact">Contact</a></li>
        </ul>
    </nav>

    <!-- Hero section -->
    <section id="hero">
        <h1>@Model.Value("heroTitle")</h1>
        <p>@Model.Value("heroSubtitle")</p>
        @{
            var heroImage = Model.Value<IPublishedContent>("heroImage");
        }
        @if (heroImage != null)
        {
            <img src="@heroImage.Url()" alt="@Model.Value("heroTitle")" />
        }
    </section>

    <!-- About section -->
    <section id="about">
        <h2>@Model.Value("aboutHeading")</h2>
        <div>@Html.Raw(Model.Value("aboutText"))</div>
    </section>

    <!-- Services section -->
    <section id="services">
        <h2>@Model.Value("servicesHeading")</h2>
        @if (services != null && services.Any())
        {
            <ul>
                @foreach (var item in services)
                {
                    <li>
                        <h3>@item.Content.Value("title")</h3>
                        <p>@item.Content.Value("description")</p>
                    </li>
                }
            </ul>
        }
    </section>

    <!-- Contact section -->
    <section id="contact">
        <h2>@Model.Value("contactHeading")</h2>
        <p>
            <a href="mailto:@Model.Value("contactEmail")">@Model.Value("contactEmail")</a>
        </p>
    </section>

</body>
</html>
```
{% endcode %}

## Step 4: Add Styles

1. Open your Umbraco project in a code editor.
2. Create a file named `styles.css` in the `wwwroot/css/` folder.
3. Add styles to suit your design. The following is a minimal starting point that makes each section visible and the navigation sticky.

{% hint style="info" %}
Full visual styling is outside the scope of this tutorial. The example below gives each section enough structure to verify the layout works.
{% endhint %}

{% code title="wwwroot/css/styles.css" %}
```css
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

html {
    scroll-behavior: smooth;
}

nav {
    background: #fff;
    border-bottom: 1px solid #eee;
    padding: 1rem 2rem;
    position: sticky;
    top: 0;
}

nav ul {
    display: flex;
    gap: 2rem;
    list-style: none;
}

section {
    min-height: 100vh;
    padding: 4rem 2rem;
}

#hero {
    background: #f5f5f5;
    text-align: center;
}
```
{% endcode %}

## Step 5: Create the Content Node

1. Go to the **Content** section.
2. Select **Create** from the **...** menu at the root of the Content tree.
3. Choose **One-Page Site** as the Document Type.
4. Name the page `Home`.
5. Fill in the properties for each section:
   * **Hero Title**: The main headline for the page.
   * **Hero Subtitle**: A supporting line of text below the headline.
   * **Hero Image**: An image to display in the Hero section.
   * **About Heading** and **About Text**: Content for the About section.
   * **Services Heading**: A heading for the Services section.
   * **Services Items**: Add service items using the Block List Editor.
   * **Contact Heading** and **Contact Email**: Contact details for the Contact section.
6. Click **Save and Publish**.

Open a browser and navigate to your site's root URL. All four sections are now visible on a single page.

## Next Steps

* Replace the email address with a contact form. See the [Umbraco Forms](https://docs.umbraco.com/umbraco-forms) documentation to get started.
* Add more sections to the Document Type and Template as your content grows.
* Use the [Block Grid Editor](../fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/block-editor/block-grid-editor.md) for column-based section layouts.

