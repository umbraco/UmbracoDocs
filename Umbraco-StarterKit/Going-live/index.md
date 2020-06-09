---
versionFrom: 8.0.0
---

# Going live

In this section, you can find all the information needed in order to publish your website to the world wide web.

- [Domain/Hostname](#Domain/Hostname)
- [Configure DNS records](#Configure-DNS-records)
- [Add Hostnames from the portal](#Add-Hostnames-from-the-portal)
- [Umbraco LATCH](#Umbraco-LATCH)
- [SMTP](#SMTP)
- [SEO](#SEO)
- [Newsletter](#Newsletter)
- [Tracking and Access](#Tracking-and-Access)
- [Responsive on all platforms](#Responsive-on-all-platforms)

## Domain/Hostname

The first step is to set up your Hostname, you can do this from the portal.
This guide will show you how to bind your hostname to your Umbraco Uno environment where you see your environment.

### Configure DNS records

It is recommended to set-up an ALIAS record for your root hostname (e.g. mysite.s1.umbraco.io), rather than an A record for the umbraco.io service IP address - 23.100.15.180.
Check with your DNS host or hostname provider for details on how to configure this for your hostnames.

### Add Hostname from the portal

- Click Settings
- Select Hostnames
- Once inside Hostnames, click "Add new hostname"
- Add your hostname to the field and select add
- To keep track of the process, you can refresh the page when it is done sucessfully it will say: Protected by LATCH  

### Umbraco LATCH

Every Umbraco Uno project is protected by Umbraco LATCH witch means that a TLS Certificate will be applied automatically.
If you are interested in learning more about [LATCH](https://umbraco.com/products/umbraco-cloud/umbraco-latch/) this is a good place to start.

### SMTP

In Umbraco Uno projects we take care of SMTP(Simple Mail Transfer Protocol) so that you don't have to do anything.

## SEO

Setting up should be part of your general workflow for each of your nodes.
This is to make your page as visible in search engines as possible - all of the fields below should be filled out.

- Company Name
- Site Name
- Company Logo
- Phone Number
- Email
- Latitude
- Longitude

You can reach the general SEO Under your home node > Settings > General.

There is more documentation about SEO at these pages [General settings](../Uno-pedia/Settings/General-Settings/index.md/#SEO) and [Specific settings ](../Uno-pedia/Settings/Specific-Settings/index.md/#SEO) 

## Newsletter

You will need to choose between Mailchimp or Campaign Monitor, and then after that fill out your API Key and Default Subscriber ID.
This is necessary, otherwise your newsletter won't work.

## Tracking and Access

Tracking and Access can be found in the Settings > General section. If you want to use any extensions such as Google maps or Google Analytics. This is where you put the API Keys.

:::note
It is important to note that the ***REMOVED*** API Key for Google Maps should be changed to your own API Key, as this standard one will stop working eventually.
:::

## Responsive on all platforms

The final thing to check before going live could be to do a preview of the page, to check if the page is responsive to all devices.
