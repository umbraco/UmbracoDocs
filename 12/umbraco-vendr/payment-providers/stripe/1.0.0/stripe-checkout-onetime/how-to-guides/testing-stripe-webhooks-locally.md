---
title: How to test Stripe webhooks locally
description: Documentation for the Stripe Checkout (One Time) payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

Because the Stripe payment provider uses webhooks to finalize payments, it can make it tricky to be able to test payments locally as for Stripe to be able to notify you, the site must have a public facing URL.

You could expose your website through your networks firewall, however there is a simpler way by using tools that can create temporary tunnels through your network such as [ngrok](https://ngrok.com/).

## Step 1 - Install ngrok

The first thing you'll want to do is install ngrok itself. Before you continue, be sure to head on over to [ngrok.com](https://ngrok.com/) and download an install the tool on your system.

## Step 2 - Launch ngrok

With ngrok installed, we can launch it from the command line, but we find the easiest way is to create a batch file we can run at any time.

To create the batch file, open notepad and enter the following:

````
C:\PROGRA~1\ngrok\ngrok.exe http -host-header=rewrite localhost:61191
````

You'll want to swap the local domain / port number at the end according to your sites configuration, but with the contents above, save the file as `ngrok.bat` in the root of your web project. Now, you can run the batch file at any time to launch ngrok and create a publicly accessible tunnel to your website.

![ngrok](/media/screenshots/ngrok.png)

<message-box type="info" heading="Note">

When you launch ngrok for the first time, it will ask you to sign in. Enter the credentials you used to sign up with. It will remember them from now on.

</message-box>

## Step 3 - Test the site

With ngrok running you can now test the site using the URLs displayed in the console window. Use these URLs (preferably the secure https one) for your Stripe [webhook configuration](../../getting-started/configuring-stripe/#webhook) and you should now be able to test your Stripe webhooks locally.

You should see webhook requests displayed in the console window, and you can even debug into them in Visual Studio.