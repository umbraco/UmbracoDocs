# April 2024
The following changes have been released to Heartcore sites created on or after February 12th. They will be rolled out to previously existing sites in the second quarter of 2024.

## Grid Disabled By Default
With the grid property editor [becoming deprecated](https://umbraco.com/blog/umbraco-heartcore-update-october-2023/), we have decided to hide related functionality in the backoffice for sites that are not already using it. The replacement for grid; that is, the Block Grid Editor will require some manual effort to migrate to. We would like to remove the possibility for users to inadvertently create more work for themselves by adopting grid.

Sites that already have grid Data Types in use will continue to offer the full range of grid support. Grid content can also be imported from a zip package, which will also fully enable support for it across the environment.

## Notable Bugfixes
Fixes for commonly-reported issues this month include:
* The root endpoint of the management API now correctly returns links to other endpoints.
* The API explorer in the backoffice is no longer prevented from returning responses from the management API due to a Cross-Origin Resource Sharing (CORS) error.
* The alias for dev & staging environments should no longer point at the live content APIs.
