---
description: >-
  Checks that all Umbraco foreign key and check constraints on SQL Server are
  trusted.
tags:
  - ai-generated
---

# Untrusted Database Constraints

This health check only runs on SQL Server. It is not applicable when Umbraco is configured to use SQLite.

## What is an "untrusted" constraint?

On SQL Server, every foreign key and check constraint has a **trust flag**. The flag is tracked in the `sys.foreign_keys` and `sys.check_constraints` system catalog views. A constraint is trusted when SQL Server has verified that every existing row satisfies it. It becomes _untrusted_ when a constraint is added or re-enabled without validation. This typically happens via `WITH NOCHECK` or `NOCHECK CONSTRAINT`, or when a bulk operation inserts rows that bypass constraint checking.

Untrusted constraints are a problem for two reasons:

1. **The query optimizer cannot use them.** SQL Server relies on trusted constraints for join elimination, cardinality estimation, and index selection. Untrusted constraints force the optimizer to assume the worst case, resulting in slower queries. This is particularly visible on sites with large content trees.
2. **Data integrity is not guaranteed.** Because SQL Server has not verified existing rows, orphaned or invalid rows may be present in the database even though the constraint is (nominally) active.

Umbraco includes an upgrade-time migration (`RetrustForeignKeyAndCheckConstraints`, v17.3) that tries to re-trust all untrusted constraints on Umbraco tables automatically. If existing data violates a constraint, the migration cannot re-trust it. In that case, it logs a warning and moves on, leaving the issue for manual resolution. This health check surfaces that state.

## How to fix this health check

### 1. Identify the untrusted constraints

Both the health check report and the following query list the untrusted constraints on Umbraco tables:

```sql
SELECT 'Foreign key' AS ConstraintType, s.name AS SchemaName,
       OBJECT_NAME(fk.parent_object_id) AS TableName, fk.name AS ConstraintName
FROM sys.foreign_keys fk
INNER JOIN sys.schemas s ON fk.schema_id = s.schema_id
WHERE fk.is_not_trusted = 1
  AND (OBJECT_NAME(fk.parent_object_id) LIKE 'umbraco%' OR OBJECT_NAME(fk.parent_object_id) LIKE 'cms%')

UNION ALL

SELECT 'Check constraint', s.name,
       OBJECT_NAME(cc.parent_object_id), cc.name
FROM sys.check_constraints cc
INNER JOIN sys.schemas s ON cc.schema_id = s.schema_id
WHERE cc.is_not_trusted = 1
  AND (OBJECT_NAME(cc.parent_object_id) LIKE 'umbraco%' OR OBJECT_NAME(cc.parent_object_id) LIKE 'cms%');
```

### 2. Try to re-trust the constraint

For each constraint listed, attempt to re-trust it:

```sql
ALTER TABLE [<schema>].[<table>] WITH CHECK CHECK CONSTRAINT [<constraint name>];
```

For example:

```sql
ALTER TABLE [dbo].[umbracoRelation] WITH CHECK CHECK CONSTRAINT [FK_umbracoRelation_umbracoNode];
```

If the constraint holds for all existing data, the `ALTER TABLE` completes silently and the constraint is trusted again. Re-run the health check to confirm you are done.

If the data violates the constraint, SQL Server raises an error similar to:

```
The ALTER TABLE statement conflicted with the FOREIGN KEY constraint "FK_umbracoRelation_umbracoNode".
The conflict occurred in the database "Umbraco", table "dbo.umbracoNode", column 'id'.
```

In that case, continue with the steps below.

### 3. Find the offending rows

The error message tells you which column on which table references the missing parent. For a foreign key, the offending rows are those whose referenced value is missing from the parent table. Use `sys.foreign_key_columns` to find the exact column pair for the constraint:

```sql
SELECT
    OBJECT_NAME(fkc.parent_object_id)      AS ChildTable,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS ChildColumn,
    OBJECT_NAME(fkc.referenced_object_id)  AS ParentTable,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS ParentColumn
FROM sys.foreign_key_columns fkc
INNER JOIN sys.foreign_keys fk ON fk.object_id = fkc.constraint_object_id
WHERE fk.name = 'FK_umbracoRelation_umbracoNode';
```

Write a `LEFT JOIN` to list the orphaned rows. These are rows in the child table whose parent is missing:

```sql
-- Example using the columns reported above
SELECT child.*
FROM [umbracoRelation] child
LEFT JOIN [umbracoNode] parent ON parent.id = child.parentId
WHERE parent.id IS NULL;
```

Inspect the results. Decide whether the offending rows represent data you want to keep or stale rows that can be deleted. If the data should be kept, restore the missing parent rows instead.

### 4. Remove the offending rows

{% hint style="warning" %}
Always take a database backup before deleting data. The exact `DELETE` statement depends on your investigation above. The following are examples, not a prescription.
{% endhint %}

```sql
DELETE FROM [umbracoRelation]
WHERE parentId NOT IN (SELECT id FROM [umbracoNode]);
```

Or, targeting specific rows identified in step 3:

```sql
DELETE FROM [umbracoRelation] WHERE id IN (<list of ids>);
```

### 5. Re-trust the constraint

Now that the data is clean, the `ALTER TABLE` from step 2 should succeed:

```sql
ALTER TABLE [dbo].[umbracoRelation] WITH CHECK CHECK CONSTRAINT [FK_umbracoRelation_umbracoNode];
```

Verify:

```sql
SELECT name, is_not_trusted FROM sys.foreign_keys
WHERE name = 'FK_umbracoRelation_umbracoNode';
-- Expected: is_not_trusted = 0
```

### 6. Re-run the health check

Open the backoffice → **Settings → Health Check → Data Integrity** → **Untrusted database constraints**. The check should now report success. Repeat for any other constraints still listed.

## Check constraints

The steps above focus on foreign keys, which are by far the most common case. The same approach applies to untrusted check constraints. Find the expression defined by the constraint in `sys.check_constraints.definition`. Identify the rows that violate it, resolve or delete them, then re-run `ALTER TABLE ... WITH CHECK CHECK CONSTRAINT`.
