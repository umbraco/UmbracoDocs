# The Licensing Model

Umbraco Forms and Umbraco Courier are commercial products. When you install them from the backoffice of your installation you will have a 14-day free trial to try out the products.

After your trial expires, you'll need to have a **valid license** in order to keep using the products on your site.

## How does it work?

Licenses for our products are sold per domain and will also work on all subdomains. With every license you will also be able to configure two development / testing domains.

### Example

let's say that you have a license configured for your domain, `mysite.com`, and you've configured two development domains, `devdomain.com` and `devdomain2.com`.

The license will cover the following domains:

- localhost
- *.mysite.com
- www.mysite.com
- mysite.com.local
- devdomain.com
- www.devdomain.com
- devdomain2.com
- www.devdomain2.com

**Note** that you can have only 1 license per Umbraco installation. 

## What does a license cover?

Even though we use the same licensing model for Umbraco Forms and Umbraco Courier, there are a few differences as to what the licenses cover.

### Umbraco Forms

- A single license covers the installation of Umbraco Forms in 1 production domain, as well as in 2 development domains
- The production domain includes **all subdomains** (e.g. `*.mysite.com`), as well as the `.local` extension (e.g. `mysite.com.local`)
- The development domains works with or without the `www` subdomain
- The license allows for an unlimited number of forms
- The license also includes `localhost` as a valid domain

In the case the you run multiple sites within one Umbraco installation, e.g. you have multiple domains pointing at the same installation, you have the option to purchase and add **additional domains** to your license.

Additional domains can be purchased from your account on [Umbraco.com](https://umbraco.com) for 94 EUR. Each additional domain includes 1 live domain and 2 development / testing domains.

**Note** that this is an add-on domain for existing licenses. Refunds will not be given for this product.

### Umbraco Courier

- A single license covers the installation and use of Umbraco Courier in 1 production domain, as well as 2 development domains
- The production domain includes all subdomains (e.g. `*.domain.tld`), as well as the `.local` extension (e.g. `domain.tld.local`)
- The development domains works with or without the `www` subdomain
- The license also includes `localhost` as a valid domain

For the Umbraco Courier license you do not need to purchase additional domains if you are running multiple sites within the same Umbraco installation. 

## Configuring and installing your license

You can purchase licenses for our products on our website:

- [Umbraco Forms licenses](https://umbraco.com/products/umbraco-forms/)
- [Umbraco Courier licenses](https://umbraco.com/products/umbraco-courier/)

When you've bought a license you need to configure it with your domains.

You can either configure your license right away, or you can do it later by vising your account on Umbraco.com.

![Configuring Umbraco Forms license](images/configure-forms-license.gif)

## Installing your license

Once you've configured your license with the correct domains, you are ready to install the license on your Umbraco installation.

1. Download your license from your Umbraco.com account - this will give you a `.lic` file
2. Place the file in the `/bin` directory in your Umbraco installation

The `.lic` file must be placed in the `/bin` directory in order to be registered by Umbraco Courier or Umbraco Forms. If the file isn't placed correctly, the application will automatically switch to trial mode.

![Installing Umbraco Forms license](images/install-forms-license.gif)
