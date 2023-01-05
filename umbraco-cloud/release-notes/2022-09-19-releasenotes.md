# Release Notes, September 2022

## Key Takeaways

* **2FA authentication** - You can now secure your Umbraco Cloud account by enabling 2-factor authentication (2FA). Select between email, phone, or app authentication.
* **US Region Hosting** - From the 1st of September, you can select a brand new US region in addition to the existing West Europe option.
* **Projects Dashboard** - The first version of the Projects Dashboard has been released. Organize your Umbraco Cloud projects as per your preference and get a complete overview of product versions in all your environments.

## [2FA authentication](../set-up/2-factor-authentication-on-cloud.md)

On Umbraco Cloud, you can add 2-factor authentication in a few steps for your Umbraco Cloud account.

You can either use **email**, **phone**, or an **authenticator app** when logging in to the Cloud Portal.

To enable 2FA for Umbraco Cloud, go to **Profile**, click **Edit Profile**, and select the **Multifactor Authentication Method** from the drop-down list.

![2FA-Registration](images/2FA-Registration.gif)

2FA code can be sent either to your email or as a text message on your phone. Alternatively, you can use an authentication app such as Google Authenticator, Authy, or similar.

![Phone-auth](../set-up/images/Phone-auth.png)

As your Umbraco profile is used to log in to the backoffice for your projects, these are all now protected with 2FA.

## US Region Hosting

Until now, Umbraco Cloud has been exclusively hosted in the West Europe region on Azure. Including **East US** as an option and offering regional hosting to agencies, partners, and end-clients located in the US is a big milestone.

You can select which region you would like to host your Umbraco Cloud project while creating a new Cloud project.

![USRegionRegistration](images/USRegionRegistration.gif)

As excited as we are about making Umbraco Cloud available in the US, we also have the ability to expand to **new regions**. If you have specific requests regarding the next region you want Umbraco Cloud to expand to, let us know at product@umbraco.com.

See the blog article [Umbraco Cloud expands with US regional hosting](https://umbraco.com/blog/umbraco-cloud-expands-with-us-regional-hosting/) for more information.

## Projects Dashboard

Have you tried the new Projects Dashboard yet? The first official version of the dashboard has been released.

Currently, you can find a link in the project's overview. Soon the Projects Dashboard will be the default landing page after logging into Umbraco Cloud Portal.

By clicking on “Edit groups”, you can sort projects into groups with the drag-drop functionality to organize your Cloud and Heartcore projects.

After saving your projects, you can choose between a detailed view with relevant information for your projects such as environments, product versions, and bandwidth/media storage usage, or a more compact view with less information. You can decide by using the “Settings” option.

![ProjectsDashboardV1](images/ProjectsDashboardV1.gif)

You can try out the Projects Dashboard on https://www.s1.umbraco.io/projectsdashboard and start grouping the Cloud projects as per your preference. We will add new features and functionality to the dashboard in future releases starting with a filtering system as one of the next new additions.
