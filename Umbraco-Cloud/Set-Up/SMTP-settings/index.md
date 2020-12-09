---
versionFrom: 7.0.0
---

# SMTP settings on Umbraco Cloud

In many cases you might want to be able to send emails from your Umbraco Cloud project. This could be for inviting users to the backoffice or as part of an Umbraco Forms workflow. Before this is possible, you will need to have an SMTP server and configure this in your `web.config` file.

An SMTP (`Simple Mail Transfer Protocol`) server is not something that comes with your Umbraco Cloud project. You will need to have your own SMTP server setup elsewhere and then you need to configure this service with your Umbraco Cloud project.

## Reasons to configure SMTP

There are a handful of reasons where configuring an SMTP service on your Umbraco Cloud project could come in handy - or might even be necessary.

### Umbraco Forms

When you are working with Umbraco Forms you have the option to setup email workflows. This enables you to create forms that send out emails - it could be a contact form where your customers can send emails directly to you.

Before this email workflow will send out emails you will need to configure an SMTP service.

:::note
In some cases, you might also experience that you need to configure a sender-email for notifications.

This can be done in the `<notifications>` section of the `web.config` file. Find more details on this in the [`umbracoSettings`](../../../reference/config/umbracosettings/#notifications) article.
:::

### Backoffice users

There are two scenarios regarding backoffice users where configuring an SMTP service is needed.

The first scenario is when you want to add a user to your project directly from the backoffice. Doing this involves sending out an email to the new user. For this particular scenario we've setup a fallback, which means that even though you haven't yet configured an SMTP service, and email will still be sent to the new user. Keep in mind that the fallback is **only** for this particular purpose; inviting users to join your project.

The second scenario where you'd need to setup an SMTP service for your Umbraco Cloud project, is if one of your backoffice users have forgotten their password. To reset their password, they have to request a password reset which will be send to them by mail. This will only work once you've configured an SMTP service.

:::note
The option to request password resets for backoffice users is disabled by default on Umbraco Cloud projects. This is mainly due to the fact, that we recommend adding backoffice users as team members through the Umbraco Cloud Portal instead of directly through the Umbraco backoffice.
:::

## How to configure SMTP settings

As Umbraco Cloud doesn't provide SMTP servers, this is something you will need to find hosting for elsewhere. There are multiple excellent services out there, here's a few we know work with Umbraco Cloud:

* [Sparkpost](https://www.sparkpost.com/) - quick to setup and developer-friendly
* [SendGrid](https://sendgrid.com/) - quick to setup
* [MailGun](https://www.mailgun.com/) - mainly for developers, as it is a bit more on the technical side

<iframe width="800" height="450" src="https://www.youtube.com/embed/YcoFF-Ke55o?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

Setting up the SMTP server is step one. Step two is to configure the service in your `web.config` file - in the `system.net/mailSettings` section.

```xml
<system.net>
    <mailSettings>
    <smtp from="noreply@example.com">
        <network host="127.0.0.1" userName="username" password="password" />
    </smtp>
    </mailSettings>
</system.net>
```

To configure your SMTP service you will need to following details:

* The **host**: IP address or hostname for your SMTP service
* The **userName**: Your username for the SMTP service
* The **password**: The password you use to access your SMTP service

When you've configured these settings for your SMTP service, you will be able to send emails from your Umbraco Cloud project.

:::note
You can test if you've configured your SMTP service correctly by running a [Health Check](https://our.umbraco.com/Documentation/Extending/Healthcheck/) from the Umbraco backoffice.
:::
