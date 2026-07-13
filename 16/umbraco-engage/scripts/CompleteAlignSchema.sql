/*
    CompleteAlignSchema.sql

    Applies the manual portion of the Engage schema alignment.
    Run during a maintenance window. The script:
      - Validates the migration state in umbracoKeyValue.
      - Applies 7 schema-alignment batches.
      - Updates the migration state to "Complete".

    Per-batch TRY/CATCH plus a global temp table marker (##EngageAlignStatus)
    ensure that a failure in any batch causes subsequent batches to no-op
    cleanly, surfacing the root-cause error in the messages pane.

    Re-run safety: re-running this script after a failed run is safe. The
    validation block accepts either "Aligned" or "Pending" as a starting
    state, and every batch is idempotent.

    -------------------------------------------------------------------------
    CONFIGURATION: SEPARATE-DATABASE MODE
    -------------------------------------------------------------------------
    By default this script assumes Umbraco and Engage share a single
    database. It validates and updates the umbracoKeyValue table directly.

    If your Engage data lives in a SEPARATE database from the Umbraco
    database, change the value below from 0 to 1 BEFORE running the script.

    By setting this flag to 1 you ACKNOWLEDGE that:
      - You have already completed the prerequisite steps documented in
        the Schema Alignment Guide (notably running EnsureDataConsistency.sql
        against the Engage database).
      - The umbracoKeyValue key "Umbraco.Engage+DatabaseSchemaStatus" in
        the Umbraco database is currently "Aligned" (set automatically by
        the Engage startup migration after the package upgrade - no manual
        action required to reach this state).

    In separate-database mode this script will:
      - Skip all umbracoKeyValue reads and writes.
      - Verify (instead) that the Engage tables exist in the current DB.
      - At the end, print the SQL you must manually run against the
        Umbraco database to transition the state directly from "Aligned"
        to "Complete".

    Until that final statement is executed, the Engage health check will
    continue to show the "Aligned" warning.
    -------------------------------------------------------------------------
*/

IF OBJECT_ID('tempdb..##EngageAlignConfig') IS NOT NULL DROP TABLE ##EngageAlignConfig;
CREATE TABLE ##EngageAlignConfig ([separateDatabaseMode] BIT NOT NULL);
INSERT INTO ##EngageAlignConfig VALUES (0);  /* <<< Change to 1 for separate-database mode */
GO

/* Always create the status marker. We populate it only when validation passes. */
IF OBJECT_ID('tempdb..##EngageAlignStatus') IS NOT NULL DROP TABLE ##EngageAlignStatus;
CREATE TABLE ##EngageAlignStatus ([status] nvarchar(50) NOT NULL);
GO

/* ===== Validation ===== */
DECLARE @separateDatabaseMode BIT = (SELECT [separateDatabaseMode] FROM ##EngageAlignConfig);

IF @separateDatabaseMode = 0
BEGIN
    IF OBJECT_ID('[umbracoKeyValue]', 'U') IS NULL
    BEGIN
        RAISERROR ('The umbracoKeyValue table was not found in this database. If Engage data lives in a SEPARATE database from Umbraco, set @separateDatabaseMode to 1 at the top of this script.', 16, 1);
    END
    ELSE IF EXISTS (SELECT 1 FROM [umbracoKeyValue] WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus' AND [value] = 'Complete')
    BEGIN
        RAISERROR ('This migration seems to be executed already as indicated by the umbracoKeyValue table key "Umbraco.Engage+DatabaseSchemaStatus" with value "Complete".', 16, 1);
    END
    ELSE IF NOT EXISTS (SELECT 1 FROM [umbracoKeyValue] WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus' AND [value] IN ('Aligned', 'Pending'))
    BEGIN
        RAISERROR ('The umbracoKeyValue table did not have a valid value for key "Umbraco.Engage+DatabaseSchemaStatus". Ensure that Umbraco Engage is updated to the latest version before running this script.', 16, 1);
    END
    ELSE
    BEGIN
        UPDATE [umbracoKeyValue] SET [value] = 'Pending' WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus' AND [value] = 'Aligned';
        INSERT INTO ##EngageAlignStatus VALUES ('Pending');
        PRINT 'Validation passed - status set to Pending. Proceeding with schema changes...';
    END
END
ELSE
BEGIN
    IF OBJECT_ID('[umbracoEngageAnalyticsScreen]', 'U') IS NULL
    BEGIN
        RAISERROR ('Engage tables were not found in this database. Connect to the Engage database, or set @separateDatabaseMode back to 0 if Engage shares the Umbraco database.', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO ##EngageAlignStatus VALUES ('Pending');
        PRINT '======================================================================';
        PRINT 'Running in SEPARATE-DATABASE mode.';
        PRINT 'The umbracoKeyValue table will NOT be touched by this script.';
        PRINT 'After completion, see the final message for the SQL you must run';
        PRINT 'against the Umbraco database to mark the migration as Complete.';
        PRINT '======================================================================';
    END
END
GO

/* Batch 1: Recreate umbracoEngageAnalyticsScreen with IDENTITY and PK */
IF EXISTS (SELECT 1 FROM ##EngageAlignStatus WHERE [status] = 'Pending')
BEGIN
    BEGIN TRY
        /* Drop a leftover umbracoEngageAnalyticsScreen2 from a prior failed run so this batch is re-runnable */
        DROP TABLE IF EXISTS [umbracoEngageAnalyticsScreen2];

        ALTER TABLE [umbracoEngageAnalyticsScreen] DROP CONSTRAINT IF EXISTS [PK_umbracoEngageAnalyticsScreen];

        CREATE TABLE [umbracoEngageAnalyticsScreen2]
        (
            [id] [bigint] IDENTITY NOT NULL,
            [width] [int] NOT NULL,
            [height] [int] NOT NULL,
            [pixelDepth] [int] NULL,
            [colorDepth] [int] NULL,
            CONSTRAINT [PK_umbracoEngageAnalyticsScreen] PRIMARY KEY CLUSTERED ([id] ASC)
        );

        SET IDENTITY_INSERT [umbracoEngageAnalyticsScreen2] ON;
        INSERT INTO [umbracoEngageAnalyticsScreen2] ([id], [width], [height], [pixelDepth], [colorDepth])
            SELECT [id], [width], [height], [pixelDepth], [colorDepth] FROM [umbracoEngageAnalyticsScreen];
        SET IDENTITY_INSERT [umbracoEngageAnalyticsScreen2] OFF;

        DECLARE @maxId BIGINT = (SELECT ISNULL(MAX([id]), 0) FROM [umbracoEngageAnalyticsScreen2]);
        DBCC CHECKIDENT ('umbracoEngageAnalyticsScreen2', RESEED, @maxId);

        DROP TABLE [umbracoEngageAnalyticsScreen];
        EXEC sp_rename 'umbracoEngageAnalyticsScreen2', 'umbracoEngageAnalyticsScreen';

        PRINT 'Batch 1 complete - umbracoEngageAnalyticsScreen recreated with IDENTITY and PK.';
    END TRY
    BEGIN CATCH
        UPDATE ##EngageAlignStatus SET [status] = 'Failed';
        PRINT 'Batch 1 failed: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END
GO

/* Batch 2: Add foreign key to AbTestVisitorToVariant */
IF EXISTS (SELECT 1 FROM ##EngageAlignStatus WHERE [status] = 'Pending')
BEGIN
    BEGIN TRY
        ALTER TABLE [umbracoEngageAbTestingAbTestVisitorToVariant] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAbTestingAbTestVisitorToVariant_umbracoEngageAbTestingAbTestVariant];
        ALTER TABLE [umbracoEngageAbTestingAbTestVisitorToVariant] ADD CONSTRAINT [FK_umbracoEngageAbTestingAbTestVisitorToVariant_umbracoEngageAbTestingAbTestVariant]
            FOREIGN KEY ([abTestVariantId]) REFERENCES [umbracoEngageAbTestingAbTestVariant] ([id]) ON DELETE CASCADE;

        PRINT 'Batch 2 complete - AbTestVisitorToVariant FK added.';
    END TRY
    BEGIN CATCH
        UPDATE ##EngageAlignStatus SET [status] = 'Failed';
        PRINT 'Batch 2 failed: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END
GO

/* Batch 3: Create new nonclustered indexes */
IF EXISTS (SELECT 1 FROM ##EngageAlignStatus WHERE [status] = 'Pending')
BEGIN
    BEGIN TRY
        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsDevice'), 'IX_umbracoEngageAnalyticsDevice_browserVersionId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsDevice_browserVersionId] ON [umbracoEngageAnalyticsDevice] ([browserVersionId] ASC);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsIpAddress'), 'IX_umbracoEngageAnalyticsIpAddress_locationId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsIpAddress_locationId] ON [umbracoEngageAnalyticsIpAddress] ([locationId] ASC);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsIpLocation'), 'IX_umbracoEngageAnalyticsIpLocation_cityId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsIpLocation_cityId] ON [umbracoEngageAnalyticsIpLocation] ([cityId] ASC);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsIpLocation'), 'IX_umbracoEngageAnalyticsIpLocation_countyId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsIpLocation_countyId] ON [umbracoEngageAnalyticsIpLocation] ([countyId] ASC);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsIpLocation'), 'IX_umbracoEngageAnalyticsIpLocation_provinceId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsIpLocation_provinceId] ON [umbracoEngageAnalyticsIpLocation] ([provinceId] ASC);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsPageviewPersonalizationSegment'), 'IX_umbracoEngageAnalyticsPageviewPersonalizationSegment_pageviewId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsPageviewPersonalizationSegment_pageviewId] ON [umbracoEngageAnalyticsPageviewPersonalizationSegment] ([pageviewId] ASC) INCLUDE ([id]);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsSearchQuery'), 'IX_umbracoEngageAnalyticsSearchQuery_pageviewId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsSearchQuery_pageviewId] ON [umbracoEngageAnalyticsSearchQuery] ([pageviewId] ASC) INCLUDE ([id]);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsSession'), 'IX_umbracoEngageAnalyticsSession_deviceId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsSession_deviceId] ON [umbracoEngageAnalyticsSession] ([deviceId] ASC);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsUmbracoFormsSubmissionAction'), 'IX_umbracoEngageAnalyticsUmbracoFormsSubmissionAction_fieldId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsUmbracoFormsSubmissionAction_fieldId] ON [umbracoEngageAnalyticsUmbracoFormsSubmissionAction] ([fieldId] ASC) INCLUDE ([id]);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsUmbracoFormsSubmissionAction'), 'IX_umbracoEngageAnalyticsUmbracoFormsSubmissionAction_submissionId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsUmbracoFormsSubmissionAction_submissionId] ON [umbracoEngageAnalyticsUmbracoFormsSubmissionAction] ([submissionId] ASC) INCLUDE ([id]);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsUmbracoFormsSubmissionError'), 'IX_umbracoEngageAnalyticsUmbracoFormsSubmissionError_fieldId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsUmbracoFormsSubmissionError_fieldId] ON [umbracoEngageAnalyticsUmbracoFormsSubmissionError] ([fieldId] ASC) INCLUDE ([id]);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsUmbracoFormsSubmissionError'), 'IX_umbracoEngageAnalyticsUmbracoFormsSubmissionError_submissionId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsUmbracoFormsSubmissionError_submissionId] ON [umbracoEngageAnalyticsUmbracoFormsSubmissionError] ([submissionId] ASC) INCLUDE ([id]);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsVideoEvent'), 'IX_umbracoEngageAnalyticsVideoEvent_pageviewId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsVideoEvent_pageviewId] ON [umbracoEngageAnalyticsVideoEvent] ([pageviewId] ASC) INCLUDE ([id]);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsVideoStatistics'), 'IX_umbracoEngageAnalyticsVideoStatistics_pageviewId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsVideoStatistics_pageviewId] ON [umbracoEngageAnalyticsVideoStatistics] ([pageviewId] ASC) INCLUDE ([id]);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsVideoStatistics'), 'IX_umbracoEngageAnalyticsVideoStatistics_videoId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsVideoStatistics_videoId] ON [umbracoEngageAnalyticsVideoStatistics] ([videoId] ASC) INCLUDE ([id]);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsVisitorTypeBotVersion'), 'IX_umbracoEngageAnalyticsVisitorTypeBotVersion_botId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsVisitorTypeBotVersion_botId] ON [umbracoEngageAnalyticsVisitorTypeBotVersion] ([botId] ASC) INCLUDE ([id]);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsVisitorTypeBotVersion'), 'IX_umbracoEngageAnalyticsVisitorTypeBotVersion_visitorId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsVisitorTypeBotVersion_visitorId] ON [umbracoEngageAnalyticsVisitorTypeBotVersion] ([visitorId] ASC) INCLUDE ([id]);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsVisitorTypeMonitor'), 'IX_umbracoEngageAnalyticsVisitorTypeMonitor_visitorId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsVisitorTypeMonitor_visitorId] ON [umbracoEngageAnalyticsVisitorTypeMonitor] ([visitorId] ASC) INCLUDE ([id]);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngageAnalyticsVisitorTypeSpam'), 'IX_umbracoEngageAnalyticsVisitorTypeSpam_visitorId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsVisitorTypeSpam_visitorId] ON [umbracoEngageAnalyticsVisitorTypeSpam] ([visitorId] ASC) INCLUDE ([id]);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngagePersonalizationGoalCustomerJourneyScoring'), 'IX_umbracoEngagePersonalizationGoalCustomerJourneyScoring_goalId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngagePersonalizationGoalCustomerJourneyScoring_goalId] ON [umbracoEngagePersonalizationGoalCustomerJourneyScoring] ([goalId] ASC);

        IF INDEXPROPERTY(OBJECT_ID('umbracoEngagePersonalizationGoalPersonaScoring'), 'IX_umbracoEngagePersonalizationGoalPersonaScoring_goalId', 'IndexID') IS NULL
            CREATE NONCLUSTERED INDEX [IX_umbracoEngagePersonalizationGoalPersonaScoring_goalId] ON [umbracoEngagePersonalizationGoalPersonaScoring] ([goalId] ASC);

        PRINT 'Batch 3 complete - new nonclustered indexes created.';
    END TRY
    BEGIN CATCH
        UPDATE ##EngageAlignStatus SET [status] = 'Failed';
        PRINT 'Batch 3 failed: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END
GO

/* Batch 4: Drop/recreate existing indexes (CLUSTERED -> NONCLUSTERED, add INCLUDEs) */
IF EXISTS (SELECT 1 FROM ##EngageAlignStatus WHERE [status] = 'Pending')
BEGIN
    BEGIN TRY
        DROP INDEX IF EXISTS [IX_umbracoEngageAbTestingAbTestVisitorToVariant_visitorId] ON [umbracoEngageAbTestingAbTestVisitorToVariant];
        CREATE NONCLUSTERED INDEX [IX_umbracoEngageAbTestingAbTestVisitorToVariant_visitorId] ON [umbracoEngageAbTestingAbTestVisitorToVariant] ([visitorId] ASC) INCLUDE ([id]);

        DROP INDEX IF EXISTS [IX_umbracoEngageAnalyticsLinks_pageId] ON [umbracoEngageAnalyticsLinks];
        CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsLinks_pageId] ON [umbracoEngageAnalyticsLinks] ([pageId] ASC) INCLUDE ([id]);

        DROP INDEX IF EXISTS [IX_umbracoEngageAnalyticsLinks_pageviewId] ON [umbracoEngageAnalyticsLinks];
        CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsLinks_pageviewId] ON [umbracoEngageAnalyticsLinks] ([pageviewId] ASC) INCLUDE ([id]);

        DROP INDEX IF EXISTS [IX_umbracoEngageAnalyticsPageEvent_pageviewId] ON [umbracoEngageAnalyticsPageEvent];
        CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsPageEvent_pageviewId] ON [umbracoEngageAnalyticsPageEvent] ([pageviewId] ASC) INCLUDE ([id]);

        DROP INDEX IF EXISTS [IX_umbracoEngageAnalyticsPageview_guid] ON [umbracoEngageAnalyticsPageview];
        CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsPageview_guid] ON [umbracoEngageAnalyticsPageview] ([guid] ASC) INCLUDE ([id]);

        DROP INDEX IF EXISTS [IX_umbracoEngageAnalyticsPageview_ipAddressId] ON [umbracoEngageAnalyticsPageview];
        CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsPageview_ipAddressId] ON [umbracoEngageAnalyticsPageview] ([ipAddressId] ASC) INCLUDE([id]);

        DROP INDEX IF EXISTS [IX_umbracoEngageAnalyticsPageview_sessionId] ON [umbracoEngageAnalyticsPageview];
        CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsPageview_sessionId] ON [umbracoEngageAnalyticsPageview] ([sessionId] ASC) INCLUDE ([id]);

        DROP INDEX IF EXISTS [IX_umbracoEngageAnalyticsPageviewPersonalizationSegment_segmentId] ON [umbracoEngageAnalyticsPageviewPersonalizationSegment];
        CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsPageviewPersonalizationSegment_segmentId] ON [umbracoEngageAnalyticsPageviewPersonalizationSegment] ([segmentId] ASC) INCLUDE([id]);

        DROP INDEX IF EXISTS [IX_umbracoEngageAnalyticsScrollDepth_pageviewId] ON [umbracoEngageAnalyticsScrollDepth];
        CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsScrollDepth_pageviewId] ON [umbracoEngageAnalyticsScrollDepth] ([pageviewId] ASC) INCLUDE ([id]);

        DROP INDEX IF EXISTS [IX_umbracoEngageAnalyticsTimeOnPage_pageviewId] ON [umbracoEngageAnalyticsTimeOnPage];
        CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsTimeOnPage_pageviewId] ON [umbracoEngageAnalyticsTimeOnPage] ([pageviewId] ASC) INCLUDE ([id]);

        DROP INDEX IF EXISTS [IX_umbracoEngageAnalyticsUmbracoFormsSubmission_pageviewId] ON [umbracoEngageAnalyticsUmbracoFormsSubmission];
        CREATE NONCLUSTERED INDEX [IX_umbracoEngageAnalyticsUmbracoFormsSubmission_pageviewId] ON [umbracoEngageAnalyticsUmbracoFormsSubmission] ([pageviewId] ASC) INCLUDE ([id]);

        PRINT 'Batch 4 complete - existing indexes updated.';
    END TRY
    BEGIN CATCH
        UPDATE ##EngageAlignStatus SET [status] = 'Failed';
        PRINT 'Batch 4 failed: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END
GO

/* Batch 5: Update foreign keys to ON DELETE CASCADE */
IF EXISTS (SELECT 1 FROM ##EngageAlignStatus WHERE [status] = 'Pending')
BEGIN
    BEGIN TRY
        ALTER TABLE [umbracoEngageAbTestingAbTestVariant] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAbTestingAbTestVariant_umbracoEngageAbTestingAbTest];
        ALTER TABLE [umbracoEngageAbTestingAbTestVariant] ADD CONSTRAINT [FK_umbracoEngageAbTestingAbTestVariant_umbracoEngageAbTestingAbTest]
            FOREIGN KEY ([abTestId]) REFERENCES [umbracoEngageAbTestingAbTest] ([id]) ON DELETE CASCADE;

        ALTER TABLE [umbracoEngageAbTestingAbTestVisitorToVariant] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAbTestingAbTestVisitorToVariant_umbracoEngageAnalyticsVisitor];
        ALTER TABLE [umbracoEngageAbTestingAbTestVisitorToVariant] ADD CONSTRAINT [FK_umbracoEngageAbTestingAbTestVisitorToVariant_umbracoEngageAnalyticsVisitor]
            FOREIGN KEY ([visitorId]) REFERENCES [umbracoEngageAnalyticsVisitor] ([id]) ON DELETE CASCADE;

        ALTER TABLE [umbracoEngageAnalyticsGoalCompletion] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAnalyticsGoalCompletion_umbracoEngageAnalyticsPageview];
        ALTER TABLE [umbracoEngageAnalyticsGoalCompletion] ADD CONSTRAINT [FK_umbracoEngageAnalyticsGoalCompletion_umbracoEngageAnalyticsPageview]
            FOREIGN KEY ([pageviewId]) REFERENCES [umbracoEngageAnalyticsPageview] ([id]) ON DELETE CASCADE;

        ALTER TABLE [umbracoEngageAnalyticsLinks] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAnalyticsLinks_umbracoEngageAnalyticsPageview];
        ALTER TABLE [umbracoEngageAnalyticsLinks] ADD CONSTRAINT [FK_umbracoEngageAnalyticsLinks_umbracoEngageAnalyticsPageview]
            FOREIGN KEY ([pageviewId]) REFERENCES [umbracoEngageAnalyticsPageview] ([id]) ON DELETE CASCADE;

        ALTER TABLE [umbracoEngageAnalyticsPageEvent] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAnalyticsPageEvent_umbracoEngageAnalyticsPageview];
        ALTER TABLE [umbracoEngageAnalyticsPageEvent] ADD CONSTRAINT [FK_umbracoEngageAnalyticsPageEvent_umbracoEngageAnalyticsPageview]
            FOREIGN KEY ([pageviewId]) REFERENCES [umbracoEngageAnalyticsPageview] ([id]) ON DELETE CASCADE;

        ALTER TABLE [umbracoEngageAnalyticsPageviewPersonalizationSegment] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAnalyticsPageviewPersonalizationSegment_umbracoEngageAnalyticsPageview];
        ALTER TABLE [umbracoEngageAnalyticsPageviewPersonalizationSegment] ADD CONSTRAINT [FK_umbracoEngageAnalyticsPageviewPersonalizationSegment_umbracoEngageAnalyticsPageview]
            FOREIGN KEY ([pageviewId]) REFERENCES [umbracoEngageAnalyticsPageview] ([id]) ON DELETE CASCADE;

        ALTER TABLE [umbracoEngageAnalyticsScrollDepth] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAnalyticsScrollDepth_umbracoEngageAnalyticsPageview];
        ALTER TABLE [umbracoEngageAnalyticsScrollDepth] ADD CONSTRAINT [FK_umbracoEngageAnalyticsScrollDepth_umbracoEngageAnalyticsPageview]
            FOREIGN KEY ([pageviewId]) REFERENCES [umbracoEngageAnalyticsPageview] ([id]) ON DELETE CASCADE;

        ALTER TABLE [umbracoEngageAnalyticsSearchQuery] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAnalyticsSearchQuery_umbracoEngageAnalyticsPageview];
        ALTER TABLE [umbracoEngageAnalyticsSearchQuery] ADD CONSTRAINT [FK_umbracoEngageAnalyticsSearchQuery_umbracoEngageAnalyticsPageview]
            FOREIGN KEY ([pageviewId]) REFERENCES [umbracoEngageAnalyticsPageview] ([id]) ON DELETE CASCADE;

        ALTER TABLE [umbracoEngageAnalyticsTimeOnPage] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAnalyticsTimeOnPage_umbracoEngageAnalyticsPageview];
        ALTER TABLE [umbracoEngageAnalyticsTimeOnPage] ADD CONSTRAINT [FK_umbracoEngageAnalyticsTimeOnPage_umbracoEngageAnalyticsPageview]
            FOREIGN KEY ([pageviewId]) REFERENCES [umbracoEngageAnalyticsPageview] ([id]) ON DELETE CASCADE;

        ALTER TABLE [umbracoEngageAnalyticsVisitorTypeBotVersion] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAnalyticsVisitorTypeBotVersion_umbracoEngageAnalyticsVisitor];
        ALTER TABLE [umbracoEngageAnalyticsVisitorTypeBotVersion] ADD CONSTRAINT [FK_umbracoEngageAnalyticsVisitorTypeBotVersion_umbracoEngageAnalyticsVisitor]
            FOREIGN KEY ([visitorId]) REFERENCES [umbracoEngageAnalyticsVisitor] ([id]) ON DELETE CASCADE;

        ALTER TABLE [umbracoEngageAnalyticsVisitorTypeBotVersion] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAnalyticsVisitorTypeBotVersion_umbracoEngageAnalyticsVisitorTypeBot];
        ALTER TABLE [umbracoEngageAnalyticsVisitorTypeBotVersion] ADD CONSTRAINT [FK_umbracoEngageAnalyticsVisitorTypeBotVersion_umbracoEngageAnalyticsVisitorTypeBot]
            FOREIGN KEY ([botId]) REFERENCES [umbracoEngageAnalyticsVisitorTypeBot] ([id]) ON DELETE CASCADE;

        ALTER TABLE [umbracoEngageAnalyticsVisitorTypeMonitor] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAnalyticsVisitorTypeMonitor_umbracoEngageAnalyticsVisitor];
        ALTER TABLE [umbracoEngageAnalyticsVisitorTypeMonitor] ADD CONSTRAINT [FK_umbracoEngageAnalyticsVisitorTypeMonitor_umbracoEngageAnalyticsVisitor]
            FOREIGN KEY ([visitorId]) REFERENCES [umbracoEngageAnalyticsVisitor] ([id]) ON DELETE CASCADE;

        ALTER TABLE [umbracoEngageAnalyticsVisitorTypeSpam] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAnalyticsVisitorTypeSpam_umbracoEngageAnalyticsVisitor];
        ALTER TABLE [umbracoEngageAnalyticsVisitorTypeSpam] ADD CONSTRAINT [FK_umbracoEngageAnalyticsVisitorTypeSpam_umbracoEngageAnalyticsVisitor]
            FOREIGN KEY ([visitorId]) REFERENCES [umbracoEngageAnalyticsVisitor] ([id]) ON DELETE CASCADE;

        PRINT 'Batch 5 complete - foreign keys updated to ON DELETE CASCADE.';
    END TRY
    BEGIN CATCH
        UPDATE ##EngageAlignStatus SET [status] = 'Failed';
        PRINT 'Batch 5 failed: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END
GO

/* Batch 6: Update primary keys from NONCLUSTERED to CLUSTERED */
IF EXISTS (SELECT 1 FROM ##EngageAlignStatus WHERE [status] = 'Pending')
BEGIN
    BEGIN TRY
        ALTER TABLE [umbracoEngageAnalyticsAnnotationPageVariant] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAnalyticsAnnotationPageVariant_umbracoEngageAnalyticsAnnotation];
        ALTER TABLE [umbracoEngageAnalyticsAnnotation] DROP CONSTRAINT IF EXISTS [PK_umbracoEngageAnalyticsAnnotation];
        ALTER TABLE [umbracoEngageAnalyticsAnnotation] ADD CONSTRAINT [PK_umbracoEngageAnalyticsAnnotation] PRIMARY KEY CLUSTERED ([id] ASC);
        ALTER TABLE [umbracoEngageAnalyticsAnnotationPageVariant] ADD CONSTRAINT [FK_umbracoEngageAnalyticsAnnotationPageVariant_umbracoEngageAnalyticsAnnotation]
            FOREIGN KEY ([annotationId]) REFERENCES [umbracoEngageAnalyticsAnnotation] ([id]) ON DELETE CASCADE;

        ALTER TABLE [umbracoEngageAnalyticsAnnotationPageVariant] DROP CONSTRAINT IF EXISTS [PK_umbracoEngageAnalyticsAnnotationPageVariant];
        ALTER TABLE [umbracoEngageAnalyticsAnnotationPageVariant] ADD CONSTRAINT [PK_umbracoEngageAnalyticsAnnotationPageVariant] PRIMARY KEY CLUSTERED ([id] ASC);

        ALTER TABLE [umbracoEngageAnalyticsLinks] DROP CONSTRAINT IF EXISTS [PK_umbracoEngageAnalyticsLinks];
        ALTER TABLE [umbracoEngageAnalyticsLinks] ADD CONSTRAINT [PK_umbracoEngageAnalyticsLinks] PRIMARY KEY CLUSTERED ([id] ASC);

        ALTER TABLE [umbracoEngageAnalyticsScrollDepth] DROP CONSTRAINT IF EXISTS [PK_umbracoEngageAnalyticsScrollDepth];
        ALTER TABLE [umbracoEngageAnalyticsScrollDepth] ADD CONSTRAINT [PK_umbracoEngageAnalyticsScrollDepth] PRIMARY KEY CLUSTERED ([id] ASC);

        ALTER TABLE [umbracoEngageAnalyticsTimeOnPage] DROP CONSTRAINT IF EXISTS [PK_umbracoEngageAnalyticsTimeOnPage];
        ALTER TABLE [umbracoEngageAnalyticsTimeOnPage] ADD CONSTRAINT [PK_umbracoEngageAnalyticsTimeOnPage] PRIMARY KEY CLUSTERED ([id] ASC);

        ALTER TABLE [umbracoEngageLock] DROP CONSTRAINT IF EXISTS [PK_umbracoEngageLock];
        ALTER TABLE [umbracoEngageLock] ADD CONSTRAINT [PK_umbracoEngageLock] PRIMARY KEY CLUSTERED ([name] ASC);

        ALTER TABLE [umbracoEngageSettingsIpFilterIpAddress] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageSettingsIpFilterIpAddress_umbracoEngageSettingsIpFilter];
        ALTER TABLE [umbracoEngageSettingsIpFilter] DROP CONSTRAINT IF EXISTS [PK_umbracoEngageSettingsIpFilter];
        ALTER TABLE [umbracoEngageSettingsIpFilter] ADD CONSTRAINT [PK_umbracoEngageSettingsIpFilter] PRIMARY KEY CLUSTERED ([id] ASC);
        ALTER TABLE [umbracoEngageSettingsIpFilterIpAddress] ADD CONSTRAINT [FK_umbracoEngageSettingsIpFilterIpAddress_umbracoEngageSettingsIpFilter]
            FOREIGN KEY([ipFilterId]) REFERENCES [umbracoEngageSettingsIpFilter] ([id]) ON DELETE CASCADE;

        ALTER TABLE [umbracoEngageSettingsIpFilterIpAddress] DROP CONSTRAINT IF EXISTS [PK_umbracoEngageSettingsIpFilterIpAddress];
        ALTER TABLE [umbracoEngageSettingsIpFilterIpAddress] ADD CONSTRAINT [PK_umbracoEngageSettingsIpFilterIpAddress] PRIMARY KEY CLUSTERED ([id] ASC);

        PRINT 'Batch 6 complete - primary keys updated to CLUSTERED.';
    END TRY
    BEGIN CATCH
        UPDATE ##EngageAlignStatus SET [status] = 'Failed';
        PRINT 'Batch 6 failed: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END
GO

/* Batch 7: Clean up page variants with NULL contentTypeId and enforce NOT NULL */
IF EXISTS (SELECT 1 FROM ##EngageAlignStatus WHERE [status] = 'Pending')
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM [umbracoEngageAnalyticsUmbracoPageVariant] WHERE [contentTypeId] IS NULL)
        BEGIN
            UPDATE [umbracoEngageAnalyticsPageview]
            SET [umbracoPageVariantId] = NULL
            WHERE [umbracoPageVariantId] IN (
                SELECT [id] FROM [umbracoEngageAnalyticsUmbracoPageVariant] WHERE [contentTypeId] IS NULL
            );

            DELETE FROM [umbracoEngageAnalyticsUmbracoPageVariant] WHERE [contentTypeId] IS NULL;
        END

        ALTER TABLE [umbracoEngageAnalyticsUmbracoPageVariant] ALTER COLUMN [contentTypeId] int NOT NULL;

        PRINT 'Batch 7 complete - page variants with NULL contentTypeId cleaned up, column set to NOT NULL.';
    END TRY
    BEGIN CATCH
        UPDATE ##EngageAlignStatus SET [status] = 'Failed';
        PRINT 'Batch 7 failed: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END
GO

/* ===== Finalise ===== */
DECLARE @separateDatabaseMode BIT = (SELECT [separateDatabaseMode] FROM ##EngageAlignConfig);

IF EXISTS (SELECT 1 FROM ##EngageAlignStatus WHERE [status] = 'Pending')
BEGIN
    IF @separateDatabaseMode = 0
    BEGIN
        UPDATE [umbracoKeyValue] SET [value] = 'Complete' WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus';
        PRINT 'Migration script finished successfully - status set to Complete.';
    END
    ELSE
    BEGIN
        PRINT '======================================================================';
        PRINT 'Engage schema alignment finished successfully.';
        PRINT '';
        PRINT 'ACTION REQUIRED: run the following statement against your UMBRACO';
        PRINT 'database to mark the migration as Complete:';
        PRINT '';
        PRINT '  UPDATE [umbracoKeyValue]';
        PRINT '     SET [value] = ''Complete''';
        PRINT '   WHERE [key] = ''Umbraco.Engage+DatabaseSchemaStatus'';';
        PRINT '';
        PRINT 'Until that statement is executed the Engage health check will keep';
        PRINT 'showing the "Aligned" warning.';
        PRINT '======================================================================';
    END
END
ELSE IF NOT EXISTS (SELECT 1 FROM ##EngageAlignStatus)
BEGIN
    PRINT 'No batches were run - validation did not pass. See errors above.';
END
ELSE
BEGIN
    PRINT 'Migration did NOT complete successfully. Inspect the messages above, address the failure, and re-run this script.';
END

DROP TABLE IF EXISTS ##EngageAlignStatus;
DROP TABLE IF EXISTS ##EngageAlignConfig;
GO
