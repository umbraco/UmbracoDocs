---
versionFrom: 8.0.0
meta.Title: "Umbraco Database"
meta.Description: "A guide to creating a custom Database table in Umbraco"
---

# Creating a custom Database table

In Umbraco it is possible to add custom database tables to your site if you want to store additional data that should not be stored as normal content nodes. Below you will find an example that sets up a database table by registering a [component in a composer](../../Implementation/Composing/index.md) and then creating a migration plan and running the plan to add the database table to the database. The end result looks like this:

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

**Important!** It is important to note that the `BlogCommentSchema` class nested inside the migration is purely used as a database schema representation class and should not be used as a Data Transfer Object (DTO) to access the table data. Equally, you shouldn't use your DTO classes to define the schema used by your migration. Instead you should create a duplicate snapshot as demonstrated above specifically for the purpose of creating or working with your database tables in the current migration. The name of the class is not important as you will be overriding it using the TableName attribute. So you should choose a name that makes it clear for you and everyone else that this class is purely for defining the schema in this migration.

Whilst this adds a level of duplication, it is important that migrations and the code/classes within a migration remain immutable. If the DTO was to be used for both, it could cause unexpected behaviour should you later modify your DTO used in your application but you have previous migrations expecting the DTO to be in its unmodified state.

Once a snapshot has been created, and once your code has been deployed, the snapshot should never be changed directly. Instead, you should use further migrations to alter the database table into the state you require. This ensures that migrations can always be run in sequence and that each migration can expect the database to be in a known state before executing.

When adding further migrations it is also important to note that if you need to reuse the schema class, it can be a good idea to duplicate this again in those particular migrations. You want the migrations to be immutable, so having separate classes in separate namespaces, reduces the risk of modifying a schema class from your initial migration.

## Data stored in custom database tables

When storing data in custom database tables, this is by default not manageable by Umbraco at all. This can be great for many purposes such as storing massive amounts of data that you do not need to edit from inside the Umbraco backoffice. Decoupling part of your data from being managed by Umbraco as content can be a way of achieving better performance for your site. That way, it will no longer take up space in indexes and caches, and the Umbraco database which may not have the best structure for your type of data.

This however also means that if you do need to edit or display this data, it is up to you to implement the underlying functionality supporting this.

It also means that if you need this data to be transferred or kept synchronized between multiple sites or environments, it is up to you to handle this. Data stored in custom tables are not supported out of the box by add-ons such as Umbraco Deploy or Umbraco Courier and therefore will not be deployable by default.

Figuring out how to manage data across multiple environments can be very different between individual sites and there is not one solution that fits all. Some sites may have automated database synchronization set up to ensure specific tables in multiple databases are always kept in sync, while others may be better off with scripts moving data around manually on demand.
