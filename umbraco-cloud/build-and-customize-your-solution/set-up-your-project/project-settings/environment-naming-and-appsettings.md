---
description: >-
  Learn how an environment's name sets its DOTNET_ENVIRONMENT value, and how
  to avoid issues when you name an environment Development.
---

# Environment Naming and Appsettings

The name you give an Umbraco Cloud environment also becomes the value of its `DOTNET_ENVIRONMENT` variable. This value decides which `appsettings.{Name}.json` file the environment loads. Most names are safe to use this way. Naming an environment `Development` has side effects worth knowing before you create or rename one.

## How the Environment Name Affects Configuration

ASP.NET Core loads `appsettings.json` first, then layers `appsettings.{DOTNET_ENVIRONMENT}.json` on top of it. The values in the second file win wherever the two overlap. The `DOTNET_ENVIRONMENT` value comes from the environment's name, as described in the [Environments](../../../begin-your-cloud-journey/project-features/environments.md) article. You can view or override the value under [Project Settings](README.md#advanced) > Advanced.

Naming an environment `QA`, for example, applies `appsettings.QA.json` if that file exists in your project. This outcome is predictable and harmless.

## Why the Name Development Is Different

.NET and Umbraco project templates use the name `Development` by default for local development on your own machine, set through `launchSettings.json`. Two things follow from that convention:

* `env.IsDevelopment()` switches on real runtime behavior in ASP.NET Core and in Umbraco. This includes the developer exception page with full stack traces, detailed Entity Framework error messages, and other development-oriented defaults.
* Your local tooling assumes the name `Development` means your own machine. The default `launchSettings.json` in .NET and Umbraco project templates sets this environment when you run the site locally.

When you name a Cloud environment `Development`, that environment takes over `appsettings.Development.json`, the same file your team uses for local development. The environment then runs in development mode on a public URL.

The resulting issues tend to show up later, and they can look unrelated to the cause:

* Local connection strings or Umbraco Deploy settings apply in the cloud, or the other way around.
* Error pages with full stack traces appear on a cloud hostname.
* Local development breaks after someone edits `appsettings.Development.json` for the cloud environment.

{% hint style="warning" %}
Naming the [left-most mainline environment](../../../begin-your-cloud-journey/project-features/environments.md) `Development` is a common choice on Umbraco Cloud projects, and it then triggers the behavior described above.
{% endhint %}

## File Name Casing on Linux

Environment name checks in code, such as `env.IsDevelopment()` and `env.IsEnvironment("...")`, aren't case sensitive. The lookup of the `appsettings.{env}.json` file, however, happens on the file system. Umbraco Cloud environments run on Linux, where file lookups are case sensitive.

Match the casing of your environment name to the casing of the appsettings file name exactly. An environment named `development`, in lowercase, doesn't load `appsettings.Development.json`.

## Two Ways to Keep the Name Development

There is nothing wrong with the name `Development` itself. Decide who owns the name: your local machines, or the cloud environment. Pick one of the two options below.

### Option A: Move Local Development to Its Own Name

Keep the cloud environment named `Development`, and give local development a new name, for example `Local`.

1. Add an `appsettings.Local.json` file to your project, and move your local-only settings into it, such as connection strings, Umbraco Deploy local settings, and logging verbosity.
2. Add the file to `.gitignore` if it contains secrets.
3. Update `launchSettings.json` so your run profiles use the new name, as shown below.

{% code title="Properties/launchSettings.json" %}
```json
{
  "profiles": {
    "MyProject": {
      "commandName": "Project",
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Local"
      }
    }
  }
}
```
{% endcode %}

{% hint style="info" %}
The name `Local` is not `Development`, so `env.IsDevelopment()` now returns `false` on your machine. Update any code that checks `env.IsDevelopment()` to also check `env.IsEnvironment("Local")`, or to use a combined check. This applies to the developer exception page, detailed errors, and ModelsBuilder source code mode.
{% endhint %}

### Option B: Override the Variable on the Cloud Environment

Keep local development on `Development`, as the templates expect. Give the cloud environment a different configuration name, even though the portal still displays it as `Development`.

1. Go to [Project Settings](README.md#advanced) > Advanced, and select the environment.
2. Edit `DOTNET_ENVIRONMENT` to a value such as `CloudDev`.
3. Add a matching `appsettings.CloudDev.json` file to your project with the settings that environment should use.

This option keeps your local tooling and code unchanged. `appsettings.Development.json` stays your local file, as it always was.

Option B is the smaller change, and it keeps the standard template conventions intact. Option A suits teams that want the environment name shown in the portal to always match the configuration file name exactly.

## Naming Checklist

Check the following before you create or rename an environment:

* [ ] Confirm whether an `appsettings.{Name}.json` file already exists in your project, and whether you want its values applied to this cloud environment.
* [ ] Check whether the name is `Development`. If it is, apply Option A or Option B above before you deploy.
* [ ] Match the casing of the name to the casing of the appsettings file exactly.
* [ ] Verify the value under Project Settings > Advanced matches what you expect, after you create the environment.

## Supported Umbraco Versions

This article covers ASP.NET Core configuration behavior: the `DOTNET_ENVIRONMENT` variable and `appsettings.{Name}.json` files. That behavior applies to Umbraco 9 and later. Umbraco Cloud also hosts Umbraco 7 and 8 projects, which run on .NET Framework instead of ASP.NET Core, so this guidance doesn't apply to them.
