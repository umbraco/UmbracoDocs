
# Private Nuget Feed

A private NuGet feed is a package repository that is only accessible to a specific group of users, rather than being publicly available. Private feeds are often used to host internal libraries or proprietary software within an organization. NuGet is a package manager for the Microsoft development platform, including .NET. It makes it easy to add, remove, and update libraries and tools in Visual Studio projects.

In this tutorial, we'll be covering how to set up a private NuGet feed with Umbraco Cloud. 

## Set up

To follow along with this tutorial, you'll need the following tools:

1. Visual Studio
2. A NuGet server (such as ProGet or MyGet)

If you don't already have these tools installed, you can download Visual Studio from the Microsoft website and set up a NuGet server using one of the options listed above.

## Create a package by following

1. https://learn.microsoft.com/en-us/nuget/quickstart/create-and-publish-a-package-using-visual-studio?tabs=netcore-cli


## Create your own MyGet feed by following this documentation

1. https://docs.myget.org/docs/walkthrough/getting-started-with-nuget
2. Remember to create it as private

## Publish your NuGet package to your private MyGet feed

You can do this by going directly to your MyGet feed and upload the NuGet 

or

by following this documentation: https://docs.microsoft.com/en-us/nuget/quickstart/create-and-publish-a-package-using-visual-studio?tabs=netcore-cli#publish-with-the-dotnet-cli-ornugetexe-cli

## Umbraco Cloud

1. Now you need to create an Umbraco Cloud project (V9 or Above)
2. Access the cloud secrets management and add your MyGet credentials: https://docs.umbraco.com/umbraco-cloud/set-up/project-settings/secrets-management
3. Clone down your Umbraco Cloud project
4. Open the project locally and build/spin up the site
5. Go to your NuGet.config file in the root of your project.

Here you need to add some configurations


```csharp
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageSources>
    <add key="nuget.org" value="https://api.nuget.org/v3/index.json" />
	<add key="MyGet" value="https://www.myget.org/F/YourMyGetFeed/api/v3/index.json" />
  </packageSources>

	<packageSourceCredentials>
		<MyGet>
			<add key="Username" value="YourUsername" />
			<add key="ClearTextPassword" value="%MYGET_PASSWORD%" />
		</MyGet>
	</packageSourceCredentials>

  <activePackageSource>
    <add key="All" value="(Aggregate source)" />
  </activePackageSource>
  
</configuration>
```

In the above code example you can see that we are using the Key: "MYGET_PASSWORD" that we created in the previous step using the Cloud Secrets Management feature on Umbraco Cloud. 


6. Push this to your Umbraco Cloud project. 


Congratulations, you've successfully set up a private NuGet feed with Umbraco Cloud using the cloud secrets management feature! You can now use this feed to host and manage your own internal libraries or proprietary software. If you want to learn more about NuGet and how to use it, check out the official NuGet documentation.
