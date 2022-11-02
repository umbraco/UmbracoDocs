# Release Notes, March 2, 2022

_Backoffice user group selection + Outgoing IPs for Heartcore webhooks + Bandwidth usage top 10 (Beta)_

## Key Takeaways

- **Backoffice user group selection** - When inviting a new team member to a project you can now assign a backoffice user group for each environment as part of the invite workflow.
- **Outgoing IPs for Umbraco Heartcore webhooks** - Is one or more of your Heartcore projects using the webhook feature and is this communication going through a firewall? Then you should consider the new two static outgoing IPs.
- **Bandwidth usage top 10 (Beta)** - Do you want insight into which web page caused the most bandwidth in your Cloud project use? Then go visit the updated usage page and see the top 10 of HTTP referers.

### Backoffice user group selection

On the project invites page users will now see more details for their project. As a user, you will see the **expiration date** of the invite, its **status**, and you are able to **remove** the ones that have expired.

![ProjectInviteBackofficeUserGroups](https://user-images.githubusercontent.com/93588665/156560264-58468507-9a88-4831-ba3b-42ec71cbe83a.gif)

This feature completes the planned improvements of the project invite flow. It has never been easier to invite portal users or backoffice users from the Umbraco Cloud Portal. Try it today!

### Outgoing IPs for Umbraco Heartcore webhooks

Webhooks for Umbraco Heartcore projects are now fired from either of the two static IPs listed below.

![image](https://user-images.githubusercontent.com/93588665/156560443-93d1a81a-ac7a-460f-b8cc-351409782fe4.png)

These two static outgoing IPs make it possible to allow webhook communication to bypass firewall restrictions for any external services. If you need to use a CIDR (Classless Inter-Domain Routing) Range for the IPs: 20.86.53.156/31.

### Bandwidth usage top 10 (Beta)

When your Umbraco Cloud project is the expected success and has hundreds or even thousands of daily visitors your projects might start using more bandwidth than you are expecting.

On the _Usage_ page of a project, you will now see a top 10 of the HTTP **referers causing the most bandwidth**. A referer is the name of an optional HTTP header field that identifies the address of the web page, from which the resource has been requested. It is the bandwidth generated from these resource requests that counts in the monthly usage limit of the project.

You can use this insight of pages generating the most bandwidth to see where optimization and minimizing the file size of resources will have the most impact.

![Top10BandwidthReferers](https://user-images.githubusercontent.com/93588665/156560697-0dcc10f4-e252-43e4-bf44-fe78ef6a150b.png)

The top 10 bandwidth usage for referrers is currently launched as a **beta** version as the bandwidth listed does not always match the total bandwidth shown for the project. We will update you when the list offers 100% trusted bandwidth values.
