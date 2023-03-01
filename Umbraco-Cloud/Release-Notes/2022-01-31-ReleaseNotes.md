# Release Notes, January 31, 2022

_Blob storage connection info + Copy project invitation link + Release notes link in portal_

## Key Takeaways

- **Blob storage connection info** - The blob storage connection info for a project is now displayed on the _Connection details_ page.
- **Project invitation link to clipboard** - To ease the project invite flow if a project invitation mail is bounced or accidentally lands in the spam folder you can now copy the invitation link to your clipboard.
- **Release notes link in the portal** - As you are reading these pages you might already have noticed the new item in the profile menu of the portal; a link to the portal release notes.

### [Blob storage connection info](..\Set-Up\Media\Connect-to-Azure-Storage-Explorer)

The blob storage connection info for a project was previously only displayed in Kudu which was not very convenient or easy to find. A developer should spend as much time as possible developing fantastic solutions and less time in Kudu.
Therefore this connection info is now easy to **_copy directly from the portal_** and ready to post into _Azure Blob Explorer_ whenever needed.

![BlobStorage](https://user-images.githubusercontent.com/93588665/151602205-2784ec6c-1142-4221-9bf4-0ba9727ff8f6.gif)

### Project invitation link to clipboard

The project invitation flow in Umbraco Cloud Portal has until recently suffered from invites ending up in the invitees' spam folder. We have now **_optimized_** the configuration of the portal _**email delivery**_ so every invite should now be delivered to the expected receiver - in the correct inbox.

However, there can be exceptions where an email is either bounced or lands in the spam folder. In such cases, a resend of the project invitation might not do the trick. So to ease the invite process, in the rare case the email doesn’t show up, we have added the option to **_copy the project invitation link_** for active invites.

![CopyProjectInviteLink](https://user-images.githubusercontent.com/93588665/151602357-1bd4b165-eb4d-44b5-bc88-b45594ae5dc0.gif)

### Release notes link in the portal

In 2021 we added several new team members to the Cloud Feature team to support our strategy of making Umbraco Cloud [the best way](https://umbraco.com/blog/umbraco-2022-and-onwards/) to host Umbraco solutions. In 2022 and the years to come we will continue our _**customer-centric development**_ and with an increased focus on input from partners and portal users improve existing functionality and create new exciting features.

In order for agencies and users to keep up with the improvements, we’ve made it easy to find the latest release notes. You can now find the link for the release notes in the profile settings menu. Release notes will be published multiple times each month and list the most relevant fixes and features added to the portal.
