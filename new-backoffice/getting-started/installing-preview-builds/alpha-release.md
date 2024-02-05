# Requirements

## Requirements

### Browsers <a href="#browsers" id="browsers"></a>

The Umbraco UI works in all modern browsers:

* Chrome (Latest)
* Edge (Chromium)
* Firefox (Latest)
* Safari (Latest)

### Local Development <a href="#local-development" id="local-development"></a>

* One of the following OSs:
  * Microsoft Windows 10 or 11
  * MacOS High Sierra 10.13
  * Linux (Ubuntu, Alpine, CentOS, Debian, Fedora, openSUSE, and other major distributions)
* One of the following .NET Tools or Editors:
  * ​[Visual Studio Code](https://code.visualstudio.com/) with the [IISExpress extension](https://marketplace.visualstudio.com/items?itemName=warren-buckley.iis-express)​
  * ​[Microsoft Visual Studio](https://www.visualstudio.com/) 2022 v17.4
  * ​[JetBrains Rider](https://www.jetbrains.com/rider) **version 2022.3 and higher**
  * .NET Core CLI
* [.NET 8.0 Software Development Kit (SDK)](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)
* SQL connection string (SQL Server or SQLite)

When using Visual Studio as your primary Integrated Development Environment (IDE) we recommend finding and downloading the [Software Development Kits (SDKs) ](https://dotnet.microsoft.com/en-us/download/visual-studio-sdks)for Visual Studio.

### Hosting <a href="#hosting" id="hosting"></a>

#### Recommendation <a href="#recommendation" id="recommendation"></a>

For the best experience, we would recommend that you ensure your hosting environment has the following to run Umbraco CMS:

* Windows Server 2019 and higher
* IIS 10 and higher
* SQL Server 2019 and higher
* .NET 8.0
* Ability to set file permissions to include create/read/write (or better) for the user that "owns" the Application Pool for your site (NETWORK SERVICE, typically)

You can use [Umbraco Cloud](https://umbraco.com/products/umbraco-cloud/) to manage the hosting infrastructure. All Umbraco Cloud plans are hosted on Microsoft Azure, which gives your site a proven and solid foundation.

#### Minimum requirements to run Umbraco <a href="#minimum-requirements-to-run-umbraco" id="minimum-requirements-to-run-umbraco"></a>

Umbraco can run on an environment with the minimum requirements stated below:

* Windows Server 2012 R2 and higher
* IIS 8.5 and higher
* SQL Server 2012 and higher / SQLite 3.38.0 or higher
* .NET 8.0
* Ability to set file permissions to include create/read/write (or better) for the user that "owns" the Application Pool for your site (NETWORK SERVICE, typically)
