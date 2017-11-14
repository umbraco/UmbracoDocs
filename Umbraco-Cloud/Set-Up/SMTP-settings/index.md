# SMTP settings on Umbraco Cloud

In many cases you would like your Umbraco Cloud project to be able to send out emails. This could be for inviting users or as part of an Umbraco Forms workflow. Before this is possible, you will need to have an SMTP server and configure this in your `web.config` file.

SMTP (Simple Mail Transfer Protocol) is not something that comes with your Umbraco Cloud project. You will need to have your own SMTP server setup else where and then you need to connect this service to your Umbraco Cloud project.

## Reasons to configure SMTP

There could be a handful of reasons why you would like your Umbraco Cloud project to be able to send out emails.

### Umbraco Forms

When you are working with Umbraco Forms you have the option to setup email workflows. This enables you to create forms that send out emails - it could be a contact form where your customers can send emails directly to you.

Before this email workflow will work you will need to configure an SMTP service.

### Backoffice users

In some cases you might prefer to add users to your project directly from the backoffice. Doing this involves sending out an email to the new users. 

If you haven't configured an SMTP service on your Umbraco Cloud project an email will still be sent to the new users. We have setup a fall-back *only* for invitation, which means that you can invite users to your project without having configured an SMTP service. 

We still encourage you to setup SMTP, since you might need it for other purposes as well.


2 scenarion: inviting and changing / updating password

Email workflow

## How to configure SMTP settings

As Umbraco Cloud doesn't provide SMTP servers, this is something you will need to find hosting for else where. There are multiple excellent providers out there .. (should we recommend some providers?)

Setting up the SMTP server is step one. Step two is to configure the service in your `web.config` file - in the `system.net/mailSettings` section.

    <system.net>
        <mailSettings>
        <smtp from="noreply@example.com">
            <network host="127.0.0.1" userName="username" password="password" />
        </smtp>
        </mailSettings>
    </system.net>

