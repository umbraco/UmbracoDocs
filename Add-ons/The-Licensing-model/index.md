---
versionFrom: 7.0.0
versionTo: 8.0.0
meta.RedirectLink: "/welcome/the-licensing-model"
---

# The Licensing Model

Umbraco Forms and Umbraco Deploy are commercial products.

For Umbraco Forms you will have a 14-day free trial to try out the product. After your trial expires, you'll need to have a **valid license** in order to keep using the product on your site.

Umbraco Deploy doesn't come with a 14-day free trial, which means you will need a **valid license** in order to use the products. You will be able to test Deploy on a local setup without a license.

## How does it work?

Licenses for our products are sold per domain and will also work on all subdomains. With every license you will also be able to configure two development/testing domains.

### Example

Let's say that you have a license configured for your domain, `mysite.com`, and you've configured two development domains, `devdomain.com` and `devdomain2.com`.

The license will cover the following domains:

- `localhost`
- `*.mysite.com`
- `www.mysite.com`
- `mysite.com.local`
- `devdomain.com`
- `www.devdomain.com`
- `devdomain2.com`
- `www.devdomain2.com`

:::note
That you can have only 1 license per Umbraco installation.
:::

## What does a license cover?

Even though we use the same licensing model for Umbraco Forms and Umbraco Deploy, there are a few differences as to what the licenses cover.

### Umbraco Forms

- A single license covers the installation of Umbraco Forms in 1 production domain, as well as in 2 development domains
- The production domain includes **all subdomains** (e.g. `*.mysite.com`), as well as the `.local` extension (e.g. `mysite.com.local`)
- The development domains works with or without the `www` subdomain
- The license allows for an unlimited number of forms
- The license also includes `localhost` as a valid domain

In the case you run multiple sites within one Umbraco installation, e.g. you have multiple domains pointing at the same installation, you have the option to purchase and add **additional domains** to your license.

Additional domains can be purchased from your account on [Umbraco.com](https://umbraco.com). Each additional domain includes 1 live domain and 2 development/testing domains.

:::note
This is an add-on domain for existing licenses. Refunds will not be given for this product.
:::

### Umbraco Deploy

Deploy license:

A single licence covers one Umbraco solution, including all domains hosted by the solution, all production environments (if load-balancing) and all non-production environments.

To clarify on the above:

- You only need one license when you have a solution covering multiple domains- e.g. www.mysite.com and www.mysite.dk - load balanced in production over multiple servers running from the same database, managed from the same back-office instance, and with any number of non-production environments (staging, qa, etc.)

- You need two licences If you have a web presence that consists of two separate websites hosted on different domains or sub-domains - e.g. www.mysite.com and shop.mysite.com - with each of these managed as a separate Umbraco installation using their own database and back-office in production.

:::note
The license for Umbraco Deploy comes with a recurring yearly fee. Learn more about this and pricing on [Umbraco.com](https://umbraco.com/products/umbraco-deploy/).
:::

## Configuring and installing your license

You can purchase licenses for our products on our website:

- [Umbraco Forms licenses](https://umbraco.com/products/umbraco-forms/)
- [Umbraco Deploy licenses](https://umbraco.com/products/umbraco-deploy/)

When you've bought a license you need to configure it with your domains.

You can either configure your license right away, or you can do it later by vising your account on Umbraco.com.

![Configuring Umbraco Forms license](images/configure-forms-license.gif)

## Installing your license

Once you've configured your license with the correct domains, you are ready to install the license on your Umbraco installation.

1. Download your license from your Umbraco.com account - this will give you a `.lic` file
2. Place the file in the `/bin` directory in your Umbraco installation

The `.lic` file must be placed in the `/bin` directory in order to be registered by Umbraco Deploy, Umbraco Courier or Umbraco Forms. If the file isn't placed correctly, the application will automatically switch to trial mode.

![Installing Umbraco Forms license](images/install-forms-license.gif)

## Alternative license location

If you can't include the license file in the `/bin` directory for any reason it is possible to configure an alternative location for the file.

It can be configured in the Umbraco installation's `Web.config` file by adding the following AppSetting, where `value="~/Licenses/"` contains the path of your custom license directory, relative to the root of your Umbraco Installation.

:::warning
This will also change the location for other Umbraco related licenses in this project.
:::

```xml
<appSettings>
    <add key="UmbracoLicensesDirectory" value="~/Licenses/" />
    ...
</appSettings>
```
