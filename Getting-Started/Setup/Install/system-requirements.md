#System Requirements

##[File & folder permissions](permissions.md)

To ensure a stable and smoothly running Umbraco installation, these permissions need to be set correctly.

##Hosting

###Umbraco 7.x.x

* IIS 7+ (II6 will not work because .NET 4.5 is incompatible with Windows Server 2003)
* SQL CE, SQL Server 2008 and higher or MySQL (must support case insensitive queries)
* ASP.NET 4.5 Full-Trust
* Ability to set file permissions to include create/read/write (or better) for the user that "owns" the Application Pool for your site (NETWORK SERVICE, typically)

###Umbraco 6.x.x

* IIS6+ (IIS 7 Preferred)
* SQL CE, SQL Server 2008 and higher or MySQL (must support case insensitive queries)
* ASP.NET 4
Medium-Trust/Full-Trust (Should work in Medium-Trust environments, but Full-Trust is still preferred)
* Ability to set file permissions to include create/read/write (or better) for the user that "owns" the Application Pool for your site (NETWORK SERVICE, typically)

###Umbraco 4.7.x

* IIS 6+  (IIS 7 Preferred)
* SQL CE, SQL Server 2008 and higher or MySQL (must support case insensitive queries)
* ASP.NET 4, MVC 3
* Medium-Trust/Full-Trust (Should work in Medium-Trust environments, but Full-Trust is still preferred)
* Ability to set file permissions to include create/read/write (or better) for the user that "owns" the Application Pool for your site (NETWORK SERVICE, typically)

###Umbraco 4.6.x (Codename JUNO)

* IIS 6+ (IIS 7 Preferred)
* SQL Server 2005+
* ASP.NET 4
* Medium-Trust/Full-Trust (Should work in Medium-Trust environments, but Full-Trust is still preferred)
* Ability to set file permissions to include create/read/write (or better) for the user that "owns" the Application Pool for your site (NETWORK SERVICE, typically)
* Possible to run in virtual directory, though still recommended not to

###Umbraco 4.5.x

* IIS 6+ (IIS 7 Preferred)
* SQL Server 2005+
* ASP.NET 3.5+ (ASP.NET 4.0 Preferred)
* Medium-Trust/Full-Trust (Should work in Medium-Trust environments, but Full-Trust is still preferred)
* Ability to set file permissions to include create/read/write (or better) for the user that "owns" the Application Pool for your site (NETWORK SERVICE, typically)
* Possible to run in virtual directory, though still recommended not to

###Umbraco 4.0.x

* IIS 6+
* SQL Server 2005+
* ASP.NET 2.0+
* Full-Trust (High-Trust is the minimum; Medium-Trust will not work)
* Ability to set file permissions to include create/read/write (or better) for the user that "owns" the Application Pool for your site (NETWORK SERVICE, typically)
* Virtual directories are not supported

##Browsers
The Umbraco UI should work in all modern browsers:

###Umbraco 7.x.x
* Firefox (Latest)
* Chrome (Latest)
* IE10+ (will not alway work correctly in lower versions)

###Umbraco 4/6
* Firefox (Latest)
* Chrome (Latest)
* IE7+
