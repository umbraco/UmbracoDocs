---
description: The tools that have been excluded from the Developer MCP
---

# Excluded tools

**⚠️ Intentionally Excluded:** 69 endpoints across 14 categories

Certain endpoints are intentionally not implemented due to security, complexity, or contextual concerns.

### Excluded Groups Summary

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

### User Group (3 endpoints)
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

## Rationale

Import/Export endpoints are excluded because:
1. They typically handle complex file operations that are better managed through the Umbraco UI
2. Import operations can have wide-ranging effects on the system
3. Export formats may be complex and not suitable for MCP tool responses
4. These operations often require additional validation and user confirmation

Install endpoints are excluded because:
1. Installation operations modify core system configuration and should only be performed during initial setup
2. Database validation during installation involves sensitive system checks
3. Installation settings contain system-level configuration that should not be exposed or modified after setup
4. These operations are typically only relevant during the initial Umbraco installation process

Package endpoints are excluded because:
1. Package creation and management involve complex file operations
2. Package installation can have system-wide effects requiring careful validation
3. Package migration operations should be handled with caution in the Umbraco UI
4. Download functionality may not be suitable for MCP tool responses

Security endpoints are excluded because:
1. Password reset operations involve sensitive security workflows
2. These operations typically require email verification and user interaction
3. Security configuration changes should be handled carefully through the Umbraco UI
4. Automated security operations could pose security risks if misused

Telemetry endpoints are excluded because:
1. System telemetry data may contain sensitive system information

User Group membership endpoints are excluded because:
1. These operations present severe permission escalation risks
2. AI could potentially assign users to administrator groups
3. User group membership changes can compromise system security
4. These sensitive operations should only be performed through the Umbraco UI with proper oversight

PublishedCache endpoints are excluded because:
1. Cache rebuild operations can significantly impact system performance and should be carefully timed
2. Cache operations can affect site availability and user experience during execution
3. Cache rebuild status monitoring could expose sensitive system performance information

Upgrade endpoints are excluded because:
1. System upgrade operations involve critical system modifications that could break the installation
2. Upgrade settings contain sensitive system configuration that should not be exposed
3. Upgrade authorization involves system-level changes that require careful oversight
4. These operations are typically only relevant during major version upgrades and should be handled through the Umbraco UI

User endpoints are excluded because:
1. User creation could enable account proliferation and privilege escalation attacks
2. User deletion could cause denial of service by removing critical admin accounts and permanent data loss
3. Password operations could enable account takeover and bypass security controls
4. 2FA management could compromise multi-factor authentication security
5. Client credentials expose sensitive API keys and authentication tokens
6. User invitation system could be abused for spam or unauthorized account creation
7. User state changes (disable/enable/unlock) could be used for denial of service attacks
8. These operations require secure UI flows with proper validation and user confirmation
9. Automated user security operations pose significant risks if misused by AI systems

Profiling endpoints are excluded because:
1. These endpoints control the MiniProfiler, which is a frontend debugging tool for web browsers
2. Profiler activation and status are not relevant for MCP operations that work with data rather than UI
3. The MiniProfiler is designed for developer debugging during web development, not for automated API interactions
4. These operations are frontend-specific functionality that has no use case in the MCP context

Preview endpoints are excluded because:
1. Content preview functionality is designed for frontend website display and user interface interactions
2. Preview operations are primarily used for content editors to see how content will appear on the website
3. These operations are frontend-specific and not relevant for automated data management through MCP

Oembed endpoints are excluded because:
1. oEmbed functionality is used for embedding external media content (videos, social media posts) into rich text editor
2. This is primarily a frontend feature for content display and presentation

Object endpoints are excluded because:
1. Object type enumeration provides internal system metadata about Umbraco's object structure
2. This information is primarily used by the Umbraco backend for internal operations and UI generation

Dynamic endpoints are excluded because:
1. Dynamic root functionality is an advanced configuration feature for creating custom content tree structures
2. These operations are better compled using the UI