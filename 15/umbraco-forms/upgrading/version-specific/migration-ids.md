---
hidden: true
---

# Migration IDs

A unique **migration ID** is generated for each Umbraco Forms upgrade that requires a migration. The migration IDs are all listed in this article.

| Migration ID                         | Introduced In Version | Description                                                                        |
|--------------------------------------|-----------------------|------------------------------------------------------------------------------------|
| 7c7bc5ee-4c5b-42dc-9576-5ce6dfbddb8e | 10.0.0                | Installs Umbraco Forms.                                                            |
| 9f7e6fe6-bbd5-4b2b-8820-e9e0e36cc74c | 10.1.0                | Adds Culture column to Records table.                                              |
| 1a8f0d04-9396-40a2-9423-39fc9ae3828f | 10.1.0                | Adds a Record Workflow Audit table.                                                |
| 6e692c5d-c670-4c34-af17-28d8dbf0dcd2 | 10.1.0                | Adds an ExecutionStage column to the Record Workflow Audit table.                  |
| 5d84fee1-388c-4e5f-b98c-1e66947278f1 | 10.1.0                | No operation migration.                                                            |
| 22df962a-ae26-4bdd-b8fd-0513a9c636bf | 10.5.2/12.1.2         | Ensures the presence of an index on the FolderKey column in the Forms table.       |
| c3e657f6-3ae7-4ee9-b442-01702a41de9a | 12.2.0/13.0.0         | Adds a relation between content and forms.                                         |
| e0290a40-91c9-4acb-a7ca-d312037078f2 | 12.2.0/13.0.0         | Adds a NodeId column to Forms table                                                |
| 6f0eb771-6690-4b53-870a-f7dbb2785cac | 12.2.0/13.0.0         | Populates the NodeId column in the Forms table.                                    |
| 44949e12-e4ef-42c0-949b-67286b946fe0 | 12.2.0/13.0.0         | No operation migration.                                                            |
| 773ae769-00b7-4429-b7d5-de0fda0b4217 | 12.2.1/13.0.1         | Ensures the consistent key is used for the relation type between content and forms.|
| 55d53d2e-f795-42fb-9e77-8edfc6eed4aa | 13.2.0                | Adds an AdditionalData column to the Records table.                                |
| c74223ed-a554-4a14-a1f0-0477dce01ad6 | 14.0.0                | Updates the form picker property editor UI alias.                                  |
| a5ffa9a7-ca77-4a7c-a1e4-f32e25cde758 | 14.1.0                | Adds an AdditionalData column to the Records table.                                |
