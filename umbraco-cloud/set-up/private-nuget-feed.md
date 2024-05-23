# Private NuGet Feed on Umbraco Cloud

A private NuGet feed is a package repository that is only accessible to a specific group of users, rather than being publicly available.

Private feeds are often used to host internal libraries or proprietary software within an organization.

NuGet is a package manager for the Microsoft development platform, including `.NET`. It gives you the ability to add, remove, and update libraries and tools in Visual Studio projects.

In this tutorial, we'll be covering how to set up a private NuGet feed with Umbraco Cloud.

## Prerequisite

To follow along with this tutorial, you'll need the following tools:

1. [Visual Studio](https://visualstudio.microsoft.com/downloads/)
2. A NuGet server such as [MyGet](https://www.myget.org/)
3. An Umbraco Cloud project on a standard plan or higher

## Step 1: Create a NuGet package

The first part of this tutorial is to create and publish a NuGet package using Visual Studio.

To create and publish a NuGet package with Visual Studio, you will need to follow the [Microsoft Documentation](https://learn.microsoft.com/en-us/nuget/quickstart/create-and-publish-a-package-using-visual-studio?tabs=netcore-cli).

## Step 2: Create your own MyGet feed

Once the first step is completed, we need to create our own MyGet feed.

To create the MyGet feed, follow the [MyGet documentation.](https://docs.myget.org/docs/walkthrough/getting-started-with-nuget)

When you create the MyGet feed, it needs to be created as private.

## Step 3: Publish your NuGet package

We will publish our NuGet package to your MyGet feed in the third step.&#x20;

There are two ways to do so:

* Go directly to your MyGet feed and upload the NuGet package.
* Follow the [Microsoft Documentation](https://learn.microsoft.com/en-us/nuget/quickstart/create-and-publish-a-package-using-visual-studio?tabs=netcore-cli#publish-with-the-dotnet-cli-or%EF%BF%BDnugetexe-cli).

## Step 4: Add private MyGet feed on Umbraco Cloud

In the last step, we will add the private feed to our Umbraco cloud project.

To add the private feed to your Cloud project, follow the steps below:

1. Access the cloud [Secrets Management](https://docs.umbraco.com/umbraco-cloud/set-up/project-settings/secrets-management).
2. Add your MyGet credentials as a Shared Secret.
3. Clone down your Umbraco Cloud project.
4. Open the project locally and build/spin up the site.
5. Go to your `NuGet.config` file in the root of your project.
6. Add the below configuration to the file:

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

In the above code example, you can see that we are using the Key: "`MYGET_PASSWORD`" that we created in the previous step. We did that by using the Cloud Secrets Management feature on Umbraco Cloud.

7. Push the changes to your Umbraco Cloud project.

Congratulations, you've successfully set up a private NuGet feed with Umbraco Cloud using the cloud secrets management feature!

You can now use this feed to host and manage your own internal libraries or proprietary software. If you want to learn more about NuGet and how to use it, check out the official [NuGet documentation](https://learn.microsoft.com/en-us/nuget/).
