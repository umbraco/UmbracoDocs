# .NET Core Console Application

In this article, you can read more about the .NET Core Console Application.

We will go through the process of setting the application up and exploring what you can do with the application. We will also discuss how you can connect to your Heartcore project on Umbraco Cloud.

{% hint style="info" %}
In order to use this console application, you will need to have the .NET Core SDK2.2. Older or newer versions will **not work** with the application.
{% endhint %}

## Installing the Console Application

Once you have cloned down the [Umbraco Headless Client](https://github.com/umbraco/Umbraco.Headless.Client.Net), there are two ways of running the application.

### 1. Using Visual Studio

Open up the `Umbraco.Headless.Client.Samples.Console.sln` file located at `Umbraco.Headless.Client.Net\samples\Umbraco.Headless.Client.Samples.Console` and press F5. This will launch the Console application.

### 2. Using the Command Line

By using the command line, you will need to run the following commands from the `Umbraco.Headless.Client.Samples.Console` folder in order to run the application.

```
> dotnet restore
> dotnet run
```

## Walkthrough of the Application

In order to use this application to its fullest, you will need a Heartcore Project on Umbraco Cloud. If you do not have a project yet, you can [create a trial](https://umbraco.com/try-umbraco-heartcore/). It is recommended that you have a project with both content and media items.

{% hint style="info" %}
If you are connecting to a Heartcore Project with multiple environments you will have to use the alias for the **Development environment**.
{% endhint %}

If you do not have a project or trial you can also connect to `demo-headless`.

```
Booting Umbraco Headless console

Enter the Project Alias of your Headless Project
```

Once you have entered the alias of the project, you are presented with the following options

```
[A] Fetch and show Content Tree
[B] Fetch and show Media Tree
[C] Show Root Content
[D] Show Root Media
[E] List Content URLs
[F] Upload image to Media Library
[X] Exit
```

Option A - E uses the[ Content Delivery API](../api-documentation/content-delivery/) and can be used for any Heartcore Project, which has public content.

Option F uses the [Content Management API.](../api-documentation/content-management/). This means that an [API Key](../getting-started/backoffice-users-and-api-keys.md) is required to run this part of the sample. This is because it will create a new folder in the Media Library and upload an image to a new Media item.

### Examples of the fetched data

Fetching the data looks like the following.

```
Enter your choice:
a

Fetching and listing Content tree

+- Home
   +- About
```

In the example above we have fetched the Content Tree. Is shows all the Parent and Child Nodes. The Child Node is shown by an indentation.

In the next example, we have fetched the Root media.

```
Enter your choice:
d

Fetching and showing root Media

'Company Logo' can be seen on: https://media.umbraco.io/dev-docs/8d7c736482a65b4/company_logo.jpg
'Company Logo Small' can be seen on: https://media.umbraco.io/dev-docs/8d7c73648f72d6a/company_logo_small.jpg
'Product01' can be seen on: https://media.umbraco.io/dev-docs/8d7c7364978df6c/Product01.jpg
'Product02' can be seen on: https://media.umbraco.io/dev-docs/8d7c7364a0b846c/Product02.jpg
'Product03' can be seen on: https://media.umbraco.io/dev-docs/8d7c7364a0b846c/Product03.jpg
```

It is showing the name of the Media items and a direct link to each of the Media items.
