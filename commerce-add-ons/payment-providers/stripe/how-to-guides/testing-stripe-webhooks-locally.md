---
title: How to test Stripe webhooks locally
description: >-
  Learn how to run local tests of the webhooks setup with the Stripe payment
  provider.
---

# How to test Stripe webhooks locally

The Stripe payment provider uses webhooks to finalize payments. Due to this, it can be tricky to test payments locally as Mollie must have a public-facing URL to be able to notify you.

You could expose your website through your network's firewall or use tools that to create temporary tunnels through your network.

The following guide will use [ngrok](https://ngrok.com/) to create temporary tunnels through your network.

## Step 1: Install ngrok

1. Head on over to [ngrok.com](https://ngrok.com/).
2. Download and install the tool on your system.

## Step 2: Launch ngrok

You can either launch ngrok from the command line or use the steps below to create a batch file to be run at any time.

1. Open NotePad.
2. Type the following:

```
C:\PROGRA~1\ngrok\ngrok.exe http --host-header=rewrite localhost:61191
```

3. Swap the local domain/port number at the end according to the configuration of your site.
4. Save the file as `ngrok.bat` at the root of your web project.

You can run the batch file at any time to launch ngrok and create a publicly accessible tunnel to your website.

![ngrok](../../media/ngrok.png)

{% hint style="info" %}
When you launch ngrok for the first time, it will ask you to sign in. Enter the credentials you used to sign up. It will remember them from now on.
{% endhint %}

## Step 3: Test the site

With ngrok running you can now test the site using the URLs displayed in the console window. Use these URLs (preferably the secure `https` one) for your Stripe [webhook configuration](../configuring-stripe.md#step-3-webhook) and you should now be able to test your Stripe webhooks locally.

You will see webhook requests displayed in the console window, and you can debug them using Visual Studio.
