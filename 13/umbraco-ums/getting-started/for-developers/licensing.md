# Licensing

May be not the most fun part of the package, but very important though.

If you have [installed the uMarketingSuite](../../../../installing-umarketingsuite/quick-install/) in your project and you navigate to the Marketing section in the Umbraco backoffice you will see these two messages.

![]()

![]()

To let the uMarketingSuite work you will need to install a license. If you have not configured a license the uMarketingSuite:

* will not collect any Analytics data
* give no A/B test variants to visitors
* will not personalize content for visitors

In other words; the package does not work.

### Obtaining a license

Luckily obtaining a license is easy. Go to [www.umarketingsuite.com](http://www.umarketingsuite.com), you will have a "Sign in" button on the top right that leads you to the login form: [https://www.umarketingsuite.com/my-account/login/](https://www.umarketingsuite.com/my-account/login/).

![]()

Here you can login, or create a new account via the register form: [https://www.umarketingsuite.com/my-account/register/](https://www.umarketingsuite.com/my-account/register/).

#### Register

To register as a new user you'll only need your emailaddress, a preferred password and your first and last name. After submitting the form an email is sent to confirm the emailaddress. After you click the link in that email you are ready to go!

### Create a new license

In the backoffice you can navigate to 'Licenses' in the menu or go directly to the url [https://www.umarketingsuite.com/my-account/overview/licenses/](https://www.umarketingsuite.com/my-account/overview/licenses/). Here you have the option to 'Create a new license':

![]()

#### Step 1: License type

In the form you will first select the license type you want to order. Visit [https://www.umarketingsuite.com/pricing/](https://www.umarketingsuite.com/pricing/) to see all the different licenses.

The difference between the licenses are primarily:

* Which features are enabled
* The number of pageviews that are tracked per month
* The number of domains that are supported
* Price

**Development domains**

You have the option to list a few development domains on which the uMarketingSuite will work. When creating a 'Dev'-license (the free license) you do not have the option to list any other development domains. The following development domains are included:

* localhost
* \*.localhost
* \*.local
* \*.test
* \*.localtest.me
* \*.nip.io
* \*.xip.io
* \*.umbraco.io
* \*.azurewebsites.net

If selecting any of the other licenses you can specify up to 5 development domains here.

**Production domains**

If you order a paid license (all, except the 'dev'-license) you can input 1 or more production domains that the uMarketingSuite will track. The number of domains that you can specify is depending on your license type.

It's important to know that only 1 Umbraco installation is supported per license. It's no problem to have five domains in one installation and use only 1 uMarketingSuite license. You cannot however use one license for 5 different Umbraco installations with 5 different domains.

The number of installations is the number of different Umbraco installations. A load balanced setup with three servers is still one installation.

**Display name**

Finally you will need to specify the display name. This is only shown in the overview of licenses and does not do anything else. It is just for your convenience and overview.

#### Step 2: Invoice details

If you order a paid license there is a step 2. In this step you have to fill in the invoice details that will be printed on the invoice. It's important that the uMarketingSuite license is only for businesses and not for private customers. To enforce this you will need to list a VAT-number in step 2.

If you order a 'dev'-license; this step is not shown.

#### Step 3: The End User License Agremeent

In the last step you'll have to agree with the End User License Agreement. It's a long and interesting piece of text, but the highlights are:

* You can only use the license for the number of licenses purchased and only on the domain you specify
* You cannot decompile or hack the software
* If you find any bugs or security vulnerabilities you should report them to us
* If you want to complain about the software; complain to us instead of only online
* We try to protect our intellectual property, so please do not infringe that
* We do not store any personal data. That is all stored in your own databases. We do how ever have the right to obtain some anonymized data about how the package is used. But this would never include any personal data
* We do our very best to make sure that our software will always be compatible with the last two minor versions of Umbraco

We hope that sounds totally reasonable to you as well. To agree with the agreement you will have to scroll down and accept the agreement.

And now you are done!

### Payment and invoicing

At this moment we manually create an invoice if you have a paid license. Of course we want to automate that completely, but our first priority is on the package and we're investing most of our time in that. So for now, please accept that this is a manual process and it normally takes us less than 24 hours to create an invoice.

To not be in your way or slow down your testing process you'll get a 14-day temporary license that you can directly use. Within these 14 days you get the invoice and you are obliged to pay the invoice. Once you do; we can set the expiry date to the right date and your license will automatically be upgraded to the right expiry date.

One month before expiry we will send you a new invoice, and the process repeats.

### Downloading and editing the license

In the overview of licenses ([https://www.umarketingsuite.com/my-account/overview/licenses/](https://www.umarketingsuite.com/my-account/overview/licenses/)) you can download the license. If you have a paid license it's also possible to edit the license and list new domains or remove old domains.

At this moment it's not possible to upgrade or downgrade a license. Once again; at this moment we're too focused on adding new features to the package. Hopefully you forgive us for that and reach out to us via [info@umarketingsuite.com](mailto:info@umarketingsuite.com) to upgrade or downgrade your license.

### Installing the license

If you've downloaded the license from your profile you can put the license in the folder /config/uMarketingSuite/. The name of the license must be uMarketingSuite.license.config.

You can open this license as well and there you see everything that is listed in the license and enforced within the uMarketingSuite.

To see the installed license you will need to restart your website!

If you now go to the backoffice and navigate to the Marketing section you'll see the type of license, the expiry date and the domains it's working on:

![]()

From this moment on data will be tracked for these exact domains.

### Updating the license

The license will reach out to our licensing server at the startup of your website and every 24 hours to check whether something has changed for your license. This could be that the expiry date has been changed (because of the payment of an invoice), other domains are listed, etcetera.

If your website has write-access to the folder /config/uMarketingSuite/ and the server can connect to licensing.umarketingsuite.com the license will automatically be updated. (Oooh, magic....)

If you have edited your license (for example; add a new domain) you should either restart your website or wait 24 hours to see the new domain.

The alternative option is to download the license from your profile and place the license in your website.

### Exceeding the pageview limit

There is a pageview limit per license per month. As soon as this pageview limit is reached no data will be recorded any longer within the uMarketingSuite. It is not possible to see the data at a later moment (when you've upgraded your license for example) because the data is simply not stored.

The pageview limit is based on the number of pageviews in a specific month (not for the last 30 days) for visitors. Bots will be excluded from this number!
