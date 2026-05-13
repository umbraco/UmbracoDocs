---
description: Configure authentication, authorization, SSL, hardening, and other security options in Umbraco.
---

# Security

Umbraco supports a range of security features for both the backoffice and front-end of your website. Use these guides to configure authentication, harden your installation, and manage sensitive data.

## Authentication

* [External Login Providers](external-login-providers.md) - configure OAuth/OpenID Connect providers such as Entra ID, Google, or Facebook for backoffice users and members.
* [Two-Factor Authentication](two-factor-authentication.md) - implement a TOTP-based two-factor authentication provider for members.
* [BackOffice User Manager and Notifications](backofficeusermanager-and-notifications.md) - work with the ASP.NET Core Identity UserManager implementation for Umbraco users.
* [Custom Password Check](custom-password-check.md) - validate username and password credentials against a custom credentials store.
* [Lightweight External Members](lightweight-external-members.md) - authenticate members through an external identity provider without storing them as full content entities.
* [Basic Authentication](basic-authentication.md) - protect the front-end of your website using backoffice user credentials.

## Hardening and Configuration

* [SSL/HTTPS](ssl-https.md) - configure your Umbraco site to use HTTPS.
* [Security Settings](security-settings.md) - configure password and security settings in Umbraco.
* [Security Hardening](security-hardening.md) - harden your Umbraco installation against common threats.
* [API Rate Limiting](api-rate-limiting.md) - apply rate limiting to Umbraco using ASP.NET Core's built-in middleware.
* [Azure Key Vault](key-vault.md) - store and retrieve secrets using Azure Key Vault.
* [Cookies](cookies.md) - understand the cookies required for accessing the Umbraco backoffice.
* [Server-side File Validation](serverside-file-validation.md) - implement file validation for uploaded files.
* [Server-side Sanitizing](serverside-sanitizing.md) - sanitize Rich Text Editor content on the server side.
* [Setup Umbraco for a FIPS Compliant Server](setup-umbraco-for-a-fips-server.md) - configure Umbraco to run on a FIPS compliant server.

## Members and Data

* [Sensitive Data on Members](sensitive-data-on-members.md) - mark member fields as sensitive to restrict access in the backoffice.
* [Reset Admin Password](reset-admin-password.md) - reset the password of the admin user.
* [Password Reset](password-reset.md) - reset passwords for non-admin backoffice users.

## External Resources

* [The Umbraco Trust Center](https://umbraco.com/about-us/trust-center/) - security details, vulnerability reporting, and compliance information for Umbraco CMS.
* [Security on Umbraco Cloud](https://docs.umbraco.com/umbraco-cloud/security) - security details specific to Umbraco Cloud hosting.
* [Health Checks](../infrastructure-and-ops/health-check/) - run health checks to verify the security and configuration of your Umbraco installation.

## Umbraco Training

Umbraco HQ offers a full-day training course covering an overview of Transport Layer Security (TLS), understanding threats, two-factor authentication, and more. The course targets frontend and backend developers, designers, and technical users.

[Explore the Security Training Course](https://umbraco.com/training/course-details/security/) to learn more about the topics covered and how it can enhance your Umbraco development skills.
