# January 6, 2022  Release Notes

_Break project reference + See project information + Various improvements_

### Key Takeaways
- **Break reference between baseline and child project** - As an admin you can now break the reference between a baseline and child projects
- **New Project Overview Page** - See the project information such as plan, payment status for your project on the new project overview page.
- **Various tweaks and improvements** - We have since December provided a lot of small changes and improvements.

### [Break reference between baseline and child project](https://our.umbraco.com/documentation/Umbraco-Cloud/Getting-Started/Baselines/Break-baseline/)
Umbraco Cloud Portal offers a powerful baseline-child relationship between projects. It is very similar to a fork (forked repository) on GitHub in that we create a clone of an existing project while maintaining a connection between the two projects.

If you at some point **want to break this connection** between the baseline and one of its child projects it is now really easy for a user with the role of admin to do so. But please be aware that the **action can not be undone**.

![Break reference between baseline and child project (1)](https://user-images.githubusercontent.com/93588665/149168277-e7ffb2e1-34c3-411f-9962-e834150f62d1.gif)

### [New Project Overview Page](https://our.umbraco.com/documentation/Umbraco-Cloud/Getting-Started/#project-overview)
You are now able to access a simple project overview page for each of your projects. Initially are able to see basic information such as name, alias, **plan and project status**. In the future we are likely to add more general project related information that currently isn’t presented in the portal and isn’t too specific to be shown on the more detailed subpages.

![New Project Overview Page](https://user-images.githubusercontent.com/93588665/149168523-088b58f1-5a04-43ff-9ac5-f30b62c74e4e.gif)

### Various tweaks and improvements
We have during December provided a lot of small improvements to the Umbraco Cloud Portal. Actually too many to mention, so we will restrict ourselves to only mention a few of these in the bullet list below.

- Alignment and consistent order of versions on the project page
- Confirmation box for restarting environment (to avoid accidental restarts)
- Requirement to add technical contact for project prior to creation (every project should always have at least one technical contact)
- Alerts in portal when profile is missing phone number or when a project is missing a technical contact (to highlight missing contact information)
