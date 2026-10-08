---
description: List of tools that are excluded from the Forms Developer MCP
---

# Excluded Tools

Certain Umbraco Forms Management API endpoints are intentionally not exposed as tools. The excluded endpoints manage which users and user groups can access Forms features and individual forms.

## Excluded Groups Summary

- **Security (13 endpoints)** - Forms permissions for users and user groups, and the Security tree that lists them. Assigning permissions through an AI agent could grant users access they should not have.

## Ignored Endpoints

These endpoints are intentionally not implemented as MCP tools, because they:

- Change who can create, edit, or delete forms, and who can view, edit, or delete submitted entries
- Expose the permission configuration of users and user groups, which is security configuration rather than form content

## Ignored by Category

### User Group Permissions (4 endpoints)

- `getSecurityUserGroupByIdFormSecurity` - Gets the Forms permissions of a user group
- `postSecurityUserGroupByIdFormSecurity` - Creates Forms permissions for a user group
- `putSecurityUserGroupByIdFormSecurity` - Updates the Forms permissions of a user group
- `deleteSecurityUserGroupByIdFormSecurity` - Deletes the Forms permissions of a user group

### User Permissions (6 endpoints)

- `getSecurityUserByIdFormSecurity` - Gets the Forms permissions of a user
- `postSecurityUserByIdFormSecurity` - Creates Forms permissions for a user
- `putSecurityUserByIdFormSecurity` - Updates the Forms permissions of a user
- `deleteSecurityUserByIdFormSecurity` - Deletes the Forms permissions of a user
- `getSecurityUserCurrentFormSecurity` - Gets the Forms permissions of the current user
- `getSecurityUserUsersToAssign` - Lists the users that Forms permissions can be assigned to

### Security Tree (3 endpoints)

- `getTreeSecurityRoot` - Lists the root items of the Forms Security tree
- `getTreeSecurityChildrenByParentId` - Lists the child items of a node in the Security tree
- `getTreeSecurityAncestors` - Lists the ancestors of an item in the Security tree

{% hint style="info" %}
To review or change Forms permissions, use the **Security** tree in the **Forms** section of the backoffice.

For more information, see the [Security](https://docs.umbraco.com/umbraco-forms/developer/security) article in the Umbraco Forms documentation.
{% endhint %}
