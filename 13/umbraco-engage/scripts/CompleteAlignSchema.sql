/* Validation and status update */
IF OBJECT_ID('[umbracoKeyValue]', 'U') IS NULL
BEGIN
    RAISERROR ('The umbracoKeyValue table was not found in this database. The key "Umbraco.Engage+DatabaseSchemaStatus" should have value "Aligned" before running this script and will be set to "Complete" by this script once it has completed successfully. This is most likely because Engage data is stored in a separate database from Umbraco.', 16, 1);
END
ELSE IF EXISTS (SELECT 1 FROM [umbracoKeyValue] WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus' AND [value] = 'Complete')
BEGIN
    RAISERROR ('This migration seems to be executed already as indicated by the umbracoKeyValue table key "Umbraco.Engage+DatabaseSchemaStatus" with value "Complete".', 16, 1);
END
ELSE IF NOT EXISTS (SELECT 1 FROM [umbracoKeyValue] WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus' AND [value] IN ('Aligned', 'Complete'))
BEGIN
    RAISERROR ('The umbracoKeyValue table did not have a valid value for key "Umbraco.Engage+DatabaseSchemaStatus". Ensure that Umbraco Engage is updated to the latest version before running this script.', 16, 1);
END
ELSE
BEGIN
    /* Set status to Pending so subsequent batches can gate on it */
    UPDATE [umbracoKeyValue] SET [value] = 'Pending' WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus';
    PRINT 'Validation passed – status set to Pending. Proceeding with schema changes...';
END
GO

/* Batch 1: Recreate umbracoEngageAnalyticsScreen with IDENTITY and PK */
IF EXISTS (SELECT 1 FROM [umbracoKeyValue] WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus' AND [value] = 'Pending')
BEGIN
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

    PRINT 'Batch 1 complete – umbracoEngageAnalyticsScreen recreated with IDENTITY and PK.';
END
GO

/* Batch 2: Add foreign key to AbTestVisitorToVariant */
IF EXISTS (SELECT 1 FROM [umbracoKeyValue] WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus' AND [value] = 'Pending')
BEGIN
    ALTER TABLE [umbracoEngageAbTestingAbTestVisitorToVariant] DROP CONSTRAINT IF EXISTS [FK_umbracoEngageAbTestingAbTestVisitorToVariant_umbracoEngageAbTestingAbTestVariant];
    ALTER TABLE [umbracoEngageAbTestingAbTestVisitorToVariant] ADD CONSTRAINT [FK_umbracoEngageAbTestingAbTestVisitorToVariant_umbracoEngageAbTestingAbTestVariant]
        FOREIGN KEY ([abTestVariantId]) REFERENCES [umbracoEngageAbTestingAbTestVariant] ([id]) ON DELETE CASCADE;

    PRINT 'Batch 2 complete – AbTestVisitorToVariant FK added.';
END
GO

/* Batch 3: Create new nonclustered indexes */
IF EXISTS (SELECT 1 FROM [umbracoKeyValue] WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus' AND [value] = 'Pending')
BEGIN
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

    PRINT 'Batch 3 complete – new nonclustered indexes created.';
END
GO

/* Batch 4: Drop/recreate existing indexes (CLUSTERED → NONCLUSTERED, add INCLUDEs) */
IF EXISTS (SELECT 1 FROM [umbracoKeyValue] WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus' AND [value] = 'Pending')
BEGIN
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

    PRINT 'Batch 4 complete – existing indexes updated.';
END
GO

/* Batch 5: Update foreign keys to ON DELETE CASCADE */
IF EXISTS (SELECT 1 FROM [umbracoKeyValue] WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus' AND [value] = 'Pending')
BEGIN
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

    PRINT 'Batch 5 complete – foreign keys updated to ON DELETE CASCADE.';
END
GO

/* Batch 6: Update primary keys from NONCLUSTERED to CLUSTERED */
IF EXISTS (SELECT 1 FROM [umbracoKeyValue] WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus' AND [value] = 'Pending')
BEGIN
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

    PRINT 'Batch 6 complete – primary keys updated to CLUSTERED.';
END
GO

/* Finalize – mark migration as Complete */
IF EXISTS (SELECT 1 FROM [umbracoKeyValue] WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus' AND [value] = 'Pending')
BEGIN
    UPDATE [umbracoKeyValue] SET [value] = 'Complete' WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus';
    PRINT 'Migration script finished successfully - set status to Complete.';
END
ELSE IF NOT EXISTS (SELECT 1 FROM [umbracoKeyValue] WHERE [key] = 'Umbraco.Engage+DatabaseSchemaStatus' AND [value] = 'Complete')
BEGIN
    PRINT 'Migration was not in Pending state – no finalization performed.';
END
GO