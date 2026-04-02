-- =============================================================================
-- Umbraco Engage: Deduplicate page variants
-- =============================================================================
-- Versions 16.x and 17.x had a bug that inserted a new page variant row for
-- each pageview instead of reusing existing ones. This script consolidates
-- duplicates by reassigning pageviews to the canonical (lowest-id) variant
-- and deleting the leftover rows.
--
-- NOTE: Run this during a maintenance window or low-traffic period.
-- The UPDATE on umbracoEngageAnalyticsPageview can take a while on
-- installations with a large number of pageviews.
-- =============================================================================

-- Step 1: Reassign pageviews from duplicate variants to the canonical variant
UPDATE pv
SET pv.[umbracoPageVariantId] = canonical.[id]
FROM [umbracoEngageAnalyticsPageview] pv
INNER JOIN [umbracoEngageAnalyticsUmbracoPageVariant] dupVariant
    ON pv.[umbracoPageVariantId] = dupVariant.[id]
INNER JOIN (
    SELECT
        MIN([id]) AS [id],
        [nodeId],
        [culture],
        [segment],
        [contentTypeId]
    FROM [umbracoEngageAnalyticsUmbracoPageVariant]
    GROUP BY [nodeId], [culture], [segment], [contentTypeId]
) canonical
    ON dupVariant.[nodeId] = canonical.[nodeId]
    AND dupVariant.[culture] = canonical.[culture]
    AND ISNULL(dupVariant.[segment], '') = ISNULL(canonical.[segment], '')
    AND ISNULL(dupVariant.[contentTypeId], -1) = ISNULL(canonical.[contentTypeId], -1)
WHERE dupVariant.[id] <> canonical.[id];

-- Step 2: Delete orphaned duplicate variants that no longer have any pageviews
DELETE v
FROM [umbracoEngageAnalyticsUmbracoPageVariant] v
WHERE NOT EXISTS (
    SELECT 1 FROM [umbracoEngageAnalyticsPageview] pv
    WHERE pv.[umbracoPageVariantId] = v.[id]
)
AND EXISTS (
    SELECT 1 FROM [umbracoEngageAnalyticsUmbracoPageVariant] canonical
    WHERE canonical.[nodeId] = v.[nodeId]
    AND canonical.[culture] = v.[culture]
    AND ISNULL(canonical.[segment], '') = ISNULL(v.[segment], '')
    AND ISNULL(canonical.[contentTypeId], -1) = ISNULL(v.[contentTypeId], -1)
    AND canonical.[id] < v.[id]
);

PRINT 'Deduplication complete.';
