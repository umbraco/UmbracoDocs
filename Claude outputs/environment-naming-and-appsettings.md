# Environment Naming and Appsettings

On Umbraco Cloud, the name you give an environment also becomes the value of its `DOTNET_ENVIRONMENT` variable, which decides which `appsettings.{Name}.json` file it loads. For most names this is harmless, but naming an environment **Development** has side effects worth knowing about before you create or rename one.

## How the environment name affects configuration

When an environment starts, ASP.NET Core loads `appsettings.json` first, then layers `appsettings.{DOTNET_ENVIRONMENT}.json` on top of it, and the values in the second file win wherever the two overlap. The `DOTNET_ENVIRONMENT` value comes from the environment's name, as explained in the [Environments](/umbraco-cloud/begin-your-cloud-journey/project-features/environments.md) article. You can view or override the value under Project Settings > Advanced, see [Project Settings](/umbraco-cloud/build-and-customize-your-solution/set-up-your-project/project-settings.md).

Most environment names are fine here. Naming an environment `QA`, for example, applies `appsettings.QA.json` if it exists in your project, which is predictable and harmless.

## Why "Development" is a special case

One name deserves extra thought: **Development**. .NET and Umbraco project templates use this name by default for local development on your own machine, set through `launchSettings.json`. Two things follow from that:

* `env.IsDevelopment()` switches on real runtime behavior in ASP.NET Core and in Umbraco: the developer exception page with full stack traces, detailed Entity Framework error messages, and other development-oriented defaults.
* Your local tooling assumes "Development" means "my machine." The default `launchSettings.json` in .NET and Umbraco project templates sets this environment when you run the site locally.

If you name a Cloud environment `Development`, it takes over `appsettings.Development.json`, the same file your team uses for local development, and the environment runs in development mode on a public URL.

The symptoms tend to show up later and look unrelated to the cause:

* Local connection strings or Umbraco Deploy settings apply in the cloud, or the other way around.
* Error pages with full stack traces appear on a cloud hostname.
* Local development breaks after someone edits `appsettings.Development.json` "for the cloud environment."

{% hint style="warning" %}
This is easy to run into by accident. Umbraco Cloud's left-most mainline environment is often referred to as the Development environment, and naming it literally "Development" is a common, unremarkable-looking choice, until it triggers the behavior described above.
{% endhint %}

## A note on casing

Environment name checks in code, such as `env.IsDevelopment()` and `env.IsEnvironment("...")`, are not case sensitive. The lookup of the `appsettings.{env}.json` file, however, happens on the file system, which is case sensitive on Linux, where Umbraco Cloud environments run. Make sure the casing of your environment name matches the casing of the appsettings file name exactly. An environment named `development`, in lowercase, will not load `appsettings.Development.json`.

## If you want an environment named "Development"

There is nothing wrong with the name itself. You need to decide who owns it, your local machines or the cloud environment. Pick one of the two options below.

### Option A: move local development to its own name

Keep the cloud environment named `Development`, and give local development a new name, for example `Local`.

1. Add an `appsettings.Local.json` file to your project, and move your local-only settings into it, such as connection strings, Umbraco Deploy local settings, and logging verbosity. Add it to `.gitignore` if it contains secrets.
2. Update `Properties/launchSettings.json` so your run profiles use the new name:

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

{% hint style="info" %}
Because `Local` is not `Development`, `env.IsDevelopment()` is now `false` on your machine. Anything your code gates on it, such as the developer exception page, detailed errors, or ModelsBuilder source code mode, needs to also check `env.IsEnvironment("Local")`, or use a combined check. This is the most common follow-up surprise with this option.
{% endhint %}

### Option B: override the variable on the cloud environment

Keep local development on `Development`, as the templates expect, and give the cloud environment a different configuration name, even though it's still displayed as "Development" in the portal.

1. Go to Project Settings > Advanced, select the environment, and edit `DOTNET_ENVIRONMENT` to a value such as `CloudDev`.
2. Add a matching `appsettings.CloudDev.json` file to your project with the settings that environment should use.

With this option, your local tooling and code keep working unchanged, and `appsettings.Development.json` stays what it always was, your local file.

**Which option should you choose?** Option B is the smaller change, and it keeps the standard template conventions intact, so it is a good default. Option A is worth it if your team prefers the environment name shown in the portal to always match the configuration file name exactly.

## Naming checklist

Before you create or rename an environment, check the following:

* [ ] Does an `appsettings.{Name}.json` already exist in your project, and do you want its values applied to this cloud environment?
* [ ] Is the name "Development"? If so, pick Option A or B above before deploying.
* [ ] Does the casing of the name match the casing of the appsettings file exactly?
* [ ] After creating the environment, verify the value under Project Settings > Advanced matches what you expect.

## Which Umbraco versions this applies to

This article describes ASP.NET Core configuration behavior, `DOTNET_ENVIRONMENT` and `appsettings.{Name}.json`, which applies to Umbraco 9 and later. Umbraco Cloud also hosts Umbraco 7 and 8 projects, which run on .NET Framework rather than ASP.NET Core, so this article does not apply to those.
