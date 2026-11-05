# April 2026

## Key Takeaways

* **Always On toggle for Dedicated plans** - A new Always On toggle is available in the Platform Configuration section. It keeps your application loaded at all times so it does not unload after periods of inactivity.
* **Platform Configuration section renamed** - The Auto-Heal Settings section in the Advanced Configuration has been renamed to Platform Configuration and now groups the Proactive Auto-Heal and Always On toggles.
* **Release Umbraco.Cloud.Identity v13.2.7 and Umbraco.Cloud.Cms v13.0.2, v16.0.4, v17.1.1, v17.1.2** - Two bug fixes: B2C backoffice actions no longer throw MsalUiRequiredException, and TrackBootStateNotificationHandler now properly awaits its async HTTP call.
* **Downgrade plan Support** - The "Change plan" feature now supports both upgrades and downgrades for all admin users with self-service plan changes, including environment limit validation and downgrade warnings.

## Always On toggle for Dedicated plans

The Platform Configuration section now includes an **Always On** toggle alongside the Proactive Auto-Heal toggle. Always On keeps your application loaded, so it does not unload after periods of inactivity. Without Always On, an idle application is unloaded to free resources, and the next incoming request has to wait for it to start again.

Changes to either toggle take effect after you select **Save** and confirm the change in the dialog. The environment restarts to apply the new settings.

For more details, see the [Platform Configuration](../../build-and-customize-your-solution/set-up-your-project/project-settings/platform-configuration.md) documentation.

## Platform Configuration section renamed

The section previously called **Auto-Heal Settings** in **Configuration** > **Advanced** has been renamed to **Platform Configuration**. This section now groups the Proactive Auto-Heal and Always On toggles. Each change is applied together through a single **Save** action and a confirmation dialog.

For more details, see the [Platform Configuration](../../build-and-customize-your-solution/set-up-your-project/project-settings/platform-configuration.md) documentation.

## Release Umbraco.Cloud.Identity v13.2.7 and Umbraco.Cloud.Cms v13.0.2, v16.0.4, v17.1.1, v17.1.2

This release fixes a `MsalUiRequiredException` that could occur when performing B2C-authenticated backoffice actions, such as sending user invites. The Microsoft Authentication Library (MSAL) token cache now expires in sync with Umbraco's session configuration. When `KeepUserLoggedIn` is enabled, the token cache refreshes alongside the backoffice cookie [Related GitHub issue](https://github.com/umbraco/Umbraco.Cloud.Issues/issues/1016).

The warm and cold boot tracking feature now properly awaits its async HTTP call instead of discarding it.

## Downgrade plan Support

The "Upgrade project" feature has been renamed to "Change plan" and now supports both upgrades and downgrades. All admin users can change plans via the Cloud Portal with a self-service flow.

The flow validates project state before allowing downgrades:

* **Environment limits** — If your project exceeds the target plan's environment limit, the downgrade is blocked. You must remove environments first.
* **Dedicated resources** — If downgrading from dedicated to shared hosting, you receive a warning that dedicated resources will be switched to shared hosting.
* **Extra environment costs** — If your project has paid extra environments, you see a warning about ongoing costs for those extra environments.

Downgrades take effect immediately with no refund for the remaining month. From the next billing period, you are charged at the new plan's rate.

For full details, see the [Change Plan](../../build-and-customize-your-solution/set-up-your-project/project-settings/change-your-plan.md) documentation.
