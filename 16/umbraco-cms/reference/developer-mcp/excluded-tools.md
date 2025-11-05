---
description: List of tools that are excluded from the Developer MCP
---

# Excluded Tools

Certain endpoints are intentionally excluded due to security, complexity, or contextual concerns.

## Excluded Groups Summary

- **User Management (22 endpoints)** - User creation/deletion, password operations, 2FA management, and client credentials pose significant security risks
- **User Group Membership (3 endpoints)** - Permission escalation risks from AI-driven group membership changes
- **Security Operations (4 endpoints)** - Password reset workflows require email verification and user interaction
- **Import/Export (9 endpoints)** - Complex file operations better handled through the Umbraco UI
- **Package Management (9 endpoints)** - Package creation and migration involve system-wide changes
- **Cache Operations (3 endpoints)** - Cache rebuild can impact system performance
- **Telemetry (3 endpoints)** - System telemetry configuration and data collection
- **Install/Upgrade (5 endpoints)** - One-time system setup and upgrade operations
- **Preview/Profiling (4 endpoints)** - Frontend-specific debugging functionality
- **Other (7 endpoints)** - Internal system functionality, oEmbed, dynamic roots, object types

## Ignored Endpoints

These endpoints are intentionally not implemented in the MCP server, typically because they:

- Are related to import/export functionality that may not be suitable for MCP operations
- Have security implications
- Are not applicable in the MCP context

## Ignored by Category

### DocumentType (3 endpoints)

- `getDocumentTypeByIdExport` - Export functionality
- `postDocumentTypeImport` - Import functionality
- `putDocumentTypeByIdImport` - Import functionality

### Dictionary (2 endpoints)

- `getDictionaryByIdExport` - Export functionality
- `postDictionaryImport` - Import functionality

### MediaType (3 endpoints)

- `getMediaTypeByIdExport` - Export functionality
- `postMediaTypeImport` - Import functionality
- `putMediaTypeByIdImport` - Import functionality

### Import (1 endpoint)

- `getImportAnalyze` - Import analysis functionality

### Install (3 endpoints)

- `getInstallSettings` - Installation configuration settings (system setup concerns)
- `postInstallSetup` - System installation functionality (system modification risk)
- `postInstallValidateDatabase` - Database validation during installation (system setup concerns)

### Package (9 endpoints)

- `deletePackageCreatedById` - Delete created package functionality
- `getPackageConfiguration` - Package configuration settings
- `getPackageCreated` - List created packages functionality
- `getPackageCreatedById` - Get created package by ID functionality
- `getPackageCreatedByIdDownload` - Download package functionality
- `getPackageMigrationStatus` - Package migration status functionality
- `postPackageByNameRunMigration` - Run package migration functionality
- `postPackageCreated` - Create package functionality
- `putPackageCreatedById` - Update created package functionality

### Security (4 endpoints)

- `getSecurityConfiguration` - Security configuration settings
- `postSecurityForgotPassword` - Password reset functionality
- `postSecurityForgotPasswordReset` - Password reset confirmation functionality
- `postSecurityForgotPasswordVerify` - Password reset verification functionality

### User Groups (3 endpoints)

- `deleteUserGroupByIdUsers` - Remove users from groups (permission escalation risk)
- `postUserGroupByIdUsers` - Add users to groups (permission escalation risk)
- `postUserSetUserGroups` - Set user's group memberships (permission escalation risk)

### Telemetry (3 endpoints)

- `getTelemetry` - System telemetry data collection (privacy concerns)
- `getTelemetryLevel` - Telemetry configuration exposure (privacy concerns)
- `postTelemetryLevel` - Telemetry settings modification (privacy concerns)

### PublishedCache (3 endpoints)

- `getPublishedCacheRebuildStatus` - Cache rebuild status monitoring (system performance concerns)
- `postPublishedCacheRebuild` - Cache rebuild operations (system performance/stability risk)
- `postPublishedCacheReload` - Cache reload operations (system performance/stability risk)

### Upgrade (2 endpoints)

- `getUpgradeSettings` - System upgrade configuration settings (system setup concerns)
- `postUpgradeAuthorize` - System upgrade authorization functionality (system modification risk)

### User (22 endpoints)

- `postUser` - User creation functionality (account proliferation/privilege escalation risk)
- `deleteUser` - User deletion functionality (denial of service/data loss risk)
- `deleteUserById` - User deletion by ID functionality (denial of service/data loss risk)
- `putUserById` - User update functionality (permission escalation/authentication bypass risk)
- `postUserByIdChangePassword` - Password change functionality (security risk)
- `postUserByIdResetPassword` - Password reset functionality (security risk)
- `postUserCurrentChangePassword` - Current user password change (security risk)
- `postUserByIdClientCredentials` - Client credentials management (security risk)
- `getUserByIdClientCredentials` - Client credentials exposure (security risk)
- `deleteUserByIdClientCredentialsByClientId` - Client credentials manipulation (security risk)
- `getUserById2fa` - 2FA management (security risk)
- `deleteUserById2faByProviderName` - 2FA bypass risk (security risk)
- `getUserCurrent2fa` - 2FA exposure (security risk)
- `deleteUserCurrent2faByProviderName` - 2FA bypass risk (security risk)
- `postUserCurrent2faByProviderName` - 2FA manipulation (security risk)
- `getUserCurrent2faByProviderName` - 2FA exposure (security risk)
- `postUserInvite` - User invitation abuse potential (security risk)
- `postUserInviteCreatePassword` - Invitation hijacking risk (security risk)
- `postUserInviteResend` - Spam/abuse potential (security risk)
- `postUserInviteVerify` - Invitation manipulation (security risk)
- `postUserDisable` - User account lockout risk (security risk)
- `postUserEnable` - Compromised account activation risk (security risk)
- `postUserUnlock` - Account security bypass risk (security risk)

### Profiling (2 endpoints)

- `getProfilingStatus` - System profiling status monitoring (system performance/debugging concerns)
- `putProfilingStatus` - System profiling configuration changes (system performance/stability risk)

### Preview (2 endpoints)

- `deletePreview` - Content preview deletion (frontend-specific functionality)
- `postPreview` - Content preview creation (frontend-specific functionality)

### Oembed (1 endpoint)

- `getOembedQuery` - oEmbed media embedding functionality (frontend-specific functionality)

### Object (1 endpoint)

- `getObjectTypes` - System object type enumeration (internal system functionality)

### Dynamic (2 endpoints)

- `getDynamicRootSteps` - Dynamic root configuration steps (advanced configuration functionality)
- `postDynamicRootQuery` - Dynamic root query processing (advanced configuration functionality)