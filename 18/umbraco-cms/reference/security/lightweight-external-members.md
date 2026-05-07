---
description: >-
  Lightweight external members let you authenticate members through an external
  identity provider without storing them as full content entities in Umbraco.
---

# Lightweight external members

Lightweight external members are a storage option for members whose identity lives in an external provider such as Entra ID, Auth0, or Google. When you enable the option, Umbraco stores the member as a minimal identity record instead of a full content entity.

You opt in on a per-provider basis by setting `ExternalOnly = true` on the auto-link options. The rest of the Member authentication setup stays the same. See [External login providers](external-login-providers.md) for how to wire up the provider itself.

## Background

A standard Umbraco member is a content entity. Saving a member writes rows across multiple tables, creates a new content version, and triggers a search re-index. The model is flexible and fits scenarios where you manage member profiles from the backoffice.

Even when an external provider is used, Umbraco creates a local, synchronized member record.

When the external provider is the source of truth for identity, the content overhead adds less value. You might still want to augment member profile data in Umbraco, so it's still a valid option. The content overhead also creates a bottleneck under high-concurrency registrations and logins. Every write contends for locks on the content tables and the search index.

Lightweight external members store only the minimal record fields needed for authentication (`umbracoExternalMember`) and role membership (`umbracoExternalMember2MemberGroup`).

## Trade-offs

Choose lightweight external members when the external provider owns the profile, and you want to scale registration and login throughput.

Choose content-based members when you need more than identity from the provider. Typical cases include editing member profiles in the backoffice, storing member-specific content properties, or augmenting the external identity with data managed in Umbraco. Content-based members also support auto-linking to an external provider, so you get single sign-on alongside editable profile fields.

| Area | Content-based member | Lightweight external member |
| --- | --- | --- |
| Backoffice editing | Full edit surface | Read-only view with an **External** badge. |
| Member Type properties | Stored as content properties | Not used — profile data is stored as JSON. |
| Password and local login | Supported | Not supported — external authentication only. |
| Two-factor authentication | Supported | Not supported — external provider feature. |
| Relation tracking | Available | Not available — no `umbracoNode` entry. |
| Public access rules | Type-based and group-based | Group-based only. |
| Management API | Full read and write | Read-only; creation via auto-link or `IExternalMemberService`. |
| Write cost per save | Multiple tables, versioning, full re-index | Single row update and deferred index entry. |

{% hint style="info" %}
You can promote a lightweight external member to a full content-based member later. See [Converting to a content member](lightweight-external-members.md#converting-to-a-content-member) below.
{% endhint %}

## Enabling external-only members

Add the `ExternalOnly` flag to the `MemberExternalSignInAutoLinkOptions` on your provider configuration. The example below shows a provider configured for auto-linking where the external provider is the source of truth.

{% code title="ProviderMembersExternalLoginProviderOptions.cs" lineNumbers="true" %}
```csharp
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Web.Common.Security;

namespace MyUmbracoProject.CustomAuthentication;

public class ProviderMembersExternalLoginProviderOptions : IConfigureNamedOptions<MemberExternalLoginProviderOptions>
{
    public const string SchemeName = "OpenIdConnect";

    public void Configure(string? name, MemberExternalLoginProviderOptions options)
    {
        if (name != Constants.Security.MemberExternalAuthenticationTypePrefix + SchemeName)
        {
            return;
        }

        Configure(options);
    }

    public void Configure(MemberExternalLoginProviderOptions options)
    {
        options.AutoLinkOptions = new MemberExternalSignInAutoLinkOptions(
            autoLinkExternalAccount: true,
            defaultIsApproved: true,
            defaultMemberTypeAlias: Constants.Security.DefaultMemberTypeAlias,
            defaultMemberGroups: ["ExternalMembers"])
        {
            // Store auto-linked members as lightweight external identities
            // rather than full content-based members.
            ExternalOnly = true,
        };
    }
}
```
{% endcode %}

The `defaultMemberTypeAlias` value is still required for the auto-link flow, but external-only members do not have member type properties. Assign groups through `defaultMemberGroups` because type-based public access rules do not apply to external members.

For the full provider registration (composer, authentication options, callback paths), follow the patterns in [External login providers](external-login-providers.md). The only change for external-only members is the `ExternalOnly` flag shown above.

## Handling profile data

External members do not have content properties. Instead, Umbraco stores a `ProfileData` JSON string on the identity record. Use the `OnAutoLinking` and `OnExternalLogin` callbacks to populate the field from the provider's claims.

- `OnAutoLinking` runs once, when the member is first created.
- `OnExternalLogin` runs on every subsequent login, which keeps the profile in sync with the provider.

The example below reads standard OpenID Connect claims plus a custom `department` claim, and writes them as JSON to the member's `ProfileData` property.

{% code title="ProviderMembersExternalLoginProviderOptions.cs" lineNumbers="true" %}
```csharp
using System.Security.Claims;
using System.Text.Json;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Web.Common.Security;

namespace MyUmbracoProject.CustomAuthentication;

public class ProviderMembersExternalLoginProviderOptions : IConfigureNamedOptions<MemberExternalLoginProviderOptions>
{
    public const string SchemeName = "OpenIdConnect";

    public void Configure(string? name, MemberExternalLoginProviderOptions options)
    {
        if (name != Constants.Security.MemberExternalAuthenticationTypePrefix + SchemeName)
        {
            return;
        }

        Configure(options);
    }

    public void Configure(MemberExternalLoginProviderOptions options)
    {
        options.AutoLinkOptions = new MemberExternalSignInAutoLinkOptions(
            autoLinkExternalAccount: true,
            defaultIsApproved: true,
            defaultMemberTypeAlias: Constants.Security.DefaultMemberTypeAlias,
            defaultMemberGroups: ["ExternalMembers"])
        {
            ExternalOnly = true,
            OnAutoLinking = (user, loginInfo) =>
            {
                user.ProfileData = JsonSerializer.Serialize(BuildProfile(loginInfo), JsonSerializerOptions.Web);
            },
            OnExternalLogin = (user, loginInfo) =>
            {
                // Re-serializing on every login keeps the stored profile in sync
                // with the values the provider returned in the latest claims.
                user.ProfileData = JsonSerializer.Serialize(BuildProfile(loginInfo), JsonSerializerOptions.Web);
                return true;
            },
        };
    }

    private static MemberProfile BuildProfile(ExternalLoginInfo loginInfo) => new()
    {
        FirstName = loginInfo.Principal.FindFirstValue(ClaimTypes.GivenName),
        LastName = loginInfo.Principal.FindFirstValue(ClaimTypes.Surname),
        Department = loginInfo.Principal.FindFirstValue("department"),
    };

    private sealed class MemberProfile
    {
        public string? FirstName { get; set; }

        public string? LastName { get; set; }

        public string? Department { get; set; }
    }
}
```
{% endcode %}

{% hint style="info" %}
You can assign `ProfileData` on every login without worrying about unnecessary writes. Umbraco dirty-tracks the property and only persists — and re-indexes — when the serialized JSON differs from the stored value.
{% endhint %}

The JSON is also indexed for search, so profile fields are searchable from the backoffice member list and the member picker.

## Reading profile data

You can read the stored profile in both C# code and Razor templates.

### In C\#

`MemberIdentityUser.GetProfileData<T>()` reads the JSON and returns a typed object. The type must be a reference type. Pass the same `JsonSerializerOptions` you used when writing so the property casing matches.

{% code title="MemberProfileReader.cs" lineNumbers="true" %}
```csharp
using System.Text.Json;
using Umbraco.Cms.Core.Security;

public class MemberProfileReader
{
    private readonly IMemberManager _memberManager;

    public MemberProfileReader(IMemberManager memberManager) => _memberManager = memberManager;

    public async Task<MemberProfile?> GetCurrentProfileAsync()
    {
        MemberIdentityUser? user = await _memberManager.GetCurrentMemberAsync();
        return user?.GetProfileData<MemberProfile>(JsonSerializerOptions.Web);
    }
}

public class MemberProfile
{
    public string? FirstName { get; set; }

    public string? LastName { get; set; }

    public string? Department { get; set; }
}
```
{% endcode %}

### In Razor templates

Each top-level key in the profile JSON surfaces as a published property on the member. The same `Value()` call works for both content-based and external-only members.

{% code title="MemberProfile.cshtml" %}
```csharp
@using Umbraco.Cms.Web.Common.PublishedModels
@inject IMemberManager MemberManager
@{
    var user = await MemberManager.GetCurrentMemberAsync();
    var member = user is null ? null : MemberManager.AsPublishedMember(user);
    if (member is null)
    {
        return;
    }
}

<p>Name: @member.Value("firstName") @member.Value("lastName")</p>
<p>Department: @member.Value("department")</p>
```
{% endcode %}

## Handling member groups

External providers often manage group or role membership alongside identity. Use `OnExternalLogin` to mirror that membership to Umbraco member groups so the assignment stays in sync on every login.

For external-only members, group membership is managed through `IExternalMemberService.AssignRolesAsync` and `RemoveRolesAsync`. The example below reads a `groups` claim, compares the values to the member's current groups, and applies the delta.

{% code title="ProviderMembersExternalLoginProviderOptions.cs" lineNumbers="true" %}
```csharp
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Security;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Web.Common.Security;

namespace MyUmbracoProject.CustomAuthentication;

public class ProviderMembersExternalLoginProviderOptions : IConfigureNamedOptions<MemberExternalLoginProviderOptions>
{
    public const string SchemeName = "OpenIdConnect";

    private readonly IServiceScopeFactory _scopeFactory;

    public ProviderMembersExternalLoginProviderOptions(IServiceScopeFactory scopeFactory)
        => _scopeFactory = scopeFactory;

    public void Configure(string? name, MemberExternalLoginProviderOptions options)
    {
        if (name != Constants.Security.MemberExternalAuthenticationTypePrefix + SchemeName)
        {
            return;
        }

        Configure(options);
    }

    public void Configure(MemberExternalLoginProviderOptions options)
    {
        options.AutoLinkOptions = new MemberExternalSignInAutoLinkOptions(
            autoLinkExternalAccount: true,
            defaultIsApproved: true,
            defaultMemberTypeAlias: Constants.Security.DefaultMemberTypeAlias,
            defaultMemberGroups: ["ExternalMembers"])
        {
            ExternalOnly = true,
            OnExternalLogin = (user, loginInfo) =>
            {
                SyncMemberGroupsAsync(user, loginInfo).GetAwaiter().GetResult();
                return true;
            },
        };
    }

    private async Task SyncMemberGroupsAsync(MemberIdentityUser user, ExternalLoginInfo loginInfo)
    {
        var desiredGroups = loginInfo.Principal
            .FindAll("groups")
            .Select(claim => claim.Value)
            .ToHashSet(StringComparer.OrdinalIgnoreCase);

        using IServiceScope scope = _scopeFactory.CreateScope();
        IExternalMemberService externalMemberService =
            scope.ServiceProvider.GetRequiredService<IExternalMemberService>();

        var currentGroups = (await externalMemberService.GetRolesAsync(user.Key))
            .ToHashSet(StringComparer.OrdinalIgnoreCase);

        string[] toAdd = desiredGroups.Except(currentGroups).ToArray();
        string[] toRemove = currentGroups.Except(desiredGroups).ToArray();

        if (toAdd.Length > 0)
        {
            await externalMemberService.AssignRolesAsync(user.Key, toAdd);
        }

        if (toRemove.Length > 0)
        {
            await externalMemberService.RemoveRolesAsync(user.Key, toRemove);
        }
    }
}
```
{% endcode %}

The example above focuses on member group synchronization. You can combine the group sync call with the `ProfileData` assignment shown in [Handling profile data](lightweight-external-members.md#handling-profile-data) inside a single `OnExternalLogin` callback.

{% hint style="info" %}
The member groups referenced by the claims must already exist in Umbraco. Unknown names are silently ignored. Pre-create them in the backoffice under **Members** > **Member Groups**, or provision them in code with `IMemberGroupService`.
{% endhint %}

If the provider should only add groups and not remove them, drop the `toRemove` branch and call `AssignRolesAsync` only. Existing memberships are not duplicated.

## Converting to a content member

Use `IExternalMemberService.ConvertToContentMemberAsync` when a member needs the full content-based model. For example, you might want to enable member type properties or two-factor authentication. The optional `mapProfileData` callback lets you copy fields from the JSON profile onto the new member's content properties.

{% code title="ExternalMemberPromoter.cs" lineNumbers="true" %}
```csharp
using System.Text.Json;
using Umbraco.Cms.Core.Services;

public class ExternalMemberPromoter
{
    private readonly IExternalMemberService _externalMemberService;

    public ExternalMemberPromoter(IExternalMemberService externalMemberService)
        => _externalMemberService = externalMemberService;

    public async Task PromoteAsync(Guid memberKey)
    {
        await _externalMemberService.ConvertToContentMemberAsync(
            memberKey,
            memberTypeAlias: "Member",
            mapProfileData: (member, profileJson) =>
            {
                if (string.IsNullOrEmpty(profileJson))
                {
                    return;
                }

                MemberProfile? profile = JsonSerializer.Deserialize<MemberProfile>(profileJson);
                if (profile is null)
                {
                    return;
                }

                member.SetValue("department", profile.Department);
            });
    }
}
```
{% endcode %}

Conversion deletes the external member record and creates a new content member with the same key. Existing external login associations continue to resolve to the new member.

## Related articles

{% content-ref url="external-login-providers.md" %}
[external-login-providers.md](external-login-providers.md)
{% endcontent-ref %}

{% content-ref url="../../tutorials/members-registration-and-login.md" %}
[members-registration-and-login.md](../../tutorials/members-registration-and-login.md)
{% endcontent-ref %}
