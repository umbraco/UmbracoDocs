---
meta.Title: Import on startup
description: How to import content and schema on startup and implement your own `IArtifactImportOnStartupProvider`
---

# Import on startup

Deploy can import content and/or schema previously exported from another Umbraco installation on start-up. This allows for a quick setup of a baseline/starter kit or serves as a workaround for large ZIP archives that cannot be uploaded via the backoffice.

## Default configuration

The default configuration will look for the ZIP archive `umbraco\Deploy\import-on-startup.zip` on start-up and if it exists, run an import and delete the file on successful completion. If you want to customize the default behavior, do so via [settings](../getting-started/deploy-settings.md#import-on-startup).

This feature is extensible via a provider-based model by implementing `IArtifactImportOnStartupProvider` and registering it using `builder.DeployArtifactImportOnStartupProviders()`. The default `Umbraco.Deploy.Infrastructure.SettingsArtifactImportOnStartupProvider` implementation uses the above settings and inherits from `Umbraco.Deploy.Infrastructure.ArtifactImportOnStartupProviderZipArchiveBase` (which can be used for your own custom implementation).

## Implementing your own `IArtifactImportOnStartupProvider`

An example of an import on a start-up provider that imports from a physical directory (instead of ZIP archive) is shown below:

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Extensions;
using Umbraco.Deploy.Core;
using Umbraco.Deploy.Core.OperationStatus;
using Umbraco.Deploy.Infrastructure.Extensions;

internal sealed class DeployImportOnStartupComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.DeployArtifactImportOnStartupProviders()
        .Append<PhysicalDirectoryArtifactImportOnStartupProvider>();

    private sealed class PhysicalDirectoryArtifactImportOnStartupProvider : IArtifactImportOnStartupProvider
    {
        private readonly IArtifactImportExportService _artifactImportExportService;
        private readonly ILogger _logger;
        private readonly string _artifactsPath;

        public PhysicalDirectoryArtifactImportOnStartupProvider(IArtifactImportExportService artifactImportExportService, ILogger<PhysicalDirectoryArtifactImportOnStartupProvider> logger, IHostEnvironment hostEnvironment)
        {
            _artifactImportExportService = artifactImportExportService;
            _logger = logger;
            _artifactsPath = hostEnvironment.MapPathContentRoot("~/umbraco/Deploy/ImportOnStartup");
        }

        public Task<bool> CanImportAsync(CancellationToken cancellationToken = default)
            => Task.FromResult(Directory.Exists(_artifactsPath));

        public async Task<Attempt<ImportArtifactsOperationStatus>> ImportAsync(CancellationToken cancellationToken = default)
        {
            _logger.LogInformation("Importing Umbraco content and/or schema import at startup from directory {FilePath}.", _artifactsPath);

            Attempt<ImportArtifactsOperationStatus> attempt = await _artifactImportExportService.ImportArtifactsAsync(_artifactsPath, default, null, cancellationToken);

            _logger.LogInformation("Imported Umbraco content and/or schema import at startup from directory {FilePath} with status: {OperationStatus}.", _artifactsPath, attempt.Result);

            return attempt;
        }

        public Task OnImportCompletedAsync()
        {
            Directory.Delete(_artifactsPath, true);

            return Task.CompletedTask;
        }
    }
}
```