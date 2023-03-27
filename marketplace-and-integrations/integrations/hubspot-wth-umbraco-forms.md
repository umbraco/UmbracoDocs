---
description: >-
  Details an integration available for Hubspot with Umbraco Forms, built and maintained by Umbraco HQ.
---

# Hubspot with Umbraco Forms Integration

This integration provides a custom workflow, allowing form entries to be mapped to a HubSpot contact record, and stored within the CRM platform.

Install from NuGet via:
https://www.nuget.org/packages/Umbraco.Forms.Integrations.Crm.Hubspot

Source code is at:
https://github.com/umbraco/Umbraco.Forms.Integrations/tree/main/src/Umbraco.Forms.Integrations.Crm.Hubspot

Available on the Umbraco Marketplace at:
https://marketplace.umbraco.com/package/umbraco.forms.integrations.crm.hubspot

## Prerequisites

Requires minimum versions of Umbraco:

- CMS: 10.1.0
- Forms: 10.1.0

## How To Use

### Authentication

The package supports authentication using the OAuth protocol.

Using the workflow, the user will be made aware that the installation is not authenticated with HubSpot and can't currently be used.

They will be prompted to click a link which will take them to the HubSpot authentication page for the Umbraco Forms HubSpot app.

They will need to log into their HubSpot account and agree to the permissions that the app requires (which is to be able to read and write contact information).

They will then be redirected to a website hosted at https://hubspot-forms-auth.umbraco.com which will present an authorization code issued by HubSpot. It's necessary to copy that and paste into the field indicated within the Umbraco Forms installation.

Behind the scenes this will make a further request to HubSpot which will return two tokens - an access token and a refresh token.  The former will be provided in further API calls to HubSpot to authenticate the request.  The latter will be stored via Umbraco's key/value service (which writes to the `umbracoKeyValue` table) and will be used to retrieve a new access token when it expires.

A button is available to clear the authentication with HubSpot, following which the authentication process would need to be repeated before the integration can again be used.

When the OAuth authentication method is being used, the API call to retrieve the token is proxied via and endpoint on the same website, allowing the Umbraco Forms HubSpot app secret key to remain secret (i.e. not included in configuration or hard-coded into the dll).

##### OAuth Proxy Site

The website used for the OAuth proxy is defined as infrastructure as code in [these templates(https://github.com/umbraco/Umbraco.Cloud.Infrastructure/blob/master/tf-modules/azure/services/umbraco-forms-hubspot-auth/README.md)] (Umbraco HQ access only).

##### Hubspot App

The Hubspot App used for authentication is managed from [here](https://app-eu1.hubspot.com/developer/25171316/application/457256) (Umbraco HQ access only - account hubspot-developers-8usep1.com / 25171316).).

### Working With the HubSpot/Umbraco Forms Integration

Add the "Save Contact to Hubspot" workflow to a form and configure the mappings between the form and Hubspot fields.

![Select the HubSpot workflow](https://github.com/umbraco/Umbraco.Forms.Integrations/raw/main-v10/src/Umbraco.Forms.Integrations.Crm.Hubspot/img/select-workflow.png)

![Defining mappings](https://github.com/umbraco/Umbraco.Forms.Integrations/raw/main-v10/src/Umbraco.Forms.Integrations.Crm.Hubspot/img/mapping.png)

When a form is submitted on the website, the workflow will execute and create a new contact record in your Hubspot account, using the information mapped from the fields in the form submission.

![Hubspot contacts](https://github.com/umbraco/Umbraco.Forms.Integrations/raw/main-v10/src/Umbraco.Forms.Integrations.Crm.Hubspot/img/hubspot-contacts.png)
