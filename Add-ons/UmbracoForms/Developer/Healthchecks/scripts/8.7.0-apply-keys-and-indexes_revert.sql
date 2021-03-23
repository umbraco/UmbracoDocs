/*
 Reverts application of recommended primary keys, foreign keys and indexes to core Umbraco Forms tables.
 This reverts for SQL Server the migration AddRecordKeysAndIndexes and can be used for rolling that back in testing.
 */

-- Reverts addition of relationship between UFRecords and UFRecordFields.
ALTER TABLE dbo.UFRecordFields
DROP CONSTRAINT IF EXISTS FK_UFRecordFields_UFRecords_Record
GO

-- Reverts addition of primary keys to UFRecordData* tables.
ALTER TABLE dbo.UFRecordDataBit
DROP CONSTRAINT IF EXISTS PK_UFRecordDataBit
GO

ALTER TABLE dbo.UFRecordDataDateTime
DROP CONSTRAINT IF EXISTS PK_UFRecordDataDateTime
GO

ALTER TABLE dbo.UFRecordDataInteger
DROP CONSTRAINT IF EXISTS PK_UFRecordDataInteger
GO

ALTER TABLE dbo.UFRecordDataLongString
DROP CONSTRAINT IF EXISTS PK_UFRecordDataLongString
GO

-- Reverts addition of relationship between UFRecordFields and UFREcordData* tables.
ALTER TABLE dbo.UFRecordDataBit
DROP CONSTRAINT IF EXISTS FK_UFRecordDataBit_UFRecordFields_Key
GO

ALTER TABLE dbo.UFRecordDataDateTime
DROP CONSTRAINT IF EXISTS FK_UFRecordDataDateTime_UFRecordFields_Key
GO

ALTER TABLE dbo.UFRecordDataInteger
DROP CONSTRAINT IF EXISTS FK_UFRecordDataInteger_UFRecordFields_Key
GO

ALTER TABLE dbo.UFRecordDataLongString
DROP CONSTRAINT IF EXISTS FK_UFRecordDataLongString_UFRecordFields_Key
GO

-- Reverts adition of index on foreign key fields in UFREcordData* tables.
DROP INDEX IF EXISTS IX_UFRecordDataBit_Key ON dbo.UFRecordDataBit
GO

DROP INDEX IF EXISTS IX_UFRecordDataDateTime_Key ON dbo.UFRecordDataDateTime
GO

DROP INDEX IF EXISTS IX_UFRecordDataInteger_Key ON dbo.UFRecordDataInteger
GO

DROP INDEX IF EXISTS IX_UFRecordDataLongString_Key ON dbo.UFRecordDataLongString
GO

-- Reverts addition of primary key to UFUserSecurity
ALTER TABLE dbo.UFUserSecurity
DROP CONSTRAINT IF EXISTS PK_UFUserSecurity
GO

-- Reverts addition of primary key to UFUserFormSecurity
ALTER TABLE dbo.UFUserFormSecurity
DROP CONSTRAINT IF EXISTS PK_UFUserFormSecurity
GO

-- Reverts addition of unique constraint to UFUserFormSecurity across user/form fields.
ALTER TABLE dbo.UFUserFormSecurity
DROP CONSTRAINT IF EXISTS UK_UFUserFormSecurity_User_Form
GO
