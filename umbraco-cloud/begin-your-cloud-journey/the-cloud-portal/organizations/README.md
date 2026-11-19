# Organizations

On Umbraco Cloud, it is possible to set up an Organization. An organization is handy if you are managing many projects for different customers. It is also handy if you need to manage permissions for multiple users (such as developers and content editors.

With an organization, you get an overview of all projects and members that are part of it. You can also manage payment methods for projects, as well as many other functions outlined on this page.

In the following sections, we will go through the different options that are available to an Organization:

<figure><img src="../../../.gitbook/assets/org-menu-overview.png" alt="Organization Overview"><figcaption><p>Organization Overview</p></figcaption></figure>

{% hint style="info" %}
Are you interested in getting an organization, or need a project added to a different organization? Please reach out to the Support Team in the small chat box in your [project overview](https://www.s1.umbraco.io/projects).
{% endhint %}

## Overview

### Information

In the **Information** section of the Organization, you can find all the details about your Organization. If there are any changes to your details, you can change them here.

![Information](../../../.gitbook/assets/Information-v10.png)

### Members

In the **Members** section, you can view current members, pending invites, and see the Multi-Factor Authentication (MFA) status for the Members of your Organization. You can also set up different permissions for your Members, such as Read, Write, and Administrators for your organization by adjusting their **Roles**.

<figure><img src="../../../.gitbook/assets/members-new.png" alt=""><figcaption></figcaption></figure>

Members added to your organization can see different details about their organization based on the user group they are added to. Currently there are three different groups, **Read**, **Write** and **Admin**. Below you can see what each user group has access to under the organization they are a part of.

Organization Members with **Admin Access** can do the following in the organization:

* Update the organization's information
* Invite others to the organization
* Invite Users to project under the organization
* Edit organization team
* See pending invitations
* See organization information
* See organization projects
* See payment history
* See subscriptions
* See organization Members
* See payment history
* Handle Multi-Factor Authentication (MFA) for users
* Handle payment methods
* Change permissions for Members
* Remove role from users

Organization members with **Write Access** can do the following in the organization:

* See Organization information
* See Organization Members
* Invite to the organization
* See pending invitations

Organization Members with **Read Access** can do the following in the organization:

* See Organization information
* See Organization Members

{% hint style="info" %}
Being a Member of an organization does not give access to any projects under it. To get access to a project under an organization, you need to be [invited](../../project-features/users-on-cloud.md) to the project. This can be done by either someone who is already part of the project or an administrator in your organization.
{% endhint %}

### Multi-Factor Authentication (MFA) enforcement

When working in organizations on Umbraco Cloud, as a company, you can enforce a certain type of Multi-Factor Authentication (MFA) method for members.

![MFA for members](../../../.gitbook/assets/mfa-page.png)

Administrators of Organizations on Umbraco Cloud can enforce MFA for specific members of their organization.

To enforce a certain MFA for a member, follow these steps:

1. Go to the **Organizations** tab under your user on Umbraco Cloud.
2. Go to the **Members** tab under Organization.
3. Go to **Multi-Factor Authentication**.
4. Find the member that needs to have MFA enabled.
5. Click on the cogwheel and select the **Enforced MFA Method** from the drop-down list for the member.

Once it has been enabled, the next time the member logs in, they will be forced to setup the chosen Multi-Factor Authentication (MFA) method. It is possible for an administrator to reset the authenticator app settings for members of the organization.

### Projects

In the **Projects** section, you can get an overview of all the Projects that have been created in your Organization.

![The organization Projects list showing the Umbraco version, hosting type, and ownership of each project](../../../.gitbook/assets/organization-projects-list.png)

For each project, the list shows the following:

* The Umbraco version running on the live environment.
* The project type and plan.
* The hosting type, which is either **Shared** or **Dedicated** followed by the size of the dedicated option.
* The project status and payment status.
* The creation date, region, and number of environments.
* The ownership. The `PAY` and `TECH` labels show whether your organization is the payment owner and the technical owner of the project.

The project name links to the project page for the projects where you are a team member.

As an administrator, you can invite members of your organization to the different projects under the organization.

### Access Rights

In the **Access Rights** section, you can get a list of all the Access Rights your Members have to each Project in your Organization.

![Access Rights](../../../.gitbook/assets/Access_rights-v10.png)

## Finance

<figure><img src="../../../.gitbook/assets/org-menu-finance.png" alt="Finance section"><figcaption><p>Finance section</p></figcaption></figure>

### Payment methods

In the **Payment Methods** section, you can add and remove credit cards for your organization. The primary card pays for all subscriptions in the organization. For more information, see the [Payments](../payments.md) article.

![The Payment methods page with the primary card and a second card](../../../.gitbook/assets/payment-methods.png)

### Payment History

In the **Payment History** section, you can see the invoices for your organization and download paid invoices. For more information, see the [Payments](../payments.md) article.

## Insights

<figure><img src="../../../.gitbook/assets/org-menu-insights.png" alt="Insights section"><figcaption><p>Insights section</p></figcaption></figure>

### Sustainability

The Sustainability Dashboard is designed to help users monitor and improve the environmental impact of their websites on Umbraco Cloud. For more information, see the [Sustainability Dashboard](../../../optimize-and-maintain-your-site/monitor-and-troubleshoot/sustainability-dashboard.md) article.

### Alerting & Notifications

Organization admins can create alert rules that cover all projects in the organization, or a selection of projects. Alerts are sent by email or webhook for events such as failed deployments, upgrades, and DDoS attacks. For more information, see the [Alerting and Notifications](../../../optimize-and-maintain-your-site/monitor-and-troubleshoot/alerting-and-notifications/README.md) article.

## Login Providers

<figure><img src="../../../.gitbook/assets/org-menu-login-providers.png" alt="Login Providers section"><figcaption><p>Insights section</p></figcaption></figure>

The **Login Providers** section enables you to configure access to the Umbraco Cloud Portal and Projects.

The section also offers the possibility to follow Sign-ins and changes to Login Provider configurations.

Learn more about Login Providers for your Organization in the [Organization Login Providers](organization-login-providers.md) article.
