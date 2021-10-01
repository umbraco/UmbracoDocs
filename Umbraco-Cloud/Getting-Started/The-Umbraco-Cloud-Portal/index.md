---
versionFrom: 9.0.0
---

# The Umbraco Cloud Portal

The Umbraco Cloud Portal helps you manage your Umbraco Cloud project. From here, you can view and manage all your Cloud projects in one place.

## Umbraco Cloud Portal Overview

When you login to the [Umbraco Cloud Portal](https://www.s1.umbraco.io/home/login/) you will be presented with a view of all the Umbraco Cloud projects you've created or has been added to as a team member.

![View all projects](images/view-projects-v9.png)

By default, the projects are ordered by latest updates - projects you've worked on recently will be shown on top and the ones you haven't worked with for a while are in the bottom. In the top-right corner of the Cloud Portal, you will find:

- **Create New Project** - Allows to create more projects using the plan you wish and a project will be ready for you within a few minutes.

- **Notifications** - You can also see notifications for your different projects. For example: if your project have been automatically updated or if an upgrade has failed.

- **Profile** - Manage profile details, projects, subscriptions, project invites, and organization information.

For quick access, you can *favorite* the projects you are currently working on, to make them appear as the first projects in the view. You can also browse through the projects by using the search field.

## Chat Feature

In the bottom-right corner of the Umbraco Cloud Portal, you'll find a chat-bubble. This is where you will be able to reach out to the Umbraco HQ Support Warriors should you have any questions regarding your Umbraco Cloud projects.

![Chat Feature](images/Chat.png)

With the Starter and Standard plan, you are only entitled to support regarding specific issues regarding the Cloud platform. If you are on a Professional plan, you are entitled to support through the chat regarding implementation and issues with the CMS. For more information on plans and pricing, see [Umbraco Cloud plans](https://umbraco.com/pricing/).

## Profile Options

When you click on the User Profile, you will find options to manage your projects, subscriptions, project invites, organization information, profile details, and log out of the portal.

### Project Management

Managing your individual projects has been made even simpler with Umbraco Cloud. If you go to a particular project, you can get a quick overview of the environments in your project.

![Project Overview](images/project-overview-v9.png)

- Project Name along with the options to **Manage environments**, **Invite User**, or **Settings** section.
- **Git URL** for cloning the environment to your local machine.
- Links to **View errors**, **View page** (frontend), **Go to backoffice**, and the **Environment history**.
- Toggle option for **Debug mode**.
- Option to **Restart environment**, view **Logs**, **Clone project**, and access to **Power Tools (Kudu)**.

While managing the environments on your project, Click on **Manage environments** at the top of the page, and you can add and/or remove environments as needed. Read more about how the number of environments vary depending on the plan you are on, in the [Project overview](../Project-Overview) article.

Aside from these features, it's also from the project view that changes are deployed from one Cloud environment to another - find out more in the [Cloud-to-Cloud](../../Deployment/Cloud-to-Cloud) article.

In the top-right corner, [Settings](../../Set-Up/Project-settings) section, you will find a lot more options to configure your project.

### Manage Subscriptions

Umbraco Cloud subscriptions are managed from the Umbraco Shop, which can be access through [umbraco.com](https://umbraco.com) or by following the **Manage Subcriptions** link on the **Profile** dropdown on the Umbraco Cloud Portal. Find out more in the [Manage Subcriptions](../../Set-Up/Manage-Subscriptions) article.

### Project Invites

On Umbraco Cloud, you can receive invitation from different projects. These project details will be available in the **Project Invite** tab.

### Organizations

On Umbraco Cloud, it is possible to get an organization to manage the projects that you and members of your company creates to get an overview of all of your projects. Find out more in the [Organization](Organizations) article.

### Profile

Profile consists of the following information:

![settings](images/profile.png)

- Name: The name that is displayed on Umbraco Cloud.
- Email: This email address is used for logging in to Umbraco Cloud and will receive email notifications from the Umbraco Cloud Portal.
  :::note
    It is not possible to change this email address at a later point.
  :::

- Telephone: The contact number of the user.
- Edit profile: Allows to update and ensure that your information is valid and up to date for your Umbraco Cloud profile.
  ![Edit profile](images/change-profile-info.png)

- Change Password: Change the password for your Umbraco Cloud account from here.
  ![change password](images/change-password.png)

## Environment error log

Each environment has an error log that appears only if you have any unread errors on that specific environment. You can view the errors by clicking on **View errors** in the environment menu.

Once you're there, you can manually mark each error as read which will move it from the "New" section to the "Read" section. Errors marked as read will be permanently deleted after 30 days.

During development, you can happen to gather a large number of errors which might cause the error page to load very slowly. A fix for that would be to locally connect to the database for that specific environment and delete the errors. You can read more about connecting to the environment database locally in the section about [Database on Umbraco Cloud](../../Databases/Cloud-Database).

Environment errors are stored in the `UCErrorLog` table.

The query below will delete 90% of errors. The query will always delete the oldest errors first. You can tweak the query to delete any percentage of errors by changing the number in the first row.

```sql
DELETE TOP(90) PERCENT
  FROM [dbo].[UCErrorLog]
  WHERE [Read] = 0
```
