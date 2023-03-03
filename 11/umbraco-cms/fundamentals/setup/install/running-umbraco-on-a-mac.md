---
description: "Since Umbraco 9 it has been possible to run Umbraco CMS natively on Mac Os."
---

# Running Umbraco on a Mac

With Umbraco CMS on .NET Core, Mac OS is natively supported with SQLite as the database.

In the below section, we describe how to get started with running Umbraco CMS on Mac.

## How to get started

To get started with Umbraco CMS on Mac OS first have a look at the [requirements for running Umbraco CMS with Mac OS](../requirements.md).

Once you've made sure you meet the requirements it is time to install the Umbraco Templates on your system.

This can be done by following the [Install using .NET CLI](install-umbraco-with-templates.md) guide.

with the templates installed on your system, it is now possible to create Umbraco projects.

To create a project, there is now two options:
- Continue creating projects using the .NET CLI.
- Create new projects using Visual Studio.

To create new projects using Visual Studio, you can use the [Install using Visual Studio](visual-studio.md) guide to do so.

Once you create a new project by default it will use SQLite.

If you want to use an SQL server database, you will need to [set up Docker](https://creativewebspecialist.co.uk/2021/09/07/how-to-run-netcore-umbraco-cms-on-a-macbook/) to be able to use SQL Server.