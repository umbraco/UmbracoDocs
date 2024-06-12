# Heartcore Core Dependency Upgrade

From July through to the end of August 2024 there is a planned major migration for all Heartcore sites created prior to 12th February 2024. This article will help you understand what to expect from it.

## Benefits
In addition to a range of quality-of-life improvements and bug fixes, after the upgrade you can expect to see the following features:
* Support for the Block Grid Editor for managing two-dimensional content layouts.
* Rich text editor enhancements.
* Management API support for property type configuration.
* Better backoffice performance across the board.

For more information about these and other changes, take a look at the release notes for [February](./2024-02-releasenotes.md) and [April](./2024-04-releasenotes.md).

## What to Expect
Your project will be scheduled for upgrade in either July or August. You will receive a notification approximately two weeks prior, with the morning or afternoon of a specific day on which the migration will happen.

The migration will cause a brief partial disruption to service and also contains one breaking change that will affect some sites.

### During Maintenance
You can expect the following services to be affected for approximately one hour during the migration:
* **CMS backoffice** - Users will be unable to log in and author changes to settings, content, and media.
* **Management API** - Applications will be unable to call Management API endpoints. This also impacts the form submission endpoint, which will return HTTP 500-series error responses during the outage window.

### After Maintenence
After the migration ***some*** non-ASCII characters in content URLs will be substituted with a different ASCII character sequence in the new version.

{% hint style="danger" %}
**This is a breaking change.** Unless your application has been built with redirection in mind, then external links to affected content items may no longer work post-migration.
{% endhint %}

The following table compares new and old behavior for all changes. This is not a list of all characters that are substituted, rather it is a list of those with changed behavior.

| Character | Previous Substitution | New Substitution |
| ä         | a                     | ae               |
| Ä         | a                     | ae               |
| å         | a                     | aa               |
| Å         | a                     | aa               |
| ø         | o                     | oe               |
| Ø         | o                     | oe               |
| ö         | o                     | oe               |
| Ö         | o                     | oe               |
| ü         | u                     | ue               |
| Ü         | u                     | ue               |

This change will only affect the URLs generated when content is published. It will not affect media, nor will it affect the property values of content.

The Redirect API will contain a reference to the pre-migration URL for each item. In order for your applications to seamlessly handle the change, it is recommended they query this API to determine if a URL has changed. If so, they should serve an HTTP 301 - Permanent Redirect response to the new URL.

If your applications will be affected by this change and you need to know more, please reach out via a support ticket.