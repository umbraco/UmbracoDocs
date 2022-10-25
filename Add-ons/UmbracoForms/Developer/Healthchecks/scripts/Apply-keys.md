---
meta.Title: "Apply keys and indexes"
---

# Apply keys and indexes

```sql
/*
 Applies recommended primary keys, foreign keys and indexes to core Umbraco Forms tables.
 This replicates for SQL Server the migration AddRecordKeysAndIndexes.
 */

-- Adds relationship between UFRecords and UFRecordFields.
ALTER TABLE dbo.UFRecordFields
ADD CONSTRAINT
	FK_UFRecordFields_UFRecords_Record FOREIGN KEY
	(
	Record
	) REFERENCES dbo.UFRecords
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

-- Adds primary keys to UFRecordData* tables.
ALTER TABLE dbo.UFRecordDataBit
ADD CONSTRAINT
	PK_UFRecordDataBit PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

ALTER TABLE dbo.UFRecordDataDateTime
ADD CONSTRAINT
	PK_UFRecordDataDateTime PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

ALTER TABLE dbo.UFRecordDataInteger
ADD CONSTRAINT
	PK_UFRecordDataInteger PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

ALTER TABLE dbo.UFRecordDataLongString
ADD CONSTRAINT
	PK_UFRecordDataLongString PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

-- Adds relationship between UFRecordFields and UFREcordData* tables.
ALTER TABLE dbo.UFRecordDataBit
ADD CONSTRAINT
	FK_UFRecordDataBit_UFRecordFields_Key FOREIGN KEY
	(
	[Key]
	) REFERENCES dbo.UFRecordFields
	(
	[Key]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

ALTER TABLE dbo.UFRecordDataDateTime
ADD CONSTRAINT
	FK_UFRecordDataDateTime_UFRecordFields_Key FOREIGN KEY
	(
	[Key]
	) REFERENCES dbo.UFRecordFields
	(
	[Key]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

ALTER TABLE dbo.UFRecordDataInteger
ADD CONSTRAINT
	FK_UFRecordDataInteger_UFRecordFields_Key FOREIGN KEY
	(
	[Key]
	) REFERENCES dbo.UFRecordFields
	(
	[Key]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

ALTER TABLE dbo.UFRecordDataLongString
ADD CONSTRAINT
	FK_UFRecordDataLongString_UFRecordFields_Key FOREIGN KEY
	(
	[Key]
	) REFERENCES dbo.UFRecordFields
	(
	[Key]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

-- Adds index on foreign key fields in UFREcordData* tables.
CREATE NONCLUSTERED INDEX IX_UFRecordDataBit_Key ON dbo.UFRecordDataBit
(
	[Key] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX IX_UFRecordDataDateTime_Key ON dbo.UFRecordDataDateTime
(
	[Key] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX IX_UFRecordDataInteger_Key ON dbo.UFRecordDataInteger
(
	[Key] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX IX_UFRecordDataLongString_Key ON dbo.UFRecordDataLongString
(
	[Key] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

-- Adds primary key to UFUserSecurity.
ALTER TABLE dbo.UFUserSecurity
ADD CONSTRAINT
	PK_UFUserSecurity PRIMARY KEY CLUSTERED 
	(
	[User]
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

-- Adds primary key to UFUserFormSecurity.
ALTER TABLE dbo.UFUserFormSecurity
ADD CONSTRAINT
	PK_UFUserFormSecurity PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

-- Adds unique constraint to UFUserFormSecurity across user/form fields.
ALTER TABLE dbo.UFUserFormSecurity
ADD CONSTRAINT UK_UFUserFormSecurity_User_Form UNIQUE NONCLUSTERED 
(
	[User] ASC,
	[Form] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
```

## Revert application of keys and indexes

```sql
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

-- Reverts addition of index on foreign key fields in UFREcordData* tables.
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
```
