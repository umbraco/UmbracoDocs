---
versionFrom: 8.0.0
---

# Going live

In this section, you can find all the information needed in order to publish your website to the world wide web.

- [Domain/Hostname](#domain-hostname)
- [Configure DNS records](#configure-dns-records)
- [Add Hostnames from the portal](#add-hostname-from-the-portal)
- [Umbraco Latch](#umbraco-latch)
- [SMTP](#smtp)
- [SEO](#seo)
- [Newsletter](#newsletter)
- [Tracking and Access](#tracking-and-access)
- [Responsive on all platforms](#responsive-on-all-platforms)

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

#### Video tutorial

<iframe width="800" height="450" src="https://www.youtube.com/embed/4x3DPwQMTr0?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

### Umbraco Latch

Every Umbraco Uno project is protected by Umbraco Latch witch means that a TLS Certificate will be applied automatically.
If you are interested in learning more about Umbraco Latch check out the [product page on Umbraco.com](https://umbraco.com/products/umbraco-cloud/umbraco-latch/).

## SMTP

In Umbraco Uno projects we take care of SMTP(Simple Mail Transfer Protocol) so that you don't have to do anything.
SMTP allows your features like Umbraco Forms to be connected to your email, making you recieve the emails when people answer your forms. if SMTP wasn't set up your forms replies would not be sent anywhere.

## SEO

Setting up SEO should be part of your general workflow when you create content. This is to make your page is the most visible in search engines as possible. All of the fields below should be filled out.

- Company Name
- Site Name
- Company Logo
- Phone Number
- Email
- Latitude
- Longitude

You can reach the general SEO under your home page > Settings > SEO.

Learn much more about how to reap all the benefits of the SEO configuration on your Umbraco Uno project on the [SEO](../SEO) articles.

## Newsletter

You will need to choose between Mailchimp or Campaign Monitor, and then after that fill out your API Key and Default Subscriber ID.
This is necessary, otherwise your newsletter won't work.

To have a newsletter function on your website it will need to be set up through the [Newsletter Widget](../Widgets/Newsletter).

## Tracking and Access

The Tracking and Access group can be found in the *General* settings in the Content tree. If you want to use any extensions such as Google maps or Google Analytics. This is where you put the API Keys.

:::note
In order to your to get the most out of the Google Maps API, then the API Key should be changed to your own API Key
:::

## Responsive on all platforms

The final thing to check before going live could be to do a preview of the page, to check if the page is responsive to all devices.
