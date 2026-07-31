/*
    Umbraco Forms: correct system dates that were stored as local server time instead of UTC.

    This applies to sites that ran Umbraco Forms 17.0.0 to 17.2.x. In those versions the v17.0.0
    migration converted existing dates to UTC, but new rows were still written with local server
    time. Umbraco Forms 17.3.0 corrected the write path, so rows created from that deployment
    onwards are already UTC and must not be shifted again.

    SQL Server only. The AT TIME ZONE syntax is not supported by SQLite.

    Before you run this script:

    1. Take a database backup. Nothing in the schema records whether a row has already been
       shifted, so a repeated or partial run cannot be undone from the data alone.
    2. Set the three variables below.
    3. Read the notes at the end of this file.

    When the script completes it writes a marker to umbracoKeyValue. If that marker is already
    present, the script reports it and exits without changing any rows.
*/

SET XACT_ABORT ON

-- Your server's Windows time zone name, for example 'Romance Standard Time'.
DECLARE @TimeZone NVARCHAR(100) = 'Romance Standard Time'

-- The date you first upgraded to 17.0.0. Rows created before this date were already converted
-- to UTC by the MigrateSystemDatesToUtc migration.
DECLARE @UpgradeDate DATETIME = '2026-03-01'

-- The date you deployed 17.3.0 or later. Rows created on or after this date are already UTC.
DECLARE @FixDate DATETIME = '2026-04-23'

DECLARE @MarkerKey NVARCHAR(256) = 'Umbraco.Forms.UtcTimestampCorrection'

IF EXISTS (SELECT 1 FROM umbracoKeyValue WHERE [key] = @MarkerKey)
BEGIN
    PRINT 'This correction has already been applied to this database. No rows were changed.'
    RETURN
END

IF @FixDate <= @UpgradeDate
BEGIN
    PRINT 'Set @FixDate to a date later than @UpgradeDate. No rows were changed.'
    RETURN
END

-- Reports how many entries fall inside the affected window. Run this SELECT on its own first if
-- you want to confirm the window before writing anything.
SELECT
    COUNT(*) AS AffectedRecords,
    MIN(Created) AS EarliestAffected,
    MAX(Created) AS LatestAffected
FROM UFRecords
WHERE Created > @UpgradeDate AND Created < @FixDate

BEGIN TRANSACTION

-- Record tables
UPDATE UFRecords SET Created = Created AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Created > @UpgradeDate AND Created < @FixDate
UPDATE UFRecords SET Updated = Updated AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Updated > @UpgradeDate AND Updated < @FixDate
UPDATE UFRecordAudit SET UpdatedOn = UpdatedOn AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE UpdatedOn > @UpgradeDate AND UpdatedOn < @FixDate
UPDATE UFRecordWorkflowAudit SET ExecutedOn = ExecutedOn AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE ExecutedOn > @UpgradeDate AND ExecutedOn < @FixDate

-- Entity metadata tables
UPDATE UFPrevalueSource SET Created = Created AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Created > @UpgradeDate AND Created < @FixDate
UPDATE UFPrevalueSource SET Updated = Updated AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Updated > @UpgradeDate AND Updated < @FixDate
UPDATE UFWorkflows SET Created = Created AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Created > @UpgradeDate AND Created < @FixDate
UPDATE UFWorkflows SET Updated = Updated AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Updated > @UpgradeDate AND Updated < @FixDate
UPDATE UFDataSource SET Created = Created AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Created > @UpgradeDate AND Created < @FixDate
UPDATE UFDataSource SET Updated = Updated AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Updated > @UpgradeDate AND Updated < @FixDate
UPDATE UFFolders SET Created = Created AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Created > @UpgradeDate AND Created < @FixDate
UPDATE UFFolders SET Updated = Updated AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Updated > @UpgradeDate AND Updated < @FixDate
UPDATE UFForms SET Created = Created AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Created > @UpgradeDate AND Created < @FixDate
UPDATE UFForms SET Updated = Updated AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Updated > @UpgradeDate AND Updated < @FixDate

-- The Analytics charts are served from a pre-aggregated summary table, not from UFRecords
-- directly, and those rows were built from the incorrect timestamps. Deleting the affected days
-- makes the background task recalculate them from the corrected entries. Both tables hold only
-- values derived from UFRecords and UFRecordWorkflowAudit, so no data is lost.
-- The range extends one day past each boundary because a shifted entry can move across a day.
IF OBJECT_ID('UFAnalyticsDailySummary', 'U') IS NOT NULL
BEGIN
    DELETE FROM UFAnalyticsDailySummary
    WHERE [Date] >= DATEADD(DAY, -1, CAST(@UpgradeDate AS DATE))
      AND [Date] < DATEADD(DAY, 1, CAST(@FixDate AS DATE))

    DELETE FROM UFAnalyticsProcessedDates
    WHERE [Date] >= DATEADD(DAY, -1, CAST(@UpgradeDate AS DATE))
      AND [Date] < DATEADD(DAY, 1, CAST(@FixDate AS DATE))
END

INSERT INTO umbracoKeyValue ([key], [value], [updated])
VALUES (@MarkerKey, CONVERT(NVARCHAR(30), SYSUTCDATETIME(), 126), SYSUTCDATETIME())

COMMIT TRANSACTION

PRINT 'Correction applied. Restart the site so the analytics summary is rebuilt.'

/*
    Notes

    The UFRecordDataDateTime table is excluded on purpose. Those values are dates entered by the
    person filling in the form, not system dates. Shifting them would change the answer.

    The window boundaries are compared against the stored value, so entries within a few hours of
    either boundary can be judged incorrectly. Use the exact deployment times if you have them.

    The original MigrateSystemDatesToUtc migration converted the UFPrevalueSource Created and
    Updated columns twice. This was fixed in 17.3.0, but a site that ran 17.0 to 17.2 may hold
    double-converted values in those two columns that need correcting separately.

    After restarting, confirm the rebuild finished under
    Settings > Health Check > Forms > Analytics Processing. The rebuild does not run if analytics
    processing is disabled in configuration.
*/
