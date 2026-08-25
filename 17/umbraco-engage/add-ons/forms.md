---
description: >-
  The Forms add-on tracks how visitors interact with your Umbraco Forms and
  reports on views, submissions, abandonment, and errors.
---

# Forms

The Forms add-on connects Umbraco Engage to [Umbraco Forms](https://docs.umbraco.com/umbraco-forms). Once installed, Umbraco Engage tracks how visitors interact with your forms. No extra configuration is needed.

## What it adds

* Automatic tracking of form interactions: views, starts, submissions, abandonment, and errors per field.
* A **Forms** report under **Engage** -> **Analytics** with drill-down to individual forms and fields.
* An **Umbraco Forms Submission** goal type, so a form submission can count as a conversion.
* An **Analytics - VisitorId** form field that links a submission to the visitor profile in Umbraco Engage.
* A **Form Submissions** overview on the visitor profile, showing the forms submitted by that visitor.

![Forms tab in the Analytics section](../.gitbook/assets/engage-analytics-forms.png)

## Prerequisites

* Umbraco Engage is [installed](../installation/installation.md) and [licensed](../installation/licensing.md).
* Umbraco Forms is installed with a valid license.
* The [clientside tracking script](../developers/analytics/client-side-events-and-additional-javascript-files/additional-measurements-with-the-analytics-scripts.md) is added to your pages. Form interactions are measured client-side.

## Install the package

Install the [Umbraco.Engage.Forms](https://www.nuget.org/packages/Umbraco.Engage.Forms) package via NuGet or using your preferred approach.

{% tabs %}
{% tab title="Visual Studio Package Manager" %}
```
PM> install-package Umbraco.Engage.Forms
```
{% endtab %}

{% tab title="Console" %}
```console
dotnet add package Umbraco.Engage.Forms
```
{% endtab %}
{% endtabs %}

Build or restart your website afterwards.

## Verify the installation

1. Edit a form and add a new question. The **Analytics - VisitorId** field type should be available.
2. Go to **Engage** -> **Settings** and create a new goal. The **Umbraco Forms Submission** goal type should be available.

![Umbraco Forms Submission option in Goal dropdown](../.gitbook/assets/engage-forms-goal-type.png)

If either option is missing, see [Verify your Engage installation](../installation/troubleshooting-installs.md).

## Next steps

{% content-ref url="../marketers-and-editors/analytics/forms.md" %}
[Forms](../marketers-and-editors/analytics/forms.md)
{% endcontent-ref %}

{% content-ref url="../developers/analytics/forms.md" %}
[Extending forms](../developers/analytics/forms.md)
{% endcontent-ref %}
