-- PURPOSE: Rename the "uMarketingSuite" Media Folder to Engage
UPDATE [umbracoNode]
SET text = 'Engage'
WHERE nodeObjectType = 'B796F64C-1F99-4FFB-B886-4BF4BC011A9C' --Media Type
AND Text = 'uMarketingSuite' -- We can't go more specific than this as the node ID is different for each client.

-- PURPOSE: Renaming the DataTypeContainer & DataTypes to Engage
UPDATE [umbracoNode]
SET text = 'Engage'
WHERE nodeObjectType = '521231E3-8B37-469C-9F9D-51AFC91FEB7B' --DataTypeContainer Type
AND Text = 'uMarketingSuite' --In case some clients don't use uniqueId 'C883C2D6-E2FB-4AEA-8867-F0C71ACD5CAC'

--We can go more specific here as the node's uniqueId is the same for all clients.
UPDATE [umbracoNode]
SET text = 'Engage - Node Picker'
WHERE uniqueId = 'E5DAFA00-0393-4AE3-9734-4FF7BDEEF494'

UPDATE [umbracoNode]
SET text = 'Engage - Time Picker'
WHERE uniqueId = '19AEDD1B-3E4B-4E1D-B3DC-D34D6AB90754'

UPDATE [umbracoNode]
SET text = 'Engage - Customer Journey Group Color Picker'
WHERE uniqueId = '29AEDD1B-3E4B-4E1D-B3DC-D34D6AB90754'

UPDATE [umbracoNode]
SET text = 'Engage - Customer Journey Icon Picker'
WHERE uniqueId = '29AEDD2B-4E4C-4E1D-B3DC-D34D6AB90754'

UPDATE [umbracoNode]
SET text = 'Engage - Persona Group Color Picker'
WHERE uniqueId = '19AEDD1B-3E4B-4E1D-B3DC-C34D6AB90753'

UPDATE [umbracoNode]
SET text = 'Engage - Persona Icon Picker'
WHERE uniqueId = '49ADDD1B-4E3C-4E2D-B3DC-D24D6AB90756'

-- PURPOSE: Renaming the uMarketingSuite UserGroup to Engage
UPDATE dbo.[umbracoUserGroup2App]
SET app = 'engage'
WHERE app = 'uMarketingSuite'

-- PURPOSE: Check & Insert the KeyValue State's for Engage.
DECLARE @CurrentDateTime DATETIME = GETDATE();

-- Check for uMarketingSuite 2.6.1+ to Engage 13.0.0
IF EXISTS (
    SELECT 1
    FROM [umbracoKeyValue]
    WHERE [key] = 'Umbraco.Core.Upgrader.State+uMarketingSuite'
      AND [value] = 'SetRawCustomPageviewDataPkIndexToClustered'
)
    BEGIN
        -- Insert the new key-value pair
        INSERT INTO [umbracoKeyValue] ([key], [value], [updated])
        VALUES ('Umbraco.Core.Upgrader.State+Umbraco.Engage', 'SetupDataTypesAndSectionPermissions', @CurrentDateTime);
    END
ELSE
    BEGIN
        -- Raise an error if the condition is not met
        RAISERROR ('Cannot upgrade from this version of uMarketingSuite to Umbraco Engage. Minimum UMS version: 2.6.1', 16, 1);
    END;

-- Check for uMarketingSuite.Commerce 2.0.0+ to Engage.Commerce 13.0.0 (Only executes if it even exists)
IF EXISTS (
    SELECT 1
    FROM [umbracoKeyValue]
    WHERE [key] = 'Umbraco.Core.Upgrader.State+uMarketingSuite.UmbracoCommerce'
)
    BEGIN
        -- Key exists, now check if the value matches
        IF NOT EXISTS (
            SELECT 1
            FROM [umbracoKeyValue]
            WHERE [key] = 'Umbraco.Core.Upgrader.State+uMarketingSuite.UmbracoCommerce'
              AND [value] = 'CreateAnalyticsUmbracoCommerceVisitorOrderTable'
        )
            BEGIN
                -- Raise an error if the value does not match
                RAISERROR ('Cannot upgrade from this state of uMarketingSuite.Commerce to Umbraco.Engage.Commerce', 16, 1);
            END
        ELSE
            BEGIN
                -- Insert the new key-value pair if the value matches
                INSERT INTO [umbracoKeyValue] ([key], [value], [updated])
                VALUES ('Umbraco.Core.Upgrader.State+Umbraco.Engage.UmbracoCommerce', 'CreateAnalyticsUmbracoCommerceVisitorOrderTable', @CurrentDateTime);
            END
    END;

-- Check for uMarketingSuite.UmbracoForms 2.0.0+ to Engage.UmbracoForms 13.0.0 (Only executes if it even exists)
IF EXISTS ( 
    SELECT 1
    FROM [umbracoKeyValue]
    WHERE [key] = 'Umbraco.Core.Upgrader.State+uMarketingSuite.UmbracoForms'
)
    BEGIN
        -- Key exists, now check if the value matches
        IF NOT EXISTS (
            SELECT 1
            FROM [umbracoKeyValue]
            WHERE [key] = 'Umbraco.Core.Upgrader.State+uMarketingSuite.UmbracoForms'
              AND [value] = 'CreateAnalyticsUmbracoFormsSubmissionRecordTable'
        )
            BEGIN
                -- Raise an error if the value does not match
                RAISERROR ('Cannot upgrade from this state of uMarketingSuite.UmbracoForms to Umbraco.Engage.UmbracoForms', 16, 1);
            END
        ELSE
            BEGIN
                -- Insert the new key-value pair if the value matches
                INSERT INTO [umbracoKeyValue] ([key], [value], [updated])
                VALUES ('Umbraco.Core.Upgrader.State+Umbraco.Engage.UmbracoForms', 'CreateAnalyticsUmbracoFormsSubmissionRecordTable', @CurrentDateTime);
            END
    END;