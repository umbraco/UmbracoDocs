---NOTE WHEN USING SEPARATE DATABASES FOR UMS & UMBRACO: THE FOLLOWING THREE CHECKS ARE TO BE EXECUTED ON THE UMBRACO DATABASE---

PRINT(N'---Running Version Pre-Requisite Checks for uMarketingSuite to Umbraco Engage Migration---');

-- Check for the uMarketingSuite package
IF EXISTS (
    SELECT 1
    FROM [umbracoKeyValue]
    WHERE [key] = 'Umbraco.Core.Upgrader.State+uMarketingSuite'
      AND [value] = 'SetRawCustomPageviewDataPkIndexToClustered'
)
    BEGIN
        PRINT(N'✔️ Detected uMarketingSuite version 2.6.1 or higher');
    END
ELSE
    BEGIN
        -- Raise an error if the condition is not met
        RAISERROR (N'❌ Cannot upgrade from this version of uMarketingSuite to Umbraco Engage. Minimum UMS version: 2.6.1', 16, 1);
    END;

-- Check for the uMarketingSuite.UmbracoCommerce package (Only executes if it even exists)
IF EXISTS (
    SELECT 1
    FROM [umbracoKeyValue]
    WHERE [key] = 'Umbraco.Core.Upgrader.State+uMarketingSuite.UmbracoCommerce'
)
    BEGIN
        -- Key exists, now check if the value matches
        IF EXISTS (
            SELECT 1
            FROM [umbracoKeyValue]
            WHERE [key] = 'Umbraco.Core.Upgrader.State+uMarketingSuite.UmbracoCommerce'
              AND [value] = 'CreateAnalyticsUmbracoCommerceVisitorOrderTable'
        )
            BEGIN
                PRINT(N'✔️ Detected uMarketingSuite.UmbracoCommerce version 2.0.0 or higher');
            END
        ELSE
            BEGIN
                PRINT(N'❌ Did not detect a valid version of uMarketingSuite.UmbracoCommerce installed. Please confirm that this is correct!');
            END
    END;

-- Check for the uMarketingSuite.UmbracoForms package (Only executes if it even exists)
IF EXISTS (
    SELECT 1
    FROM [umbracoKeyValue]
    WHERE [key] = 'Umbraco.Core.Upgrader.State+uMarketingSuite.UmbracoForms'
)
    BEGIN
        -- Key exists, now check if the value matches
        IF EXISTS (
            SELECT 1
            FROM [umbracoKeyValue]
            WHERE [key] = 'Umbraco.Core.Upgrader.State+uMarketingSuite.UmbracoForms'
              AND [value] = 'CreateAnalyticsUmbracoFormsSubmissionRecordTable'
        )
            BEGIN
                PRINT(N'✔️ Detected uMarketingSuite.UmbracoForms version 2.0.0 or higher');
            END
        ELSE
            BEGIN
                PRINT(N'❌ Did not detect a valid version of uMarketingSuite.UmbracoForms installed. Please confirm that this is correct!');
            END
    END;
    
---NOTE WHEN USING SEPARATE DATABASES FOR UMS & UMBRACO: THE FOLLOWING TWO CHECKS ARE TO BE EXECUTED ON THE UMARKETINGSUITE DATABASE---
PRINT(N'---Running Integrity Pre-Requisite Checks for uMarketingSuite to Umbraco Engage Migration---');


-- Check if the [uMarketingSuiteAnalyticsGoalCompletion] Table [visitorId] and [sessionSequenceNumber] columns are NOT NULL
-- This is done incrementally at runtime after updating to version 2.1.0+ until the process is completed.
IF EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'uMarketingSuiteAnalyticsGoalCompletion'
      AND COLUMN_NAME = 'visitorId'
      AND IS_NULLABLE = 'NO'
)
    AND EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'uMarketingSuiteAnalyticsGoalCompletion'
          AND COLUMN_NAME = 'sessionSequenceNumber'
          AND IS_NULLABLE = 'NO'
    )
    BEGIN
        PRINT(N'✔️ The [uMarketingSuiteAnalyticsGoalCompletion] table is in a valid state to be upgraded.');
    END
ELSE
    BEGIN
        -- Raise an error if the columns are not set to NOT NULL
        RAISERROR(N'❌ The uMarketingSuiteAnalyticsGoalCompletion table is in an invalid state to be upgraded', 16, 1);
        RAISERROR(N'❌ Please update to version 2.1.0+ of uMarketingSuite & allow it to run until the historical goal completion data migration has completed running in the background.', 16, 1);
        RAISERROR(N'❌ The Columns [visitorId] & [sessionSequenceNumber] on the [uMarketingSuiteAnalyticsGoalCompletion] table will be NOT NULL if the migration is done.', 16, 1);
    END;

-- Check if the [uMarketingSuiteAnalyticsPageEvent] Table [visitorId] and [sessionSequenceNumber] columns are NOT NULL
-- This is done incrementally at runtime after updating to version 2.1.0+ until the process is completed.
IF EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'uMarketingSuiteAnalyticsPageEvent'
      AND COLUMN_NAME = 'visitorId'
      AND IS_NULLABLE = 'NO'
)
    AND EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'uMarketingSuiteAnalyticsPageEvent'
          AND COLUMN_NAME = 'sessionSequenceNumber'
          AND IS_NULLABLE = 'NO'
    )
    BEGIN
        PRINT(N'✔️ The [uMarketingSuiteAnalyticsPageEvent] table is in a valid state to be upgraded.');
    END
ELSE
    BEGIN
        -- Raise an error if the columns are not set to NOT NULL
        RAISERROR(N'❌ The uMarketingSuiteAnalyticsPageEvent table is in an invalid state to be upgraded.', 16, 1);
        RAISERROR(N'❌ Please update to version 2.1.0+ of uMarketingSuite & allow it to run until the historical page event data migration has completed running in the background.', 16, 1);
        RAISERROR(N'❌ The Columns [visitorId] & [sessionSequenceNumber] on the [uMarketingSuiteAnalyticsPageEvent] table will be NOT NULL if the migration is done.', 16, 1);
    END;

PRINT(N'---Finished running Pre-Requisite Checks. Please verify if all 5 checks succeeded before proceeding---');
