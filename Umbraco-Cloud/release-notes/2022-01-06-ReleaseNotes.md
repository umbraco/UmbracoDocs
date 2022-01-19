# Release Notes, January 06, 2022

_Break baseline reference + See project information + Various improvements_

### Key Takeaways
- **Break reference between baseline and child project** - As an admin, you can now break the reference between a baseline and child projects.
- **New Project Overview Page** - See project information such as plan, payment status for your project on the new project overview page.
- **Various tweaks and improvements** - Since December we have provided a lot of small changes and improvements.

### [Break reference between baseline and child project](https://our.umbraco.com/documentation/Umbraco-Cloud/Getting-Started/Baselines/Break-baseline/)
Umbraco Cloud Portal offers a powerful baseline-child relationship between projects, similar to a fork (forked repository) on GitHub. With this feature you can create a clone of an existing project while maintaining a connection between the two projects.

If you at some point **want to break this connection**, between the baseline and one a child project, it is now really easy for a user with the role of admin to do so. Please be aware that the action **cannot be undone**.

![Break reference between baseline and child project (1)](https://user-images.githubusercontent.com/93588665/149168277-e7ffb2e1-34c3-411f-9962-e834150f62d1.gif)

### [New Project Overview Page](https://our.umbraco.com/documentation/Umbraco-Cloud/Getting-Started/#project-overview)
You are now able to access a simple project overview page for each of your projects. Initially are able to see basic information such as name, alias, **plan and project status**. In the future, we are likely to add more project related information that currently isn’t presented in the portal.

![New Project Overview Page](https://user-images.githubusercontent.com/93588665/149168523-088b58f1-5a04-43ff-9ac5-f30b62c74e4e.gif)

### Various tweaks and improvements
During December we have provided a lot of small improvements to the Umbraco Cloud Portal. Actually too many to mention, you can find a few of the highlights in the list below.

- Alignment and consistent order of product versions on the project page.
- Confirmation box for restarting environment (_to avoid accidental restarts_)
- Required technical contact details for projects prior to creation (_so every project always has at least one technical contact_)
- Alerts in the portal when a profile does not have a phone number or when a project does not have a technical contact associated (_contact information is important in case there are issues related to a project or a profile_).
