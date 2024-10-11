---
description: >-
  Learn about the different ways available for installing Umbraco uMS on your
  project.
---

# Installation

This article covers two ways to install Umbraco uMS:

* [Via NuGet](installation.md#installation-via-nuget), or
* [Via a terminal](installation.md#installing-using-the-terminal).

{% hint style="info" %}
Check [the requirements](../getting-started/for-developers/system-requirements.md) before you start installing Umbraco uMS.
{% endhint %}

## Installation via NuGet

Install Umbraco uMS via Nuget in your IDE such as Visual Studio, JetBrains Rider, or VSCode (With [C# DevKit](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csdevkit)).

The example shown below uses the Nuget Package Manager in Visual Studio.

1. Open the project in Visual Studio.
2. Go to **Tools** -> **NuGet Package Manager** -> **Manage NuGet Packages for Solution**.

![NuGet ](../.gitbook/assets/NuGet-Package-Manager.png)

3. Navigate to the **Browse** tab.
4. Search for the **Umbraco uMS** package.
5. Select the package.
6. Choose which project to install it into.
7. Install the package.

![]()

## Installing using the terminal

You can install Umbraco uMS using a terminal, like the Package Manager Console in Visual Studio. The steps for doing so are outlined below.

1. Open the project in Visual Studio.
2. Find and open the Package Manager Console from the Tools menu.
3. Type the following into the terminal:

```console
PM> install-package Umbraco uMS
```

Alternatively, Umbraco uMS can be installed via the console on your operating machine.

1. Open a terminal window on your operating system.
2. Navigate to the folder containing your Umbraco website.
3. Install the Umbraco uMS Nuget package with the following command:

```console
dotnet add package Umbraco uMS
```

{% hint style="info" %}
If you have any trouble, please go to [Troubleshooting installs](../../../installing-umarketingsuite/troubleshooting-installs/).
{% endhint %}

## Next steps

![Engage section in the Umbraco Backoffice.](../.gitbook/assets/image.png)

When you have installed the Umbraco uMS, build or restart your website, and the **Marketing** section will appear in the backoffice, as shown above.

The next step is to [configure a license](../../../installing-umarketingsuite/licensing/).

It is recommended to consider the information detailed in the section below, to get the best out of Umbraco uMS.

### Umbraco Forms

If you have installed **Umbraco Forms** as well and want to automatically track submissions of Umbraco Forms. Please install the package [uMarketingSuite.UmbracoForms](https://www.nuget.org/packages/uMarketingSuite.UmbracoForms) via NuGet as well using your preferred approach as above.

PUT THE FOLLOWING TWO INTO TABS

{% tabs %}
{% tab title="Visual Studio Package Manager" %}
```
PM> install package uMarketingSuite.UmbracoForms
```
{% endtab %}

{% tab title="Console" %}
```console
dotnet add package uMarketingSuite.UmbracoForms
```
{% endtab %}
{% endtabs %}

### Clientside tracking

To capture events that happen on the clientside (frontend) of your website, you need to add the [clientside tracking script](../../../analytics/clientside-events-and-additional-javascript-files/additional-measurements-with-our-ums-analytics-scripts/). This is done by including the following snippet on all of your pages.

```html
<script src="/Assets/uMarketingSuite/Scripts/uMarketingSuite.analytics.js"></script>
```

### Cockpit

Cockpit is a tool to help with testing segments and diagnose the data uMarkertingSuite collects. It can be viewed on the frontend of your website, only if you are logged into Umbraco as well.

Install cockpit on your website by adding the following Razor Partial View in your templates in Umbraco before the closing `</body>` tag

```html
@Html.Partial("uMarketingSuite/Cockpit")</body>
```

Learn more [what Cockpit is and how you can use](../../../installing-umarketingsuite/cockpit/) it.

### Optional Extras

Here are some optional extras you can do to improve your experience with uMS.

* Add a [Google Analytics bridging script](../../../analytics/clientside-events-and-additional-javascript-files/bridging-library-for-google-analytics/) that automatically sends events that you send to Google Analytics, to uMS as well.

```html
<script src="~/Assets/uMarketingSuite/Scripts/uMarketingSuite.analytics.ga4-bridge.min.js"></script>
```

* Add the [Google Analytics blocker detection script](../../../analytics/clientside-events-and-additional-javascript-files/google-analytics-blocker-detection/). This gives you insights in which page traffic the uMS will track, and Google Analytics will not track.

```html
<script src="/Assets/uMarketingSuite/Scripts/uMarketingSuite.analytics.blockerdetection.js"></script>
```

### Cookie consent

If you need to influence the default [uMS cookie](../../../the-umarketingsuite-broad-overview/the-umarketingsuite-cookie/) behaviour please go [here](../../../security-privacy/gdpr/). Or go to an example [implementation using Cookiebot](../../../security-privacy/gdpr/how-to-become-gdpr-compliant-using-cookiebot/) which can be used as an example for other cookie consent providers.\\

{% hint style="warning" %}
If you [change the default cookie behaviour](../../../the-umarketingsuite-broad-overview/the-umarketingsuite-cookie/module-permissions/) make sure to perform a **client side reload of the initial page after cookie consent**. If this is not done, visitor referrer and/or campaigns will not be tracked.
{% endhint %}

### Load balancing and CM / CD environments

Are you using a load-balanced setup or separate CM and CD environments? Please check our documentation about this topic [here](../../../installing-umarketingsuite/loadbalancing-and-cm-cd-environment/).
