# The Licensing Model

Umbraco Deploy is a commercial product. You will need a **valid license** to use the product.

A license for Umbraco Deploy is included when hosting on Umbraco Cloud.

## How does it work?

Licenses are sold per domain and will also work on all subdomains. With every license, you will also be able to configure two development/testing domains.

### Example

Let's say that you have a license configured for your domain, `mysite.com`, and you've configured two development domains, `devdomain.com` and `devdomain2.com`.

The license will cover the following domains:

* `localhost`
* `*.mysite.com`
* `www.mysite.com`
* `mysite.com.local`
* `devdomain.com`
* `www.devdomain.com`
* `devdomain2.com`
* `www.devdomain2.com`

{% hint style="info" %}
You can have only 1 license per Umbraco installation.
{% endhint %}

## What does a license cover?

There are a few differences as to what the licenses cover:

A single license covers one Umbraco solution. It includes all domains hosted by the solution, all production environments (if load-balancing), and all non-production environments.

To clarify the above:

* You only need one license when you have a solution covering multiple domains- for example, www.mysite.com and www.mysite.dk - load balanced in production over multiple servers running from the same database, managed from the same backoffice instance, and with any number of non-production environments (staging, QA, etc.)
* You need two licenses if you have a web presence that consists of two separate websites hosted on different domains or sub-domains - for example, www.mysite.com and shop.mysite.com - with each of these managed as a separate Umbraco installation using their own database and backoffice in production.

{% hint style="info" %}
The license for Umbraco Deploy comes with a recurring yearly fee. Learn more about this and pricing on [Umbraco.com](https://umbraco.com/products/umbraco-deploy/).
{% endhint %}

## Purchasing your license

You can purchase the license at [Umbraco Deploy Licenses](https://umbraco.com/products/umbraco-deploy/)

## Installing your license

Once you've configured your license with the correct domains, you are ready to install the license on your Umbraco installation.

For Umbraco Deploy On-Premise 12 and above, this will be a key provided to you when taking out your subscription to the product. It should be added to your configuration at the key `Umbraco:Licenses:Umbraco.Deploy.OnPrem`.

For example, in `appsettings.json`:

```json
  "Umbraco": {
    "CMS": {
      ...
    },
    "Licenses": {
      "Umbraco.Deploy.OnPrem": "<your license key>"
    },
    "Deploy": {
       ...
    }
```

Umbraco Cloud projects use a license file placed in the `/umbraco/Licenses` folder that is provided automatically when your project is created.

## Validating the license

On start-up and on a schedule, Umbraco running Deploy On-premise will call out to a service. It will pass the configured license key to determine its validity.  The response triggers a notification that the Umbraco Deploy will handle. It will amend the available functionality as appropriate to a valid, invalid  or expired license.

You can view the status of the Umbraco Deploy On-premise license in the backoffice. This is available via the _Settings_ section, listed along with any other products using the same licensing service:

![Licenses screen in Umbraco backoffice](./images/licenses-screen.png)

### When and how to configure an `UmbracoApplicationUrl`

The website domain used for validating the license is determined from your Umbraco instance. To ensure the correct one is used, you can configure the `UmbracoApplicationUrl`.

If you are running on a single domain for both your frontend and backend environments, it's not necessary to configure a `UmbracoApplicationUrl`.

If you have different domains for your frontend and backend, then it's advised that you configure an `UmbracoApplicationUrl` set to your backoffice URL. This helps the licensing engine know which URL should be used for validation checks. Without this configuration setting, the licensing engine will try and work out the domain to validate from the HTTP request object. This can lead to errors when switching between domains.

An `UmbracoApplicationUrl` can be configured in your `appSettings.json` file like so:

```json
{
    "Umbraco": {
        "CMS": {
            "WebRouting": {
                "UmbracoApplicationUrl": "https://admin.my-custom-domain.com/"
            }
        }
    }
}
```

See the [Fixed Application URL](https://docs.umbraco.com/umbraco-cms/extending/health-check/guides/fixedapplicationurl) documentation for more details about this setting.
