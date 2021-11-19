---
versionFrom: 9.0.0
verified-against: alpha-4
state: complete
updated-links: true
---

# Minimum System Requirements

## Browsers

The Umbraco UI should work in all modern browsers:

* Chrome (Latest)
* Edge (Chromium)
* Firefox (Latest)
* Safari (Latest)

## Local Development

* Either OS:
  * Microsoft Windows 7 SP1, 8.1, 10 and 11
  * MacOS High Sierra 10.13
  * Linux (Ubuntu, Alpine, CentOS, Debian, Fedora, openSUSE and other major distributions)
* One of the following .NET Tools or Editors:
  * [Visual Studio Code](https://code.visualstudio.com/) with the [IISExpress extension](https://marketplace.visualstudio.com/items?itemName=warren-buckley.iis-express)
  * [Microsoft Visual Studio](https://www.visualstudio.com/) 2019 **version 16.8 and higher**
  * [JetBrains Rider](https://www.jetbrains.com/rider) **version 2020.3 and higher**
  * .NET Core CLI
  * etc.
* .NET 5.0
* SQL connection string (SQL Server)

## Hosting

* IIS 8 and higher
* SQL Server 2012 and higher
* .NET 5.0
* Docker
* Ability to set file permissions to include create/read/write (or better) for the user that "owns" the Application Pool for your site (NETWORK SERVICE, typically)

*For more information, check the official Microsoft documentation for [Hosting and deploying ASP.NET Core applications](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/?view=aspnetcore-5.0)*