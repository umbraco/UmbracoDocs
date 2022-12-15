# Member Manager

inject `@MemberManager` in a Template

```csharp
.FindByIdAsync("1234")
.FindByEmailAsync("test@member.com")
.IsLoggedIn()
.MemberHasAccessAsync(string)
.IsProtectedAsync()
.AsPublishedMember(MemberIdentityUser)
.GetCurrentMemberAsync()
.ValidateCredentialsAsync(userName, password)
```
