-- Correct post-v17 data that was stored with DateTime.Now instead of DateTime.UtcNow.
-- @TimeZone: your server Windows timezone name (e.g. Romance Standard Time)
-- @UpgradeDate: approximate date you first upgraded to v17.0.0
--               (rows BEFORE this date were already correctly migrated to UTC)

DECLARE @TimeZone NVARCHAR(100) = 'Romance Standard Time'
DECLARE @UpgradeDate DATETIME = '2026-03-01'

-- Record tables
UPDATE UFRecords SET Created = Created AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Created > @UpgradeDate
UPDATE UFRecords SET Updated = Updated AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Updated > @UpgradeDate
UPDATE UFRecordAudit SET UpdatedOn = UpdatedOn AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE UpdatedOn > @UpgradeDate
UPDATE UFRecordWorkflowAudit SET ExecutedOn = ExecutedOn AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE ExecutedOn > @UpgradeDate

-- Entity metadata tables
UPDATE UFPrevalueSource SET Created = Created AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Created > @UpgradeDate
UPDATE UFPrevalueSource SET Updated = Updated AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Updated > @UpgradeDate
UPDATE UFWorkflows SET Created = Created AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Created > @UpgradeDate
UPDATE UFWorkflows SET Updated = Updated AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Updated > @UpgradeDate
UPDATE UFDataSource SET Created = Created AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Created > @UpgradeDate
UPDATE UFDataSource SET Updated = Updated AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Updated > @UpgradeDate
UPDATE UFFolders SET Created = Created AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Created > @UpgradeDate
UPDATE UFFolders SET Updated = Updated AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Updated > @UpgradeDate
UPDATE UFForms SET Created = Created AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Created > @UpgradeDate
UPDATE UFForms SET Updated = Updated AT TIME ZONE @TimeZone AT TIME ZONE 'UTC' WHERE Updated > @UpgradeDate
