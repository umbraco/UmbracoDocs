---
versionFrom: 8.0.0
meta.Title: "Umbraco Database"
meta.Description: "A guide to creating a custom Database table in Umbraco"
---

# Creating a custom Database table

In Umbraco it is possible to add custom database tables to your site if you want to store additional data. Below you will find an example that sets up a database table by registering a [component in a composer](../../Implementation/Composing/index.md) and then creating a migration plan and running the plan to add the database table to the database. The end result looks like this:

![Database result of a migration](images/db-table.png)

```csharp
using Umbraco.Core;
using Umbraco.Core.Logging;
using Umbraco.Core.Composing;
using Umbraco.Core.Migrations;
using Umbraco.Core.Migrations.Upgrade;
using Umbraco.Core.Scoping;
using Umbraco.Core.Services;
using NPoco;
using Umbraco.Core.Persistence.DatabaseAnnotations;

namespace Umbraco.Web.UI
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class BlogCommentsComposer : ComponentComposer<BlogCommentsComponent>
    {
    }

    public class BlogCommentsComponent : IComponent
    {
        private IScopeProvider _scopeProvider;
        private IMigrationBuilder _migrationBuilder;
        private IKeyValueService _keyValueService;
        private ILogger _logger;

        public BlogCommentsComponent(IScopeProvider scopeProvider, IMigrationBuilder migrationBuilder, IKeyValueService keyValueService, ILogger logger)
        {
            _scopeProvider = scopeProvider;
            _migrationBuilder = migrationBuilder;
            _keyValueService = keyValueService;
            _logger = logger;
        }

        public void Initialize()
        {
            // Create a migration plan for a specific project/feature
            // We can then track that latest migration state/step for this project/feature
            var migrationPlan = new MigrationPlan("BlogComments");

            // This is the steps we need to take
            // Each step in the migration adds a unique value
            migrationPlan.From(string.Empty)
                .To<AddCommentsTable>("blogcomments-db");

            // Go and upgrade our site (Will check if it needs to do the work or not)
            // Based on the current/latest step
            var upgrader = new Upgrader(migrationPlan);
            upgrader.Execute(_scopeProvider, _migrationBuilder, _keyValueService, _logger);
        }

        public void Terminate()
        {
        }
    }

    public class AddCommentsTable : MigrationBase
    {
        public AddCommentsTable(IMigrationContext context) : base(context)
        {
        }

        public override void Migrate()
        {
            Logger.Debug<AddCommentsTable>("Running migration {MigrationStep}", "AddCommentsTable");

            // Lots of methods available in the MigrationBase class - discover with this.
            if (TableExists("BlogComments") == false)
            {
                Create.Table<BlogCommentSchema>().Do();
            }
            else
            {
                Logger.Debug<AddCommentsTable>("The database table {DbTable} already exists, skipping", "BlogComments");
            }
        }

        [TableName("BlogComments")]
        [PrimaryKey("Id", AutoIncrement = true)]
        [ExplicitColumns]
        public class BlogCommentSchema
        {
            [PrimaryKeyColumn(AutoIncrement = true, IdentitySeed = 1)]
            [Column("Id")]
            public int Id { get; set; }

            [Column("BlogPostUmbracoId")]
            public int BlogPostUmbracoId { get; set; }

            [Column("Name")]
            public string Name { get; set; }

            [Column("Email")]
            public string Email { get; set; }

            [Column("Website")]
            public string Website { get; set; }

            [Column("Message")]
            [SpecialDbType(SpecialDbTypes.NTEXT)]
            public string Message { get; set; }
        }
    }
}
```

## Schema class and migrations

**Important!** It is important to note that the `BlogCommentSchema` class is purely used as a database schema representation and should not be used as a Data Transfer Object (DTO) to access the table data. Equally, you shouldn't use your DTOs to define the schema used by your migration, instead you should create a duplicate snapshot as demonstrated above specifically for the purpose of creating your database table.

Whilst this adds a level of duplication, it is important that migrations remain immutable. If the DTO was to be used for both, it could cause unexpected behaviour should you later modify your DTO but you have previous migrations that expect the DTO to be in its unmodified state.

Once a snapshot has been created, and once your code has been deployed, the snapshot should never be changed directly. Instead, you should use further migrations to alter the database table into the state you require. This ensures that migrations can always be run in sequence and that each migration can expect the database to be in a known state before executing.
