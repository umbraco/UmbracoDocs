---
title: How to test Mollie webhooks locally
description: >-
  This guide will take you through setting up and testing local tests of Mollie
  Webhooks.
---

# How to Test Mollie Webhooks Locally

Mollie uses webhooks to finalize payments, but testing them locally can be challenging because Mollie requires a public-facing URL to send notifications. Local URLs like `http://localhost:3000` or `http://localhost:8080` are not accessible from the internet.

**Solution: Use a Local Tunnel**

A local tunnel is a port-forwarding technique that exposes a local API service (running on a specific port) to the internet through a public HTTPS URL. This allows you to:

1. Make your local server accessible online temporarily.
2. Use the generated public URL in Mollie’s webhook settings.
3. Receive webhook events directly on your local development machine.

With a local tunnel, you can test and debug Mollie webhooks without deploying your application to a live environment. Here are two popular tools to create a secure public URL for testing Mollie webhooks:

1. [Ngrok](https://ngrok.com/?utm_source=docs.umbraco.com) is a widely used tool that creates a secure tunnel from your local machine to a public URL. It supports advanced configurations and works well with webhook-based systems.
2. [Beeceptor’s Local Tunnel](https://beeceptor.com/local-tunnel/?utm_source=docs.umbraco.com) gives a public HTTP mock server that allows you to expose your local server to the internet securely. Supports HTTPs, mock rules and comes with request history. 

The following guide will use [ngrok](https://ngrok.com/?utm_source=docs.umbraco.com) to create temporary tunnels through your network.

## Step 1: Install ngrok

1. Head on over to [ngrok.com](https://ngrok.com/?utm_source=docs.umbraco.com).
2. Download and install the tool on your system.

## Step 2: Launch ngrok

You can either launch ngrok from the command line or use the steps below to create a batch file to be run at any time.

1. Open NotePad.
2. Type the following:

```
C:\PROGRA~1\ngrok\ngrok.exe http -host-header=rewrite localhost:61191
```

3. Swap the local domain/port number at the end according to the configuration of your site.
4. Save the file as `ngrok.bat` at the root of your web project.

You can run the batch file at any time to launch ngrok and create a publicly accessible tunnel to your website.

![The ngrok UI.](../../media/ngrok.png)

{% hint style="info" %}
When you launch ngrok for the first time, it will ask you to sign in. Enter the credentials you used to sign up. It will remember them from now on.
{% endhint %}

## Step 3: Test the site

With ngrok running you can test the site using the URLs displayed in the console window. The Mollie gateway will automatically be able to communicate back to your site instance.

You will see webhook requests displayed in the console window, and you can debug them using Visual Studio.
