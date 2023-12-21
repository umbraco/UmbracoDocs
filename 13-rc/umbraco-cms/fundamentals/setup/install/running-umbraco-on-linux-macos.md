---
description: "Since Umbraco 9 it has been possible to run Umbraco CMS natively on Linux or macOS High Sierra 10.13 and newer."
---

# Running Umbraco on Linux or macOS

With Umbraco CMS on .NET Core, Linux and macOS is natively supported with SQLite as the database.

In the below section, we describe how to get started with running Umbraco CMS on Linux or macOS.

## How to get started running Umbraco CMS on Linux or macOS

To get started with Umbraco CMS first have a look at the [requirements for running Umbraco CMS](../requirements.md#local-development).

Once you've made sure you meet the requirements it is time to install the Umbraco Templates on your system.

To do this follow the [Install using .NET CLI](install-umbraco-with-templates.md#install-the-template) guide.

With the templates installed on your system, it is now possible to create Umbraco projects.

To create a project, there are two options:

- Continue creating projects using the .NET CLI.
- Create new projects using Visual Studio (only macOS).

To create new projects using Visual Studio, you can use the [Install using Visual Studio](visual-studio.md) guide.

Once you create a new project it will use SQLite by default on Linux/macOS.

If you want to use an SQL server database, you will need to [set up Docker](https://creativewebspecialist.co.uk/2021/09/07/how-to-run-netcore-umbraco-cms-on-a-macbook/).
