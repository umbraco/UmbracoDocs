---
description: >-
  In this tutorial, we show how you can create a custom Backoffice Tour in
  Umbraco CMS.
---

# Creating a Backoffice Tour

## Introduction

In this tutorial we will show how you can create a backoffice tour, helping users get started with working in the Umbraco backoffice.

A use case could be if you have a [custom dashboard](creating-a-custom-dashboard/) then a backoffice tour can be used to show how it works.

Before moving on, we recommend reading the [Backoffice Tours](../extending/backoffice-tours.md) documentation as it explains how each of the elements works in the tour.

## Video tutorial

{% embed url="https://youtu.be/7xas45Keb_o" %}
Video tutorial on how to create a backoffice tour
{% endembed %}

## Step 1: Create the Backoffice tour files

To create the backoffice tour, the first thing we need is to create its associated files.

These files need to be created in the **app\_plugins** folder. If the **app\_plugins** folder does not already exist in your project the folder needs to be created at the root of your project files.

1. Navigate to the root of the Umbraco project.
2. Create an **app\_plugins** folder at the root of your project.
3. Create a folder with the name of your plugin, in the app\_plugins folder.
4. Create another new folder within that, called **backoffice**.
5. Create a folder called **tours.**
6. Add a new **JSON** file to the tours folder.

![Umbraco Backoffice tour folder structure](<../.gitbook/assets/image (6).png>)

In the JSON file, we will add the **Tour Configuration Object** and the **Tour Step Object** in the following step.

## Step 2: Create the Tour Configuration Objects

Once we have added the folders and the JSON file, we can go ahead and create the Tour Configuration Object.

In the JSON file, add the following configuration object:

```json
[
  {
    "name": "My Custom Backoffice tour",
    "alias": "myCustomBackofficeTour",
    "group": "Get things done!!!",
    "groupOrder": 1,
    "allowDisable": true,
    "culture": "en-US",
    "contentType": "",
    "requiredSections": [ "content", "media" ],
    "steps": []
  }
]
```

Once we have added the Configuration Object, it is time to configure it so it fits our backoffice tour.

In this Tour Configuration Object, we are going to change the name, alias, and group:

1. Change the `name` to "**Settings Section Tour**_**"**_
2. Change the `alias` to "**settingsSectionTour**_**"**_
3. Change the `group` to "**Learn about the settings section**_**"**_
4. Add _**"**_**settings**_**"**_ to the `requiredSection`.

The **name** is what is displayed in the help drawer for our tour.

The **alias** is unique to our tour. It is used to track the progress the users have made while taking the tour.

The **group** is used to group related tours in the help drawer under a common subject (for example Getting Started).

The `requiredSections` is an array of section aliases that a user needs access to, to see the tour. If the user does not have access to all the defined sections, the tour will not be shown in the help drawer.

Once you are done with the steps above, the Tour Configuration should look like this:

```json
[
  {
    "name": "Settings section Tour",
    "alias": "settingsSectionTour",
    "group": "Learn about the settings section",
    "groupOrder": 1,
    "allowDisable": true,
    "culture": "en-US",
    "contentType": "",
    "requiredSections": [ "content", "media", "settings" ],
    "steps": []
  }
]
```

## Step 3: Find elements for the Tour Step Object

Before we get started with creating our Tour Step Objects, we need to find the CSS selector for the elements that we want to highlight in our tour.

In this tutorial, we want to highlight three areas: Settings in the navigation, the side navigation in the Settings section, and then the Settings dashboard.

A lot of elements in the backoffice have the `data-element` attribute, however, we can also use IDs or classes.

To find the first `element`, follow the steps below:

1. Go to the backoffice of your Umbraco project and log in.
2. Right-click on Settings in the main navigation and inspect the element.

<figure><img src="../.gitbook/assets/image (4).png" alt=""><figcaption><p>Inspecting the Settings navigation in the backoffice</p></figcaption></figure>

3. Locate the `data-element` for the top navigation called `section-settings`.

<figure><img src="../.gitbook/assets/image (10).png" alt=""><figcaption><p>Finding the data-element for the first tour step</p></figcaption></figure>

4. Note down the `data-element`.

Let's find the element for the second step:

1. Navigate to the Settings section.
2. Right-click on the left side and inspect the page.
3. Find the `<div>` with the `id= "navigation"`.

<figure><img src="../.gitbook/assets/image.png" alt=""><figcaption><p>Finding the id for the second tour step</p></figcaption></figure>

4. Note down the `id`.

And lastly, we need to find the last element for our tour step:

1. Right-click on the dashboard on the right.
2. Locate the `<section>` with the `id="contentWrapper"`.

<figure><img src="../.gitbook/assets/image (1).png" alt=""><figcaption><p>Finding the id for the third tour step</p></figcaption></figure>

4. Note down the `id`.

Once we have located the elements we can go ahead and create our Tour Step Object.

## Step 4: Create the Tour Step Object

We now need to create the Tour Step Object for our tour. The Tour Step JSON Object contains all the data related to tour steps.

In the `steps` object in the Tour Configuration, add the following code snippet:

```json
"steps": [
      {
        "title": "A meaningful title",
        "content": "<p>Some text explaining the step</p>",
        "type": null,
        "element": "[data-element='global-user']",
        "elementPreventClick": false,
        "backdropOpacity": 0.6,
        "event": "click",
        "view": null,
        "eventElement": "[data-element='global-user'] .umb-avatar",
        "customProperties": null
      }
    ]
```

We need to configure it so that it fits our tour.

1. Change the `title` to _**"**_**Accessing the settings section**_**"**_
2. Change the text in `content` to: _**"**_**\<p>Clicking on Settings will direct you to the settings section in Umbraco\</p>**_**"**_
3. Replace the `data-element` with the first one we found called `section-settings`
4. Remove the **"\[data-element='global-user'] .umb-avatar"** from the `eventElement`.

Once this is done, this is how our tour steps look:

```json
"steps": [
      {
        "title": "Accessing the settings section",
        "content": "<p>Clicking on Settings will direct you to the settings section in Umbraco</p>",
        "type": null,
        "element": "[data-element='section-settings']",
        "elementPreventClick": false,
        "backdropOpacity": 0.6,
        "event": "click",
        "view": null,
        "eventElement": "",
        "customProperties": null
      }
    ]
```

For this first step, we are not going to change anything else as we want the rest of the settings for this step to be like they are.

Once we start the tour it will highlight the Settings tab in the navigation. It is then possible to click on Settings which will take us to the Settings section.

<figure><img src="../.gitbook/assets/image (9).png" alt=""><figcaption><p>How the first tour step looks like when running the backoffice tour.</p></figcaption></figure>

It's time to create the second step of our tour.

For the sake of this tutorial let's copy the step and insert it below the previous one.

```json
"steps": [
      {
       ...
      },
      {
        "title": "Accessing the settings section",
        "content": "<p>Clicking on Settings will direct you to the settings section in Umbraco</p>",
        "type": null,
        "element": "[data-element='section-settings']",
        "elementPreventClick": false,
        "backdropOpacity": 0.6,
        "event": "click",
        "view": null,
        "eventElement": "",
        "customProperties": null
      }
    ]
```

In this step, once we click on Settings in the top menu, it will redirect us to the Settings section. It will highlight the side navigation in the Setting section and display our title and content.

Once the steps have been added we can modify the second step in our tour.

1. Change the `title` to **"This is the Settings Section"**
2. Change the `content` to **"\<p>From here you can create document types, and templates, to mention a few**_**\</p>"**_
3. Replace the `data-element` with the second one we found called `id='navigation'`
4. Change "elementPreventClick" from false to true.

This will ensure that a button saying `"next"` will show on the step, as we don't want to click on settings.

We are not going to make any changes to the rest of the steps.

So far, this is how our tour looks:

```json
"steps": [
      {
       "title": "Accessing the settings section",
        "content": "<p>Clicking on Settings will direct you to the settings section in Umbraco</p>",
        "type": null,
        "element": "[data-element='section-settings']",
        "elementPreventClick": false,
        "backdropOpacity": 0.6,
        "event": "click",
        "view": null,
        "eventElement": "",
        "customProperties": null
      },
      {
        "title": "This is the Settings Section",
        "content": "<p>In the side navigation, you can create and manage document types, templates, data types just to name a few.</p>",
        "type": null,
        "element": "[id='navigation']",
        "elementPreventClick": true,
        "backdropOpacity": 0.6,
        "event": "click",
        "view": null,
        "eventElement": "",
        "customProperties": null
      }
    ]
```

This is what the second step looks like in the backoffice when we run the tour:

<figure><img src="../.gitbook/assets/image (3).png" alt=""><figcaption><p>How the second tour step looks like when running the backoffice tour.</p></figcaption></figure>

So far so good. We have created two steps. Let's make a third step for our tour.

Like before, let's copy the previous tour step and add it below like so:

```json
"steps": [
      {
       ...
      },
      {
       ...
      },
      {
        "title": "This is the Settings Section",
        "content": "<p>In the side navigation, you can create and manage document types, templates, data types just to name a few.</p>",
        "type": null,
        "element": "[id='navigation']",
        "elementPreventClick": true,
        "backdropOpacity": 0.6,
        "event": "click",
        "view": null,
        "eventElement": "",
        "customProperties": null
      }
    ]
```

Now let's modify the step.

We are going to highlight the Settings dashboard in the Settings section.

1. Change the `title` to _**"This is the Settings Dashboard"**_
2. Change the `content` to: **\<p>In the settings Dashboard, you will be able to work with your document types, templates, data types, etc**_**.**_**\</p>**
3. Change the `element` `id` to: `id='contentwrapper'`

We still want to show a `"next"` button on the step, so we are not going to change the rest of the step.

Once we run the tour, it will highlight the whole Settings dashboard to the right of the side navigation:

<figure><img src="../.gitbook/assets/image (7).png" alt=""><figcaption><p>How the third tour step looks like when running the backoffice tour.</p></figcaption></figure>

We have now created our backoffice tour, which gives a short overview of the Settings section.

Down below you can see how the final tour step Object is configured:

```json
"steps": [
      {
        "title": "Accessing the settings section",
        "content": "<p>Clicking on Settings will direct you to the settings section in Umbraco</p>",
        "type": null,
        "element": "[data-element='section-settings']",
        "elementPreventClick": false,
        "backdropOpacity": 0.6,
        "event": "click",
        "view": null,
        "eventElement": "",
        "customProperties": null
      },
      {
        "title": "This is the Settings Section",
        "content": "In the side navigation, you can create and manage document types, templates, data types just to name a few.</p>",
        "type": null,
        "element": "[id='navigation']",
        "elementPreventClick": true,
        "backdropOpacity": 0.6,
        "event": "",
        "view": null,
        "eventElement": "",
        "customProperties": null
      },
      {
        "title": "This is the Settings Dashboard",
        "content": "<p>In the settings Dashboard, you will be able to work with your document types, templates, data types, etc.</p>",
        "type": null,
        "element": "[id='contentwrapper']",
        "elementPreventClick": true,
        "backdropOpacity": 0.6,
        "event": "",
        "view": null,
        "eventElement": "",
        "customProperties": null
      }
    ]
```

Now that we have configured the final step of our tour, this is how the code for the tour will look like:

```json
[
  {
    "name": "Settings section Tour",
    "alias": "settingsSectionTour",
    "group": "Learn about the settings section",
    "groupOrder": 1,
    "allowDisable": true,
    "culture": "en-US",
    "contentType": "",
    "requiredSections": [ "content", "media", "settings" ],
    "steps": [
      {
        "title": "Accessing the settings section",
        "content": "<p>Clicking on Settings will direct you to the settings section in Umbraco</p>",
        "type": null,
        "element": "[data-element='section-settings']",
        "elementPreventClick": false,
        "backdropOpacity": 0.6,
        "event": "click",
        "view": null,
        "eventElement": "",
        "customProperties": null
      },
      {
        "title": "This is the Settings Section",
        "content": "In the side navigation, you can create and manage document types, templates, data types just to name a few.</p>",
        "type": null,
        "element": "[id='navigation']",
        "elementPreventClick": true,
        "backdropOpacity": 0.6,
        "event": "",
        "view": null,
        "eventElement": "",
        "customProperties": null
      },
      {
        "title": "This is the Settings Dashboard",
        "content": "<p>In the settings Dashboard, you will be able to work with your document types, templates, data types, etc.</p>",
        "type": null,
        "element": "[id='contentwrapper']",
        "elementPreventClick": true,
        "backdropOpacity": 0.6,
        "event": "",
        "view": null,
        "eventElement": "",
        "customProperties": null
      }
    ]
  }
]
```

## Conclusion

With all the steps completed, we now have a backoffice tour showing the Settings section in the Umbraco backoffice.

You can go ahead and extend the backoffice tour with more steps or create your very own backoffice tours.
