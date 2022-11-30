# Release Notes, February 15, 2022

_Improved pending invite status + View backoffice user groups for team members + Usage limit warnings_

## Key Takeaways

- **Improved pending invite status** - Users with pending project invites can see an expiration date, status and option to delete expired invites.
- **View backoffice user groups for team members** - A step in improving backoffice user group handling is to display the current groups for all project team members on the project team edit page.
- **Release notes link in the portal** - The portal now shows a warning for projects that have exceeded 90% of its usage limit for bandwidth or media storage.

### Improved pending invites view

On the project invites page users will now see more details for their project. As a user, you will see the **expiration date** of the invite, its **status**, and you are able to **remove** the ones that have expired.

![image](https://user-images.githubusercontent.com/93588665/154243203-dbdd9194-24fe-4595-9237-9344d34ace58.png)

We recently launched the same details for the pending invites shown on the team edit page of a project. Now a similarly detailed view is available for pending project invites.

### View backoffice user groups for team members

Project team members will now see the **actual user group memberships** of the project’s backoffice users. This is an improvement to the previous listing where only the default backoffice user group for each backoffice user was shown.

![image](https://user-images.githubusercontent.com/93588665/154243255-02a21db2-8958-47cb-94b2-f4045153ce86.png)

In the near future we will enable portal users to specify the backoffice user groups that the invitee should have as default to ease the onboarding process of new backoffice users.

### Usage limit warnings

Each project in Umbraco Cloud Portal has a set of **usage limits** depending on which plan the project is on. The usage limits for Cloud and Heartcore projects can be seen [here](https://umbraco.com/umbraco-cloud-pricing/) and [here](https://umbraco.com/umbraco-heartcore-pricing/), respectively. The current usage of a project can be seen on the project usage page, available from the Project Settings menu.

You will now be notified in the portal when either the media storage or bandwidth usage of a project has exceeded the 90%. Initially, you will see a **tag on the project page** if either the bandwidth or the media storage has exceeded 90% of the plan limits. The example below shows a project with both usage limits crossed.

![WarningsTagsOnProject](https://user-images.githubusercontent.com/93588665/154242785-5d9533b4-b9fc-4223-856a-3701cde12146.gif)

More features for plan limits and for bandwidth usage in particular will be launched on the portal shortly. So stay tuned!
