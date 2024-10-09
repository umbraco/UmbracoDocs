---
description: Read about the new features released on Umbraco Cloud in september 2024.
---

# September 2024

## Secret management is available on all cloud plans

Secrets Management on the cloud helps developers securely store sensitive data like API keys and passwords, reducing the risk of exposure. It simplifies access control, automates credential updates, and makes deployments safer and easier.

Until now, this feature has only been available on Standard and Professional plans, but now it is also available on Starter plans on Umbraco Cloud.&#x20;

Starter plans can utilize 5 Secrets pr. Project.

For more information about the Secrets Management feature see the [Secrets Management documentation](https://docs.umbraco.com/umbraco-cloud/set-up/project-settings/secrets-management).

## Show progress in the Cloud Portal when running automated patch upgrades

We have enhanced the user experience for automatic upgrades in Umbraco Cloud by introducing real-time progress tracking directly in the UI. Now, when an upgrade is in progress, users will be able to see its status and follow along. This provides greater transparency and keeps you informed about the process at every step. No more guessing or waiting in the dark—stay updated as your project moves to the latest version.

<figure><img src="https://lh7-rt.googleusercontent.com/docsz/AD_4nXeHLyuC5E6SuYDPF3HZh33E7DHKNlX4Zrj3jknEPCA-76eFKQuSOwWHMqBeRTSRLzFB3FA2jFNz6Kz0cM683dY7os4tjMZvtB4DM8rxaoKjCfvSAPIC70JXNcjhaTcPPmXNgF7EpdTkLwUpE4XjrE3gOZJh?key=SlsmlhRYGNANsP-KfBECSQ" alt=""><figcaption></figcaption></figure>

## Improved feedback on deployment errors

When doing deployments between environments in the Cloud Portal, we will now surface all the available logs we have, upon failure. This means all the technical details we can collect, should help in the debugging process.&#x20;

(this means Umbraco Deploy error logs have surfaced, and you will be able to see these on failed Deploy operations)

## Certificate Authority Change for Umbraco Cloud Hostnames and Umbraco ID&#x20;

As announced on our [Status Page](https://status.umbraco.io/incidents/r18sch1jgxdh) we have successfully upgraded our CA to Google Trust services. This change ensures continued support for all clients, particularly older Android devices (pre-2016 models), which represent 2.96% of Android users.&#x20;

\
