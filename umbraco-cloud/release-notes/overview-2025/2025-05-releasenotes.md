# May 2025

## Key Takeaways

* **Faster deployments for schema changes** - Deployments with only `*.uda`** changes are now ~80% faster. No full build step required.

## Faster deployments for schema changes

We’ve optimized the deployment flow when only `*.uda` files are changed. These are the files Umbraco Deploy uses to track changes to things like Content Types and Data Types.

Instead of running a full `dotnet restore/build/publish`, we now copy the updated `*.uda` files.
This makes deployments in these cases up to 80% faster, enabling your schema updates to go live in a fraction of the time.
