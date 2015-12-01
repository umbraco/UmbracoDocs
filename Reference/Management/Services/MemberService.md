#MemberService

**Applies to Umbraco 7.1 and 6.2 and newer**

The MemberService acts as a "gateway" to Umbraco data for operations which are related to Members.

 * **Namespace:** `Umbraco.Core.Services` 
 * **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following usings:
	
	using Umbraco.Core;
	using Umbraco.Core.Models;
	using Umbraco.Core.Services;

**Please note that this page will be updated with samples and additional information about the methods listed below**

##Getting the service
The MemberService is available through the `ApplicationContext`, but the if you are using a `SurfaceController` or the `UmbracoUserControl` then the MemberService is available through a local `Services` property.

	Services.MemberService

Getting the service through the `ApplicationContext`:

	ApplicationContext.Current.Services.MemberService

##Methods

###.AddRole(string role);
Adds a new Role with a given name

###.AssignRole(int memberId, string role);
Assigns a role to a specific `Member`

###.AssignRoles(int[] memberIds, string role);
Assigns a role to multiple `Member`s

###.CreateMember(string username, string email, string displayName, string memberTypeAlias);
Creates a new `Member`, but does not instantly persist it

###.CreateMemberWithIdentity(string username, string email, string displayName, string memberTypeAlias);
Creates a new `Member`, persists the data, and assign a unique key

###.CreateWithIdentity(string username, string email, string password, string memberTypeAlias);
Creates a new `Member` with a given password, persists the data, and assign a unique key

###.Delete(IMember member);
Deletes a `Member`

###.DeleteMembersOfType(int id);
Deletes all members of a given type

###.DeleteRole(string role, bool throwOnExist);
Deletes a role, define if deletion should throw an exception if the role is in use by any members

###.DissociateRole(int memberId, string role);
Removes the role from a given `Member`

###.DissociateRoles(int[] ids, string[] roles);
Removes multiple roles from multiple `Member` s

###.Exists(int id);
Returns true/false if a gven member ID exists

###.Exists(string username);
Returns true/false if a gven member login exists

###.FindByEmail("gmail.com", int pageIndex, int pageSize, out int totalRecords, [`StringPropertyMatchType`]);
Searches for all members with a given email, supports paging returned results.

Search supports multiple match types: 

- *Exact* email must be equal to term
- *Contains* email must contain term
- *StartsWith* email must start with term
- *EndsWith* email must end with term
- *Wildcard* email must match wildcard string like "*mail.*"

###.FindByUsername(string username, int pageIndex, int pageSize, out int totalRecords, [`StringPropertyMatchType`]);
Searches for all members with a given username, supports paging returned results.

Search supports multiple match types: 

- *Exact* username must be equal to term
- *Contains* username must contain term
- *StartsWith* username must start with term
- *EndsWith* username must end with term
- *Wildcard* username must match wildcard string like "j*n"

###.FindMembersByDisplayName(string name, int pageIndex, int pageSize, out int totalRecords, [`StringPropertyMatchType`]);
Searches for all members with a given display name, supports paging returned results.

Search supports multiple match types: 

- *Exact* display name must be equal to term
- *Contains* display name must contain term
- *StartsWith* display name must start with term
- *EndsWith* display name must end with term
- *Wildcard* display name must match wildcard string like "j*n"

###.FindMembersInRole(string role, string username, [`StringPropertyMatchType`]);
Searches for all members with a given username with a given Role assigned.

Search supports multiple match types: 

- *Exact* username must be equal to term
- *Contains* username must contain term
- *StartsWith* username must start with term
- *EndsWith* username must end with term
- *Wildcard* username must match wildcard string like "j*n"


###.GetAll(int pageIndex, int pageSize, out int totalRecords)
Returns all members, in paged results.

###.GetAllMembers(int[] ids);
Returns a collection of members with the given ID's

###.GetAllRoles();
Returns all roles

###.GetByEmail(string email);
Returns a single `Member` with a given Email

###.GetById(int id);
Returns a single `Member` with a given ID

###.GetByKey(Guid key);
Returns a single `Member` with a given Key

###.GetByProviderKey(object key);
Returns a single `Member` with a given Membership provider key.

###.GetByUsername(string username);
Returns a single `Member` with a given Username

###.GetDefaultMemberType();
Returns the default `MemberType`

###.GetMembersByGroup(string role);
Returns all members in a given Group - same as "Role".

###.GetMembersByMemberType("MemberType")
Returns all members of a given Type

###.GetMembersByPropertyValue("city", "Horsens");
Returns all Members, of any type, with a mathcing value in the property with the given property alias

###.GetMembersInRole(string role);
Returns all members in a given Role

###.Save(IMember member);
Saves a `Member`,

###.SavePassword(IMember member, "newSecretPass1234");
Sets a password on a given `Member`