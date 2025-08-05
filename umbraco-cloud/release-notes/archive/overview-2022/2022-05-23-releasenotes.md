# May 2022

## Highlight Video

{% embed url="https://youtu.be/U9p0jg1ZDqg" %}
Cloud highlights May 2022
{% endembed %}

## [CDN Caching and Optimization settings](../../../optimize-and-maintain-your-site/optimize-performance/manage-cdn-caching.md)

In the Umbraco Cloud portal, you can now enable **caching**. This will ensure that static resources such as JavaScript, CSS, and images are cached in the **Content Delivery Network** (CDN) used by Umbraco Cloud.

The feature enables you to set default settings for caching, cache Time To Live (TTL), minification of CSS, JavaScript, and HTML for your Cloud projects. If you prefer an alternative caching strategy to the default this can be done in **CDN Caching and Optimization** in the project's **Setting** menu.

![CDCachingAndOptimization](../../images/CDCachingAndOptimization.gif)

You can likewise specify when the cache is to be purged to evict everything from the cache on a specific hostname and force a refresh.

For more information and tips and tricks for handling caching, minification, and purging of your cache visit the documentation page.

## Improved Organization Invite flow

The organization pages have received a facelift and are now based on the Umbraco UI Library web components. In the updated overview, you will find the organization information, members, pending invites, projects of your organization, and the access rights granted to members of the organization

![Members](../../images/Members.png)

We have also added a new flow for inviting a user to an organization, where the user must accept an invitation before the user becomes a member. You already know this flow from inviting a user to a cloud project.

![PendingOrgInvite](../../images/PendingOrgInvite.png)

When a Umbraco Cloud portal user receives an invitation they can accept or decline the invitation on the “Pending invites” profile page.

## Media Storage Files Top 50

On the “Usage” page of a Cloud project, we have added an option for you to see the top 50 media files that **take up the most storage space** in the blob storage of your project. The feature helps you to get an overview of which media files are candidates for deletion if you are running out of blob storage.

![Top50MediaFiles](../../images/Top50MediaFiles.gif)

The sorted list is a real-time display of media files including file name, path, size, and type. If you delete one or more of the listed files in the backoffice or the blob storage refresh the page and select the option to load the media files again.
