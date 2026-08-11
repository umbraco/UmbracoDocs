-- Configure the maximum number of rows you want to delete in the first data cleanup operation
DECLARE @MaxNumberOfRows INT = 100000;

-- Get the DeleteAnalyticsDataAfterDays setting that deletes the maximum number of rows specified
DECLARE @CurrentUtcDate DATE = CONVERT(date, GETUTCDATE());
DECLARE @DeleteAnalyticsDataAfterDays INT = (
	SELECT DATEDIFF(day, CONVERT(date, [timestamp]), @CurrentUtcDate)
	FROM [umbracoEngageAnalyticsPageview]
	ORDER BY [timestamp] ASC
	OFFSET @MaxNumberOfRows ROWS
	FETCH NEXT 1 ROW ONLY
);

-- Return the recommended configuration value and details
-- Note: if the number of rows returned here is less than @MaxNumberOfRows, the next day may clean up more than @MaxNumberOfRows rows
SELECT
	@DeleteAnalyticsDataAfterDays AS DeleteAnalyticsDataAfterDays,
	DATEADD(day, -1 * @DeleteAnalyticsDataAfterDays, @CurrentUtcDate) AS DeleteBeforeTimestamp,
	COUNT([id]) AS NumberOfRows
FROM [umbracoEngageAnalyticsPageview]
WHERE [timestamp] < DATEADD(day, -1 * @DeleteAnalyticsDataAfterDays, @CurrentUtcDate);
